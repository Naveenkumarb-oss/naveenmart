package com.naveenmart.repository;

import com.naveenmart.model.User;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import java.util.*;

@Repository
public class UserRepository {
 private final JdbcTemplate jdbc; public UserRepository(JdbcTemplate jdbc){this.jdbc=jdbc;}
 private User map(java.sql.ResultSet r,int n)throws java.sql.SQLException{User u=new User();u.setId(r.getLong("id"));u.setFullName(r.getString("full_name"));u.setEmail(r.getString("email"));u.setPhone(r.getString("phone"));u.setAddress(r.getString("address"));u.setPasswordHash(r.getString("password_hash"));u.setRole(r.getString("role"));return u;}
 public User findByEmail(String email){return jdbc.query("select * from users where email=?",this::map,email).stream().findFirst().orElse(null);}
 public User findById(long id){return jdbc.query("select * from users where id=?",this::map,id).stream().findFirst().orElse(null);}
 public User create(User u){Long id=jdbc.queryForObject("insert into users(full_name,email,phone,address,password_hash,role) values(?,?,?,?,?,?)",Long.class,u.getFullName(),u.getEmail(),u.getPhone(),u.getAddress(),u.getPasswordHash(),"CUSTOMER");u.setId(id);u.setRole("CUSTOMER");return u;}
 public List<User> findAll(){return jdbc.query("select * from users order by id desc",this::map);}
 public void updateDetails(long id,String name,String phone,String address){jdbc.update("update users set full_name=?,phone=?,address=? where id=?",name,phone,address,id);}
}
