package SwagSoundShop.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "cards")
@Getter @Setter
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class Card {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "customer_id", nullable = false)
    @JsonIgnore
    private Customer customer;

    @Column(name = "last_four", nullable = false)
    private String lastFour;

    @Column(name = "holder_name", nullable = false)
    private String holderName;

    @Column(nullable = false)
    private String expiry;

    @Column(name = "card_type", nullable = false)
    private String cardType;

    @JsonIgnore
    @Column(name = "card_hash", nullable = false)
    private String cardHash;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
    }
}