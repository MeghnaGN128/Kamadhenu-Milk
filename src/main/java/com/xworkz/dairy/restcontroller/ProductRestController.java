package com.xworkz.dairy.restcontroller;


import com.xworkz.dairy.service.ProductService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Slf4j
@RestController
@RequestMapping("/")
public class ProductRestController {
    @Autowired
    private ProductService productService;

    public ProductRestController(){
        log.info("ProductListRestController constructor");
    }

    @GetMapping("/productList")
    public ResponseEntity<List<String>> getProductList(){

        log.info("getProductList method in productListRestController");
        List<String> list=productService.productListForBuyer();
        log.info("list: "+list);
        return ResponseEntity.ok(list);
    }

    @GetMapping("/checkProductName")
    public ResponseEntity<Boolean> checkProduct(@RequestParam String productName) {
        log.info("checkProduct method in ProductListRestController");
        return ResponseEntity.ok(productService.checkProductExists(productName));
    }

    @GetMapping("/getMilkPrice")
    public ResponseEntity<Double> getMilkPrice(@RequestParam String productType)
    {
        log.info("getMilkPrice method in ProductListRestController");
        return ResponseEntity.ok(productService.getProductPrice(productType));
    }

    @GetMapping("/productDashboard/checkProductName")
    public ResponseEntity<Boolean> checkProductName(@RequestParam String productName) {
        log.info("checkProductName method in ProductListRestController");

        return ResponseEntity.ok(productService.checkProductExistsByName(productName));
    }

}
