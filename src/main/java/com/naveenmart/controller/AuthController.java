package com.naveenmart.controller;

import com.naveenmart.model.User; import com.naveenmart.repository.UserRepository; import com.naveenmart.config.PasswordService; import jakarta.servlet.http.HttpSession; import org.springframework.http.*; import org.springframework.web.bind.annotation.*; import java.util.*;

@RestController @RequestMapping("/api/auth")
public class AuthController {
 private final UserRepository users; private final PasswordService encoder; public AuthController(UserRepository u,PasswordService e){users=u;encoder=e;}
 @PostMapping("/login") public ResponseEntity<?> login(@RequestBody Map<String,String> b,HttpSession s){String email=b.getOrDefault("email","").trim().toLowerCase(),pass=b.getOrDefault("password","");User u=users.findByEmail(email);if(u==null||!encoder.matches(pass,u.getPasswordHash()))return ResponseEntity.status(401).body(Map.of("message","Invalid email or password"));s.setAttribute("userId",u.getId());return ResponseEntity.ok(publicUser(u));}
 @PostMapping("/register") public ResponseEntity<?> register(@RequestBody Map<String,String> b,HttpSession s){String email=b.getOrDefault("email","").trim().toLowerCase();if(email.isBlank()||b.getOrDefault("password","").length()<6||b.getOrDefault("fullName","").isBlank())return ResponseEntity.badRequest().body(Map.of("message","Name, email and password (6+ characters) are required"));if(users.findByEmail(email)!=null)return ResponseEntity.status(409).body(Map.of("message","Email already registered"));User u=new User();u.setFullName(b.get("fullName"));u.setEmail(email);u.setPhone(b.get("phone"));u.setAddress(b.get("address"));u.setPasswordHash(encoder.hash(b.get("password")));users.create(u);s.setAttribute("userId",u.getId());return ResponseEntity.status(201).body(publicUser(u));}
 @PostMapping("/logout") public Map<String,Object> logout(HttpSession s){s.invalidate();return Map.of("success",true);}
 @GetMapping("/me") public ResponseEntity<?> me(HttpSession s){User u=current(s);return u==null?ResponseEntity.status(401).body(Map.of("message","Not logged in")):ResponseEntity.ok(publicUser(u));}
 @PutMapping("/me") public ResponseEntity<?> update(@RequestBody Map<String,String>b,HttpSession s){User u=current(s);if(u==null)return ResponseEntity.status(401).body(Map.of("message","Not logged in"));users.updateDetails(u.getId(),b.getOrDefault("fullName",u.getFullName()),b.getOrDefault("phone",u.getPhone()),b.getOrDefault("address",u.getAddress()));return ResponseEntity.ok(publicUser(users.findById(u.getId())));}
 @GetMapping("/users") public ResponseEntity<?> all(HttpSession s){User u=current(s);if(u==null||!"ADMIN".equals(u.getRole()))return ResponseEntity.status(403).body(Map.of("message","Admin access required"));return ResponseEntity.ok(users.findAll().stream().map(this::publicUser).toList());}
 public User current(HttpSession s){Object id=s.getAttribute("userId");return id==null?null:users.findById(Long.parseLong(id.toString()));}
 private Map<String,Object> publicUser(User u){return Map.of("id",u.getId(),"fullName",u.getFullName(),"email",u.getEmail(),"phone",Objects.toString(u.getPhone(),""),"address",Objects.toString(u.getAddress(),""),"role",u.getRole());}
}
