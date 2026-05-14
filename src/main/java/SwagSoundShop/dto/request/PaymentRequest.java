package SwagSoundShop.dto.request;

import SwagSoundShop.model.Payment;
import lombok.Data;
import java.math.BigDecimal;

@Data
public class PaymentRequest {
    private Long orderId;
    private BigDecimal amount;
    private Payment.PaymentMethod method;
}