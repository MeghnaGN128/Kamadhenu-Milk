package com.xworkz.dairy.service;

import com.xworkz.dairy.configuration.EmailConfiguration;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.stereotype.Service;


@Service
public class EmailSenderImpl implements EmailSender {
    @Autowired
    private EmailConfiguration config;


    @Override
    public boolean mailSend(String email, String otp) {
        try {


            System.out.println("mailSend method");
            SimpleMailMessage simpleMailMessage = new SimpleMailMessage();
            simpleMailMessage.setFrom("ninganurmeghna@gmail.com");
            simpleMailMessage.setTo(email);
            simpleMailMessage.setSubject("Otp to user for verification");
            simpleMailMessage.setText("Otp for verification " + otp);
            config.mailSender().send(simpleMailMessage);
            System.out.println("mail sent to :" + email + " - OTP : " + otp);
            return true;
        } catch (Exception e) {
            System.out.println(e.getMessage());
            return false;
        }
    }
}
