package SwagSoundShop.service;

import SwagSoundShop.dto.request.PaymentRequest;
import SwagSoundShop.model.Order;
import SwagSoundShop.model.Payment;
import SwagSoundShop.repository.OrderRepository;
import SwagSoundShop.repository.PaymentRepository;
import lombok.RequiredArgsConstructor;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;

@Service
@RequiredArgsConstructor
public class PaymentService {

    private final PaymentRepository paymentRepository;
    private final OrderRepository orderRepository;

    public List<Payment> getAll() {
        return paymentRepository.findAll();
    }

    public List<Payment> getWithFilters(LocalDateTime dateFrom, LocalDateTime dateTo,
                                        Payment.PaymentMethod method,
                                        Payment.PaymentStatus status,
                                        BigDecimal amountMin, BigDecimal amountMax) {
        return paymentRepository.findAll().stream()
                .filter(p -> dateFrom == null || (p.getPaidAt() != null && !p.getPaidAt().isBefore(dateFrom)))
                .filter(p -> dateTo == null || (p.getPaidAt() != null && !p.getPaidAt().isAfter(dateTo)))
                .filter(p -> method == null || p.getMethod() == method)
                .filter(p -> status == null || p.getStatus() == status)
                .filter(p -> amountMin == null || p.getAmount().compareTo(amountMin) >= 0)
                .filter(p -> amountMax == null || p.getAmount().compareTo(amountMax) <= 0)
                .collect(java.util.stream.Collectors.toList());
    }

    public Payment create(PaymentRequest request) {
        Order order = orderRepository.findById(request.getOrderId())
                .orElseThrow(() -> new RuntimeException("Order not found"));

        Payment payment = Payment.builder()
                .order(order)
                .amount(request.getAmount())
                .method(request.getMethod())
                .status(Payment.PaymentStatus.PAID)
                .paidAt(LocalDateTime.now())
                .build();

        order.setStatus(Order.OrderStatus.PAID);
        orderRepository.save(order);

        return paymentRepository.save(payment);
    }

    public byte[] exportToExcel(LocalDateTime dateFrom, LocalDateTime dateTo,
                                Payment.PaymentMethod method,
                                Payment.PaymentStatus status,
                                BigDecimal amountMin, BigDecimal amountMax)
            throws IOException {

        List<Payment> payments = getWithFilters(
                dateFrom, dateTo, method, status, amountMin, amountMax);

        try (Workbook workbook = new XSSFWorkbook()) {
            Sheet sheet = workbook.createSheet("Payments");

            CellStyle headerStyle = workbook.createCellStyle();
            Font font = workbook.createFont();
            font.setBold(true);
            headerStyle.setFont(font);

            Row header = sheet.createRow(0);
            String[] columns = {"ID", "Order ID", "Customer", "Amount",
                    "Method", "Status", "Date"};
            for (int i = 0; i < columns.length; i++) {
                Cell cell = header.createCell(i);
                cell.setCellValue(columns[i]);
                cell.setCellStyle(headerStyle);
            }

            int rowNum = 1;
            for (Payment p : payments) {
                Row row = sheet.createRow(rowNum++);
                row.createCell(0).setCellValue(p.getId());
                row.createCell(1).setCellValue(p.getOrder().getId());
                row.createCell(2).setCellValue(
                        p.getOrder().getCustomer().getFirstName() + " " +
                                p.getOrder().getCustomer().getLastName());
                row.createCell(3).setCellValue(p.getAmount().doubleValue());
                row.createCell(4).setCellValue(p.getMethod().name());
                row.createCell(5).setCellValue(p.getStatus().name());
                row.createCell(6).setCellValue(
                        p.getPaidAt() != null ? p.getPaidAt().toString() : "");
            }

            for (int i = 0; i < columns.length; i++) {
                sheet.autoSizeColumn(i);
            }

            ByteArrayOutputStream out = new ByteArrayOutputStream();
            workbook.write(out);
            return out.toByteArray();
        }
    }
}