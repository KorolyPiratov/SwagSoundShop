package SwagSoundShop.dto.request;

import lombok.Data;

@Data
public class CardRequest {
    private String cardNumber;
    private String holderName;
    private String expiry;
}