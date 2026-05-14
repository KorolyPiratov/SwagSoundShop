package SwagSoundShop.service;

import SwagSoundShop.dto.request.CartRequest;
import SwagSoundShop.model.*;
import SwagSoundShop.repository.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
@RequiredArgsConstructor
public class CartService {

    private final CartRepository cartRepository;
    private final CartItemRepository cartItemRepository;
    private final CustomerRepository customerRepository;
    private final ProductRepository productRepository;

    public Cart getByCustomer(Long customerId) {
        return cartRepository.findByCustomerId(customerId)
                .orElseGet(() -> {
                    Customer customer = customerRepository.findById(customerId)
                            .orElseThrow(() -> new RuntimeException("Customer not found"));
                    Cart cart = Cart.builder().customer(customer).build();
                    return cartRepository.save(cart);
                });
    }

    public Cart addItem(Long customerId, CartRequest request) {
        Cart cart = getByCustomer(customerId);
        Product product = productRepository.findById(request.getProductId())
                .orElseThrow(() -> new RuntimeException("Product not found"));

        cartItemRepository.findByCartIdAndProductId(cart.getId(), product.getId())
                .ifPresentOrElse(
                        item -> {
                            item.setQuantity(item.getQuantity() + request.getQuantity());
                            cartItemRepository.save(item);
                        },
                        () -> {
                            CartItem item = CartItem.builder()
                                    .cart(cart)
                                    .product(product)
                                    .quantity(request.getQuantity())
                                    .build();
                            cartItemRepository.save(item);
                        }
                );

        return cartRepository.findById(cart.getId()).orElseThrow();
    }

    public void removeItem(Long cartItemId) {
        cartItemRepository.deleteById(cartItemId);
    }

    @Transactional
    public void clearCart(Long customerId) {
        Cart cart = getByCustomer(customerId);
        cartItemRepository.deleteByCartId(cart.getId());
    }
}