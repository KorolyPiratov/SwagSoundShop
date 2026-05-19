package SwagSoundShop.dto.request;

import lombok.Data;

@Data
public class CustomerAuthRequest {
    private String firstName;
    private String lastName;
    private String email;
    private String phone;
    private String password;
}