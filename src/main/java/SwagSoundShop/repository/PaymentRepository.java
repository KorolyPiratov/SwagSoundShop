package SwagSoundShop.repository;

import SwagSoundShop.model.Payment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import java.math.BigDecimal;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public interface PaymentRepository extends JpaRepository<Payment, Long> {
    Optional<Payment> findByOrderId(Long orderId);

    @Query("SELECT p FROM Payment p WHERE " +
            "(:dateFrom IS NULL OR p.paidAt >= :dateFrom) AND " +
            "(:dateTo IS NULL OR p.paidAt <= :dateTo) AND " +
            "(:method IS NULL OR p.method = :method) AND " +
            "(:status IS NULL OR p.status = :status) AND " +
            "(:amountMin IS NULL OR p.amount >= :amountMin) AND " +
            "(:amountMax IS NULL OR p.amount <= :amountMax)")
    List<Payment> findWithFilters(
            @Param("dateFrom") LocalDateTime dateFrom,
            @Param("dateTo") LocalDateTime dateTo,
            @Param("method") Payment.PaymentMethod method,
            @Param("status") Payment.PaymentStatus status,
            @Param("amountMin") BigDecimal amountMin,
            @Param("amountMax") BigDecimal amountMax
    );
}