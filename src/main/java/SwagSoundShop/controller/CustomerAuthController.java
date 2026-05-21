package SwagSoundShop.controller;

import SwagSoundShop.dto.request.CardRequest;
import SwagSoundShop.dto.request.CustomerAuthRequest;
import SwagSoundShop.dto.response.AuthResponse;
import SwagSoundShop.model.*;
import SwagSoundShop.repository.*;
import SwagSoundShop.security.JwtTokenProvider;
import SwagSoundShop.service.CustomerAuthService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;

@RestController
@RequestMapping("/api/customer-auth")
@RequiredArgsConstructor
public class CustomerAuthController {

    private final CustomerAuthService customerAuthService;
    private final CustomerRepository customerRepository;
    private final FavoriteRepository favoriteRepository;
    private final ProductRepository productRepository;
    private final OrderRepository orderRepository;
    private final JwtTokenProvider jwtTokenProvider;
    private final CardRepository cardRepository;
    private final org.springframework.security.crypto.password.PasswordEncoder passwordEncoder;

    @PostMapping("/register")
    public ResponseEntity<AuthResponse> register(@RequestBody CustomerAuthRequest request) {
        return ResponseEntity.ok(customerAuthService.register(request));
    }

    @PostMapping("/login")
    public ResponseEntity<AuthResponse> login(@RequestBody CustomerAuthRequest request) {
        return ResponseEntity.ok(customerAuthService.login(request));
    }

    @GetMapping("/profile")
    public ResponseEntity<Customer> getProfile(@RequestHeader("Authorization") String authHeader) {
        String token = authHeader.substring(7);
        String email = jwtTokenProvider.getEmailFromToken(token);
        Customer customer = customerRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("Покупатель не найден"));
        return ResponseEntity.ok(customer);
    }

    @PutMapping("/profile")
    public ResponseEntity<Customer> updateProfile(
            @RequestHeader("Authorization") String authHeader,
            @RequestBody CustomerAuthRequest request) {
        String token = authHeader.substring(7);
        String email = jwtTokenProvider.getEmailFromToken(token);
        Customer customer = customerRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("Покупатель не найден"));
        customer.setFirstName(request.getFirstName());
        customer.setLastName(request.getLastName());
        customer.setPhone(request.getPhone());
        customerRepository.save(customer);
        return ResponseEntity.ok(customer);
    }

    @GetMapping("/orders")
    public ResponseEntity<List<Order>> getOrders(
            @RequestHeader("Authorization") String authHeader) {
        String token = authHeader.substring(7);
        String email = jwtTokenProvider.getEmailFromToken(token);
        Customer customer = customerRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("Покупатель не найден"));
        return ResponseEntity.ok(orderRepository.findByCustomerId(customer.getId()));
    }

    @GetMapping("/favorites")
    public ResponseEntity<List<Favorite>> getFavorites(
            @RequestHeader("Authorization") String authHeader) {
        String token = authHeader.substring(7);
        String email = jwtTokenProvider.getEmailFromToken(token);
        Customer customer = customerRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("Покупатель не найден"));
        return ResponseEntity.ok(favoriteRepository.findByCustomerId(customer.getId()));
    }

    @PostMapping("/favorites/{productId}")
    public ResponseEntity<Void> addFavorite(
            @RequestHeader("Authorization") String authHeader,
            @PathVariable Long productId) {
        String token = authHeader.substring(7);
        String email = jwtTokenProvider.getEmailFromToken(token);
        Customer customer = customerRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("Покупатель не найден"));
        Product product = productRepository.findById(productId)
                .orElseThrow(() -> new RuntimeException("Товар не найден"));

        if (favoriteRepository.findByCustomerIdAndProductId(
                customer.getId(), productId).isEmpty()) {
            Favorite favorite = Favorite.builder()
                    .customer(customer)
                    .product(product)
                    .build();
            favoriteRepository.save(favorite);
        }
        return ResponseEntity.ok().build();
    }

    @DeleteMapping("/favorites/{productId}")
    public ResponseEntity<Void> removeFavorite(
            @RequestHeader("Authorization") String authHeader,
            @PathVariable Long productId) {
        String token = authHeader.substring(7);
        String email = jwtTokenProvider.getEmailFromToken(token);
        Customer customer = customerRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("Покупатель не найден"));
        favoriteRepository.deleteByCustomerIdAndProductId(customer.getId(), productId);
        return ResponseEntity.ok().build();
    }

    @GetMapping("/cards")
    public ResponseEntity<List<Card>> getCards(
            @RequestHeader("Authorization") String authHeader) {
        String email = jwtTokenProvider.getEmailFromToken(authHeader.substring(7));
        Customer customer = customerRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("Покупатель не найден"));
        return ResponseEntity.ok(cardRepository.findByCustomerId(customer.getId()));
    }

    @PostMapping("/cards")
    public ResponseEntity<Card> addCard(
            @RequestHeader("Authorization") String authHeader,
            @RequestBody CardRequest request) {
        String email = jwtTokenProvider.getEmailFromToken(authHeader.substring(7));
        Customer customer = customerRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("Покупатель не найден"));

        String number = request.getCardNumber().replaceAll("\\s+", "");
        String lastFour = number.substring(number.length() - 4);
        String cardType = number.startsWith("4") ? "VISA" :
                number.startsWith("5") ? "MASTERCARD" : "OTHER";
        String cardHash = passwordEncoder.encode(number);

        Card card = Card.builder()
                .customer(customer)
                .lastFour(lastFour)
                .holderName(request.getHolderName().toUpperCase())
                .expiry(request.getExpiry())
                .cardType(cardType)
                .cardHash(cardHash)
                .build();

        return ResponseEntity.ok(cardRepository.save(card));
    }

    @DeleteMapping("/cards/{cardId}")
    public ResponseEntity<Void> deleteCard(
            @RequestHeader("Authorization") String authHeader,
            @PathVariable Long cardId) {
        String email = jwtTokenProvider.getEmailFromToken(authHeader.substring(7));
        Customer customer = customerRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("Покупатель не найден"));
        Card card = cardRepository.findById(cardId)
                .orElseThrow(() -> new RuntimeException("Карта не найдена"));
        if (!card.getCustomer().getId().equals(customer.getId())) {
            return ResponseEntity.status(403).build();
        }
        cardRepository.deleteById(cardId);
        return ResponseEntity.ok().build();
    }
}