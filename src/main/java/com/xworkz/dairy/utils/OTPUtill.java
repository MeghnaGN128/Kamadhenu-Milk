package com.xworkz.dairy.utils;

import java.security.SecureRandom;

public class OTPUtill {

    private static final SecureRandom random = new SecureRandom();

    public static String generateNumericOtp(int length) {
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i < length; i++) {
            sb.append(random.nextInt(10));
        }
        return sb.toString();
    }
}
