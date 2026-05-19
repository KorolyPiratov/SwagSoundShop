package SwagSoundShop.controller;

import SwagSoundShop.dto.request.CustomerRequest;
import SwagSoundShop.model.Customer;
import SwagSoundShop.repository.CustomerRepository;
import SwagSoundShop.service.CustomerService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/customers")
@RequiredArgsConstructor
public class CustomerController {

    private final CustomerService customerService;
    private final CustomerRepository customerRepository;

    @GetMapping
    public ResponseEntity<List<Customer>> getAll() {
        return ResponseEntity.ok(customerService.getAll());
    }

    @GetMapping("/{id}")
    public ResponseEntity<Customer> getById(@PathVariable Long id) {
        return ResponseEntity.ok(customerService.getById(id));
    }

    @PostMapping("/public")
    public ResponseEntity<Customer> createPublic(@RequestBody CustomerRequest request) {
        // Проверяем есть ли уже клиент с таким email
        return customerRepository.findByEmail(request.getEmail())
                .map(ResponseEntity::ok)
                .orElseGet(() -> ResponseEntity.ok(customerService.create(request)));
    }

    @PutMapping("/{id}")
    public ResponseEntity<Customer> update(@PathVariable Long id,
                                           @RequestBody CustomerRequest request) {
        return ResponseEntity.ok(customerService.update(id, request));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> delete(@PathVariable Long id) {
        customerService.delete(id);
        return ResponseEntity.noContent().build();
    }
}