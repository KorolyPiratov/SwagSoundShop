package SwagSoundShop.security;

import SwagSoundShop.model.Employee;
import SwagSoundShop.repository.EmployeeRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.*;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
@RequiredArgsConstructor
public class UserDetailsServiceImpl implements UserDetailsService {

    private final EmployeeRepository employeeRepository;

    @Override
    public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
        Employee employee = employeeRepository.findByEmail(email)
                .orElseThrow(() -> new UsernameNotFoundException("Employee not found: " + email));

        return new org.springframework.security.core.userdetails.User(
                employee.getEmail(),
                employee.getPassword(),
                List.of(new SimpleGrantedAuthority("ROLE_" + employee.getRole().name()))
        );
    }
}