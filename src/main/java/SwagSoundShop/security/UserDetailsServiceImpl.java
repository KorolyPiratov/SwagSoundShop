package SwagSoundShop.security;

import SwagSoundShop.repository.CustomerRepository;
import SwagSoundShop.repository.EmployeeRepository;
import SwagSoundShop.model.Employee;
import SwagSoundShop.model.Customer;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.*;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
@RequiredArgsConstructor
public class UserDetailsServiceImpl implements UserDetailsService {

    private final EmployeeRepository employeeRepository;
    private final CustomerRepository customerRepository;

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        // Сначала ищем среди сотрудников
        var employee = employeeRepository.findByEmail(email);
        if (employee.isPresent()) {
            Employee emp = employee.get();
            return new org.springframework.security.core.userdetails.User(
                    emp.getEmail(),
                    emp.getPassword(),
                    List.of(new SimpleGrantedAuthority("ROLE_" + emp.getRole().name()))
            );
        }

        // Затем среди покупателей
        Customer customer = customerRepository.findByEmail(email)
                .orElseThrow(() -> new UsernameNotFoundException("User not found: " + email));

        return new org.springframework.security.core.userdetails.User(
                customer.getEmail(),
                customer.getPassword() != null ? customer.getPassword() : "",
                List.of(new SimpleGrantedAuthority("ROLE_CUSTOMER"))
        );
    }
}