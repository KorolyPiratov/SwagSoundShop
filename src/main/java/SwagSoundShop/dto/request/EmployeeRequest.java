package SwagSoundShop.dto.request;

import SwagSoundShop.model.Employee;
import lombok.Data;

@Data
public class EmployeeRequest {
    private String firstName;
    private String lastName;
    private String email;
    private String password;
    private String phone;
    private Employee.Role role;
}