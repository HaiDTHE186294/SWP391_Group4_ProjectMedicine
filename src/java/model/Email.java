/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author trant
 */
public class Email {
    private final String eFrom = "tranthingocanh04hk@gmail.com";
    private final String ePass = "reit urjr qgda svfr";

    public boolean sendEmail(String subject, String messgage, String to) {
        try {

        } catch (Exception e) {
        }
        // Properties
        Properties props = new Properties();

        //Su dung server nao de gui mail- smtp host
        props.put("mail.smtp.host", "smtp.gmail.com");

        // TLS 587 SSL 465
        props.put("mail.smtp.port", "smtp.gmail.com");

        // dang nhap
        props.put("mail.smtp.auth", "true");

        props.put("mail.smtp.starttls.enable", "true");

        //dang nhap tai khoan
        Authenticator au = new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(eFrom, ePass);
            }

        };
        // phien lam viec
        Session session = Session.getInstance(props, au);

        try {
            MimeMessage msg = new MimeMessage(session);
            msg.addHeader("Content-type", "text/HTML, charset=UTF-8");
            msg.setFrom(new InternetAddress(eFrom));
            msg.setRecipients(Message.RecipientType.TO, InternetAddress.parse(to, false));
            // tieu de
            msg.setSubject(subject, "UTF-8");
            // Noi dung
            msg.setContent(messgage, "text/html; charset=UTF-8");
            // Gui email
            Transport.send(msg);
            return true; // Gửi thành công
        } catch (Exception e) {
            System.out.println("Send email failed");
            e.printStackTrace();
            return false; // Gửi không thành công
        }
    }
    
    public String subjectVerification() {
        return "Support verify email";
    }

    // Select subject to send email
    public String subjectForgotPass() {
        return "Support forgot password";
    }
    
    
    public String messageVerification(int code) {
        return "<!DOCTYPE html>\n"
                + "<html lang=\"en\">\n"
                + "<head>\n"
                + "    <meta charset=\"UTF-8\">\n"
                + "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
                + "    <title>Verification Code</title>\n"
                + "</head>\n"
                + "<body style=\"font-family: Arial, sans-serif; background-color: #f4f4f4; margin: 0; padding: 0;\">\n"
                + "\n"
                + "    <table style=\"width: 100%; max-width: 600px; margin: 20px auto; background-color: #ffffff; border-collapse: collapse;\">\n"
                + "        <tr>\n"
                + "            <td style=\"padding: 20px; text-align: center; background-color: #4CAF50; color: #ffffff; font-size: 24px;\">\n"
                + "                Password Reset Code\n"
                + "            </td>\n"
                + "        </tr>\n"
                + "        <tr>\n"
                + "            <td style=\"padding: 20px;\">\n"
                + "                <p>Hi new one</p>\n"
                + "                <p>If you didn't make this request, just ignore this email. If you'd like to proceed, your verify code is:</p>\n"
                + "                <p style=\"font-size: 28px; font-weight: bold; color: #4CAF50;\">" + code + "</p>\n"
                + "                <p>This Code will expire in 1 minute. Thanks for reading!</p>\n"
                + "            </td>\n"
                + "        </tr>\n"
                + "        <tr>\n"
                + "            <td style=\"padding: 20px; text-align: center; background-color: #4CAF50; color: #ffffff;\">\n"
                + "                &copy; 2024 Medicine Shop\n"
                + "            </td>\n"
                + "        </tr>\n"
                + "    </table>\n"
                + "\n"
                + "</body>\n"
                + "</html>";
    }
    
    
    public String messageForgotPass(String name,int code) {
        return "<!DOCTYPE html>\n"
                + "<html lang=\"en\">\n"
                + "<head>\n"
                + "    <meta charset=\"UTF-8\">\n"
                + "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
                + "    <title>Password Reset Code</title>\n"
                + "</head>\n"
                + "<body style=\"font-family: Arial, sans-serif; background-color: #f4f4f4; margin: 0; padding: 0;\">\n"
                + "\n"
                + "    <table style=\"width: 100%; max-width: 600px; margin: 20px auto; background-color: #ffffff; border-collapse: collapse;\">\n"
                + "        <tr>\n"
                + "            <td style=\"padding: 20px; text-align: center; background-color: #4CAF50; color: #ffffff; font-size: 24px;\">\n"
                + "                Password Reset Code\n"
                + "            </td>\n"
                + "        </tr>\n"
                + "        <tr>\n"
                + "            <td style=\"padding: 20px;\">\n"
                + "                <p>Hi "+name+",</p>\n"
                + "                <p>Someone has requested a new password for the following account. If you didn't make this request, just ignore this email. If you'd like to proceed, please use the following code to reset your password:</p>\n"
                + "                <p style=\"font-size: 28px; font-weight: bold; color: #4CAF50;\">" + code + "</p>\n"
                + "                <p>This Code will expire in 1 minute. Thanks for reading!</p>\n"
                + "            </td>\n"
                + "        </tr>\n"
                + "        <tr>\n"
                + "            <td style=\"padding: 20px; text-align: center; background-color: #4CAF50; color: #ffffff;\">\n"
                + "                &copy; 2024 Medicine Shop\n"
                + "            </td>\n"
                + "        </tr>\n"
                + "    </table>\n"
                + "\n"
                + "</body>\n"
                + "</html>";
    }
}
