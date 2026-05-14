package SwagSoundShop.controller;

import SwagSoundShop.dto.request.CartRequest;
import SwagSoundShop.model.Cart;
import SwagSoundShop.service.CartService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/cart")
@RequiredArgsConstructor
public class CartController {

    private final CartService cartService;

    @GetMapping("/{customerId}")
    public ResponseEntity<Cart> getCart(@PathVariable Long customerId) {
        return ResponseEntity.ok(cartService.getByCustomer(customerId));
    }

    @PostMapping("/{customerId}/items")
    public ResponseEntity<Cart> addItem(@PathVariable Long customerId,
                                        @RequestBody CartRequest request) {
        return ResponseEntity.ok(cartService.addItem(customerId, request));
    }

    @DeleteMapping("/items/{cartItemId}")
    public ResponseEntity<Void> removeItem(@PathVariable Long cartItemId) {
        cartService.removeItem(cartItemId);
        return ResponseEntity.noContent().build();
    }

    @DeleteMapping("/{customerId}/clear")
    public ResponseEntity<Void> clearCart(@PathVariable Long customerId) {
        cartService.clearCart(customerId);
        return ResponseEntity.noContent().build();
    }
}