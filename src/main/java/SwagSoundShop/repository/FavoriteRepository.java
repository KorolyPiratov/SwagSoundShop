package SwagSoundShop.repository;

import SwagSoundShop.model.Favorite;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;
import java.util.Optional;
import org.springframework.transaction.annotation.Transactional;

public interface FavoriteRepository extends JpaRepository<Favorite, Long> {
    List<Favorite> findByCustomerId(Long customerId);
    Optional<Favorite> findByCustomerIdAndProductId(Long customerId, Long productId);
    @Transactional
    void deleteByCustomerIdAndProductId(Long customerId, Long productId);
}