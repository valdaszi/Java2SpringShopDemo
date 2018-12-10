package lt.bta.java2.repositories;

import lt.bta.java2.model.Cart;
import org.springframework.data.repository.CrudRepository;

import java.util.Optional;

public interface CartRepository extends CrudRepository<Cart, Integer> {

    Optional<Cart> findByUserId(int userId);

}
