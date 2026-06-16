package com.it.aqisys.util;

import com.it.aqisys.execption.AQIException;
import com.it.aqisys.result.ResultCodeEnum;
import io.jsonwebtoken.*;
import io.jsonwebtoken.security.Keys;

import javax.crypto.SecretKey;
import java.util.Date;

public class JwtUtil {
    private static SecretKey secretKey = Keys.hmacShaKeyFor("Wdy8P37F7PdRH3npeyjTr85wBrk5JWyWw2R5".getBytes());
    public static String createToken(Long userId,String username){

        String jwt = Jwts.builder()
                .setExpiration(new Date(System.currentTimeMillis() + 3600000))
                .setSubject("LOGIN_USER")
                .claim("userId", userId)
                .claim("username", username)
                .signWith(secretKey, SignatureAlgorithm.HS256)
                .compact();
        return jwt;
    }
    public static Claims parseToken(String token){
        if(token == null){
            throw new AQIException(ResultCodeEnum.ADMIN_LOGIN_AUTH);
        }

        try{
            JwtParser jwtParser = Jwts.parser().setSigningKey(secretKey).build();
            Jws<Claims> claimsJws = jwtParser.parseClaimsJws(token);
            Claims body = claimsJws.getBody();
            return body;
        }catch (ExpiredJwtException e){
            throw new AQIException(ResultCodeEnum.TOKEN_EXPIRED);
        }catch(JwtException e){
            throw new AQIException(ResultCodeEnum.TOKEN_INVALID);
        }
    }

    public static void main(String[] args) {
        System.out.println(createToken(8L, "18182216883"));
    }
}
