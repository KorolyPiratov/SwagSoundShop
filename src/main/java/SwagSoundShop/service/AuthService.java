package SwagSoundShop.service;

import SwagSoundShop.dto.request.LoginRequest;
import SwagSoundShop.dto.response.AuthResponse;
import SwagSoundShop.model.Employee;
import SwagSoundShop.repository.EmployeeRepository;
import SwagSoundShop.security.JwtTokenProvider;
import lombok.RequiredArgsConstructor;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AuthService {

    private final AuthenticationManager authenticationManager;
    private final JwtTokenProvider jwtTokenProvider;
    private final EmployeeRepository employeeRepository;

    public AuthResponse login(LoginRequest request) {
        Authentication authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(
                        request.getEmail(),
                        request.getPassword()
                )
        );

        Employee employee = employeeRepository.findByEmail(request.getEmail())
                .orElseThrow(() -> new RuntimeException("Employee not found"));

        String token = jwtTokenProvider.generateToken(
                employee.getEmail(),
                employee.getRole().name()
        );

        return new AuthResponse(token, employee.getEmail(), employee.getRole().name());
    }
}