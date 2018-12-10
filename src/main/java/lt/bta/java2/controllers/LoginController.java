package lt.bta.java2.controllers;

import lt.bta.java2.model.Cart;
import lt.bta.java2.model.User;
import lt.bta.java2.repositories.CartRepository;
import lt.bta.java2.repositories.UserRepository;
import lt.bta.java2.session.Data;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.view.RedirectView;

import java.util.ArrayList;

@Controller
public class LoginController {

    final private UserRepository userRepository;

    final private Data data;

    final private CartRepository cartRepository;


    @Autowired
    public LoginController(UserRepository userRepository, Data data, CartRepository cartRepository) {
        this.userRepository = userRepository;
        this.data = data;
        this.cartRepository = cartRepository;
    }

    @GetMapping("/login")
    public String login() {
        return "login";
    }

    @PostMapping("/login")
    public RedirectView login(@RequestParam String username, @RequestParam String password) {
        User user = this.userRepository.findByUsername(username);
        if (user != null) {
            if (BCrypt.checkpw(password, user.getPassword())) {
                // sutvarkome userio duomenis sesijoje ir krepseli
                loggedIn(user);
                return new RedirectView("/", true);
            }
        }
        // Jei kazkas buvo negerai tai vel rodome "login"
        return new RedirectView("/login?error", true);
    }

    @GetMapping("/logout")
    public RedirectView logout() {
        this.data.clear();
        return new RedirectView("/login?logout", true);
    }

    @GetMapping("/register")
    public String register() {
        return "register";
    }

    @PostMapping("/register")
    public RedirectView register(@RequestParam String username, @RequestParam String password) {
        User user = this.userRepository.findByUsername(username);
        if (user != null) {
            return new RedirectView("/register?exists", true);
        }
        user = new User();
        user.setUsername(username);
        user.setPassword(BCrypt.hashpw(password, BCrypt.gensalt()));
        user = this.userRepository.save(user);

        // sutvarkome userio duomenis sesijoje ir krepseli
        loggedIn(user);

        return new RedirectView("/", true);
    }

    /**
     * sutvarkome userio duomenis sesijoje ir krepseli
     * butinai reikia pazymeti metoda kaip '@Transactional'
     * nes hibernate neistraukia krepselio (cart) prekiu (cartItemList)
     */
    @Transactional
    protected void loggedIn(User user) {
        // atsimenam prisijungusio userio duomenis
        this.data.setLogged(true);
        this.data.setUserId(user.getId());
        this.data.setUsername(user.getUsername());

        // tikriname ar yra issaugotas userio krepselis pagal user id, jei ne tai kuriame nauja krepseli
        Cart cart = this.cartRepository.findByUserId(user.getId()).orElse(new Cart());
        // jei krepselis naujas tai issaugojam, nes reikia tureti jo id
        if (cart.getId() == null) {
            cart.setUser(user);
            this.cartRepository.save(cart);
        }

        // issaugojam DB krepseli su sesijos prekemis, pries tai sesijos krepselio prekems priskirdami krepseli (cart)
        this.data.getCartItemList().forEach(c -> c.setCart(cart));
        if (cart.getCartItems() == null) cart.setCartItems(new ArrayList<>());
        cart.getCartItems().addAll(this.data.getCartItemList());
        this.cartRepository.save(cart);

        // issaugojam krepseli ir jo id sesijoje:
        this.data.setCartItemList(new ArrayList<>());
        this.data.getCartItemList().addAll(cart.getCartItems());
        this.data.setCartId(cart.getId());
    }
}
