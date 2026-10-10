package com.naveenmart.config;

import org.springframework.stereotype.Service;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import java.nio.charset.StandardCharsets;
import java.security.SecureRandom;
import java.util.Base64;

@Service
public class PasswordService {
    private static final int ITERATIONS = 120000, KEY_BITS = 256;
    public String hash(String password) {
        byte[] salt = new byte[16]; new SecureRandom().nextBytes(salt);
        return encode(password, salt, ITERATIONS);
    }
    public boolean matches(String password, String stored) {
        try { String[] p=stored.split("\\$"); if(p.length!=5||!p[0].equals("pbkdf2")) return false; byte[] salt=Base64.getDecoder().decode(p[3]); byte[] expected=Base64.getDecoder().decode(p[4]); byte[] actual=derive(password.toCharArray(),salt,Integer.parseInt(p[2])); return java.security.MessageDigest.isEqual(actual,expected); } catch(Exception e){return false;}
    }
    private String encode(String password,byte[] salt,int iterations){return "pbkdf2$sha256$"+iterations+"$"+Base64.getEncoder().encodeToString(salt)+"$"+Base64.getEncoder().encodeToString(derive(password.toCharArray(),salt,iterations));}
    private byte[] derive(char[] password,byte[] salt,int iterations){try{return SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256").generateSecret(new PBEKeySpec(password,salt,iterations,KEY_BITS)).getEncoded();}catch(Exception e){throw new IllegalStateException(e);}}
}
