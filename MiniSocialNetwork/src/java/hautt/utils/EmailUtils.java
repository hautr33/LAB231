/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package hautt.utils;

import java.io.UnsupportedEncodingException;
import java.util.Properties;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author SE130205
 */
public class EmailUtils {

    public boolean sendMail(String toMail, String code) throws UnsupportedEncodingException, MessagingException {
        boolean result = false;
        final String email = "haudeptraithe123@gmail.com";
        final String password = "Hau201120";

        Properties prop = new Properties();
        prop.put("mail.smtp.host", "smtp.gmail.com");
        prop.put("mail.smtp.port", "587");
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.starttls.enable", "true"); //TLS

        try {
            Session session = Session.getInstance(prop,
                    new javax.mail.Authenticator() {
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(email, password);
                }
            });

            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(email, "Mini Social Network"));
            message.setRecipients(
                    Message.RecipientType.TO,
                    InternetAddress.parse(toMail)
            );
            message.setSubject("Get verification code");
            message.setText("Thank you for using Mini Social Network.\n"
                    + "In order to verify this e-mail address, please enter the verification code below into the verification form."
                    + "\n\n" + code + "\n\n"
                    + "* This is an automatically generated email, please do not reply.\n"
                    + "* If this is not your e-mail address, someone else probably entered your e-mail address by mistake. You can delete this e-mail.");

            Transport.send(message);

            result = true;
        } finally {
            return result;
        }
    }
}
