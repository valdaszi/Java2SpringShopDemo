package lt.bta.java2.controllers;

import lt.bta.java2.model.Product;
import lt.bta.java2.repositories.ProductRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;

@Controller
@RequestMapping("/product")
public class ProductController {

    final private ProductRepository productRepository;

    final private HttpServletRequest request;

    @Autowired
    public ProductController(ProductRepository productRepository, HttpServletRequest request) {
        this.productRepository = productRepository;
        this.request = request;
    }

    @GetMapping("/update/{id}")
    public ModelAndView update(@PathVariable int id) {
        Product product = productRepository.findById(id).orElse(null);
        if (product != null) {
            return new ModelAndView("update-product", "product", product);
        }
        return new ModelAndView("home");
    }

    @PostMapping("/update/{id}")
    public RedirectView update(@PathVariable int id, @RequestParam(required = false) String name, @RequestParam MultipartFile file) {
        Product product = productRepository.findById(id).orElse(null);
        if (product != null) {
            if (name != null) {
                product.setName(name);
            }
            if (!file.isEmpty()) {
                try {
                    String uploadsDir = "/images/";
                    String realPathtoUploads = request.getServletContext().getRealPath(uploadsDir);
                    if(! new File(realPathtoUploads).exists()) {
                        new File(realPathtoUploads).mkdir();
                    }
                    String orgName = file.getOriginalFilename();
                    String filePath = realPathtoUploads + orgName;
                    File dest = new File(filePath);
                    file.transferTo(dest);

                    product.setImage(orgName);

                } catch (IOException e) {
                    e.printStackTrace();
                }
            }

            productRepository.save(product);
        }
        return new RedirectView("/", true);
    }
}
