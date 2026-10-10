package com.naveenmart.repository;

import com.naveenmart.model.Product;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import java.util.*;

@Repository
public class ProductRepository {
 private final JdbcTemplate jdbc; public ProductRepository(JdbcTemplate jdbc){this.jdbc=jdbc;}
 private Product map(java.sql.ResultSet r,int n)throws java.sql.SQLException{Product p=new Product();p.setId(r.getLong("id"));p.setName(r.getString("name"));p.setPrice(r.getBigDecimal("price"));p.setQuantity(r.getInt("quantity"));p.setCategory(r.getString("category"));p.setDescription(r.getString("description"));p.setImageUrl(r.getString("image_url"));return p;}
 public List<Product> findAll(){return jdbc.query("select * from products order by id desc",this::map);}
 public Product findById(long id){return jdbc.query("select * from products where id=?",this::map,id).stream().findFirst().orElse(null);}
 public Product save(Product p){Long id=jdbc.queryForObject("insert into products(name,price,quantity,category,description,image_url) values(?,?,?,?,?,?)",Long.class,p.getName(),p.getPrice(),p.getQuantity(),p.getCategory(),p.getDescription(),p.getImageUrl());p.setId(id);return p;}
 public boolean delete(long id){return jdbc.update("delete from products where id=?",id)>0;}
}
