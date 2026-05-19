package SwagSoundShop.service;

import SwagSoundShop.dto.request.CustomerAuthRequest;
import SwagSoundShop.dto.response.AuthResponse;
import SwagSoundShop.model.Customer;
import SwagSoundShop.repository.CustomerRepository;
import SwagSoundShop.security.JwtTokenProvider;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class CustomerAuthService {

    private final CustomerRepository customerRepository;
    private final PasswordEncoder passwordEncoder;
    private final JwtTokenProvider jwtTokenProvider;

    public AuthResponse register(CustomerAuthRequest request) {
        if (customerRepository.existsByEmail(request.getEmail())) {
            throw new RuntimeException("Email уже зарегистрирован");
        }

        Customer customer = Customer.builder()
                .firstName(request.getFirstName())
                .lastName(request.getLastName())
                .email(request.getEmail())
                .phone(request.getPhone())
                .password(passwordEncoder.encode(request.getPassword()))
                .build();

        customerRepository.save(customer);

        String token = jwtTokenProvider.generateToken(customer.getEmail(), "CUSTOMER");
        return new AuthResponse(token, customer.getEmail(), "CUSTOMER");
    }

    public AuthResponse login(CustomerAuthRequest request) {
        Customer customer = customerRepository.findByEmail(request.getEmail())
                .orElseThrow(() -> new RuntimeException("Покупатель не найден"));

        if (customer.getPassword() == null ||
                !passwordEncoder.matches(request.getPassword(), customer.getPassword())) {
            throw new RuntimeException("Неверный пароль");
        }

        String token = jwtTokenProvider.generateToken(customer.getEmail(), "CUSTOMER");
        return new AuthResponse(token, customer.getEmail(), "CUSTOMER");
    }
}