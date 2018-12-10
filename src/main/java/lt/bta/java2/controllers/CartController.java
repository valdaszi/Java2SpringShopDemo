package lt.bta.java2.controllers;

import lt.bta.java2.model.Cart;
import lt.bta.java2.model.CartItem;
import lt.bta.java2.model.Product;
import lt.bta.java2.repositories.CartRepository;
import lt.bta.java2.repositories.ProductRepository;
import lt.bta.java2.session.Data;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import java.math.BigDecimal;
import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

@Controller
@RequestMapping("/cart")
public class CartController {

    final private ProductRepository productRepository;

    final private Data data;

    final private CartRepository cartRepository;


    public CartController(ProductRepository productRepository, Data data, CartRepository cartRepository) {
        this.productRepository = productRepository;
        this.data = data;
        this.cartRepository = cartRepository;
    }

    @GetMapping("/add")
    public RedirectView addProduct(@RequestParam int id) {
        Optional<Product> product = productRepository.findById(id);
        if (product.isPresent()) {

            CartItem cartItem = data.getCartItemList()
                    .stream()
                    .filter(x -> x.getProduct().getId() == id)
                    .findAny()
                    .orElse(null);

            if (cartItem != null) {
                cartItem.setQuantity(cartItem.getQuantity() + 1);
            } else {
                cartItem = new CartItem();
                cartItem.setProduct(product.get());
                cartItem.setPrice(product.get().getPrice());
                cartItem.setQuantity(1);
                data.getCartItemList().add(cartItem);
            }
        }
        return new RedirectView("/", true);
    }

    @GetMapping(value = "/api/add", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    @ResponseBody
    public ResponseEntity apiAddProduct(@RequestParam int id) {
        Optional<Product> product = productRepository.findById(id);

        if (!product.isPresent()) return ResponseEntity.notFound().build();

        CartItem cartItem = new CartItem();
        cartItem.setProduct(product.get());
        cartItem.setPrice(product.get().getPrice());
        cartItem.setQuantity(1);

        // jei turime DB krepselio id tai atsimename preke ir jame
        if (this.data.getCartId() != null) {
            this.cartRepository.findById(this.data.getCartId()).ifPresent(cart -> {
                cartItem.setCart(cart);
                cart.getCartItems().add(cartItem);
                this.cartRepository.save(cart);
            });
        }

        // atsimename preke sesijos krepselyje
        data.getCartItemList().add(cartItem);

        return ResponseEntity.ok(data.getCartItemList().size());
    }

    @GetMapping(value = "/api/size", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    @ResponseBody
    public ResponseEntity apiCartSize() {
        return ResponseEntity.ok(data.getCartItemList().size());
    }

    @GetMapping
    public ModelAndView showCart() {
        Map<String, Object> map = new HashMap<>();
        map.put("items", data.getCartItemList());
        map.put("total", data.getCartItemList().stream().map(CartItem::getPrice).reduce(BigDecimal.ZERO, BigDecimal::add));

        //return new ModelAndView("cart", "items", data.getCartItemList());
        return new ModelAndView("cart", map);
    }
}
