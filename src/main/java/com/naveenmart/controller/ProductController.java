package com.naveenmart.controller;

import com.naveenmart.model.Product; import com.naveenmart.repository.ProductRepository; import jakarta.servlet.http.HttpSession; import org.springframework.http.*; import org.springframework.web.bind.annotation.*; import java.util.*;

@RestController @RequestMapping("/api/products")
public class ProductController {
 private final ProductRepository repo; private final AuthController auth; public ProductController(ProductRepository r,AuthController a){repo=r;auth=a;}
 @GetMapping public List<Product> getProducts(){return repo.findAll();}
 @GetMapping("/{id}") public ResponseEntity<?> getProduct(@PathVariable long id){Product p=repo.findById(id);return p==null?ResponseEntity.notFound().build():ResponseEntity.ok(p);}
 @PostMapping public ResponseEntity<?> add(@RequestBody Product p,HttpSession s){if(!admin(s))return ResponseEntity.status(403).body(Map.of("message","Admin access required"));validate(p);return ResponseEntity.status(201).body(repo.save(p));}
 @DeleteMapping("/{id}") public ResponseEntity<?> delete(@PathVariable long id,HttpSession s){if(!admin(s))return ResponseEntity.status(403).body(Map.of("message","Admin access required"));if(!repo.delete(id))return ResponseEntity.notFound().build();return ResponseEntity.ok(Map.of("success",true));}
 private boolean admin(HttpSession s){var u=auth.current(s);return u!=null&&"ADMIN".equals(u.getRole());}
 private void validate(Product p){if(p.getName()==null||p.getName().isBlank()||p.getPrice()==null||p.getPrice().signum()<0||p.getQuantity()==null||p.getQuantity()<0||p.getCategory()==null||p.getCategory().isBlank())throw new IllegalArgumentException("Name, price, quantity and category are required");}
}
