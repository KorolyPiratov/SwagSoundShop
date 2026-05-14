package SwagSoundShop.repository;

import SwagSoundShop.model.Order;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface OrderRepository extends JpaRepository<Order, Long> {
    List<Order> findByCustomerId(Long customerId);
    List<Order> findByEmployeeId(Long employeeId);
    List<Order> findByStatus(Order.OrderStatus status);
}