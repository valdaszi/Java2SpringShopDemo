package lt.bta.java2.controllers;

import lt.bta.java2.model.Product;
import lt.bta.java2.repositories.ProductRepository;
import lt.bta.java2.session.Data;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/")
public class HomeController {

    final private Data data;

    final private ProductRepository productRepository;

    @Autowired
    public HomeController(Data data, ProductRepository productRepository) {
        this.data = data;
        this.productRepository = productRepository;
    }

    @GetMapping
    public ModelAndView home(
            @RequestParam(required = false, defaultValue = "1") int page,
            @RequestParam(required = false, defaultValue = "10") int size) {

        // galima butu tikrinti ar prisijunges ir jei ne tai rodyti login forma
        //if (!data.isLogged()) return new ModelAndView("login");

        Page<Product> pageResponse = productRepository.findAll(PageRequest.of(page - 1, size));

        Map<String, Object> map = new HashMap<>();
        // sesijos duomenys:
        map.put("data", this.data);
        // produktu sarasas:
        map.put("products", pageResponse.getContent());
        // lenteles irasu numeravimui reikalingi duomenys:
        map.put("offset", pageResponse.getPageable().getOffset());
        // puslapiavimui reikalingi duomenys:
        map.put("pagingUrl", "");
        map.put("pageNumber", pageResponse.getPageable().getPageNumber() + 1);
        map.put("totalPages", pageResponse.getTotalPages());

        return new ModelAndView("home", map);
    }

}
