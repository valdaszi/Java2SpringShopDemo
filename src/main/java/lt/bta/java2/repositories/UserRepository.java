package lt.bta.java2.repositories;

import lt.bta.java2.model.User;
import org.springframework.data.repository.PagingAndSortingRepository;

public interface UserRepository extends PagingAndSortingRepository<User, Integer> {

    User findByUsername(String username);

}
