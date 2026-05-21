package SwagSoundShop.service;

import SwagSoundShop.dto.request.OrderRequest;
import SwagSoundShop.model.*;
import SwagSoundShop.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Service
@RequiredArgsConstructor
public class OrderService {

    private final OrderRepository orderRepository;
    private final OrderItemRepository orderItemRepository;
    private final CustomerRepository customerRepository;
    private final ProductRepository productRepository;
    private final PaymentRepository paymentRepository;

    public List<Order> getAll() {
        return orderRepository.findAll();
    }

    public Order getById(Long id) {
        return orderRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Order not found: " + id));
    }

    public List<Order> getByCustomer(Long customerId) {
        return orderRepository.findByCustomerId(customerId);
    }

    @Transactional
    public Order create(OrderRequest request) {
        Customer customer = customerRepository.findById(request.getCustomerId())
                .orElseThrow(() -> new RuntimeException("Customer not found"));

        Order order = Order.builder()
                .customer(customer)
                .status(Order.OrderStatus.NEW)
                .totalAmount(BigDecimal.ZERO)
                .build();

        order = orderRepository.save(order);

        List<OrderItem> items = new ArrayList<>();
        BigDecimal total = BigDecimal.ZERO;

        for (var itemReq : request.getItems()) {
            Product product = productRepository.findById(itemReq.getProductId())
                    .orElseThrow(() -> new RuntimeException("Product not found"));

            if (product.getStockQuantity() < itemReq.getQuantity()) {
                throw new RuntimeException("Insufficient stock for: " + product.getName());
            }

            product.setStockQuantity(product.getStockQuantity() - itemReq.getQuantity());
            productRepository.save(product);

            OrderItem item = OrderItem.builder()
                    .order(order)
                    .product(product)
                    .quantity(itemReq.getQuantity())
                    .unitPrice(product.getPrice())
                    .build();

            items.add(orderItemRepository.save(item));
            total = total.add(product.getPrice()
                    .multiply(BigDecimal.valueOf(itemReq.getQuantity())));
        }

        order.setItems(items);
        order.setTotalAmount(total);
        order = orderRepository.save(order);

        // Определяем метод оплаты
        Payment.PaymentMethod method = Payment.PaymentMethod.CASH;
        try {
            if (request.getPaymentMethod() != null) {
                method = Payment.PaymentMethod.valueOf(request.getPaymentMethod());
            }
        } catch (Exception ignored) {}

        boolean isOnline = method == Payment.PaymentMethod.ONLINE;

        // Автоматически создаём платёж
        Payment payment = Payment.builder()
                .order(order)
                .amount(total)
                .method(method)
                .status(isOnline ? Payment.PaymentStatus.PAID : Payment.PaymentStatus.PENDING)
                .paidAt(isOnline ? LocalDateTime.now() : null)
                .build();
        paymentRepository.save(payment);

        // Если онлайн — сразу помечаем заказ как оплаченный
        if (isOnline) {
            order.setStatus(Order.OrderStatus.PAID);
            order = orderRepository.save(order);
        }

        return order;
    }

    public Order updateStatus(Long id, Order.OrderStatus status) {
        Order order = getById(id);
        order.setStatus(status);
        return orderRepository.save(order);
    }
}