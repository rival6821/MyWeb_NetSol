package mail;
 
import java.util.Properties;
 
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
 
public class SendMailTest {
	public void SendMail(String id, String email) throws MessagingException{

        // 메일 관련 정보
        String host = "smtp.gmail.com";
        String username = "rival68211";
        String password = "xg855420";
         
        // 메일 내용
        String recipient = email;//받는 이메일
        String subject = id+"님의 network solutions의 회원가입을 환영합니다!!!";
        String body = id+"님의 network solutions의 회원가입을 환영합니다!!!";
         
        try {
        //properties 설정
        Properties props = new Properties();
        /*props.put("mail.smtps.auth", "true");*/
        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        // 메일 세션
        Session session = Session.getDefaultInstance(props);
        MimeMessage msg = new MimeMessage(session);
 
        // 메일 관련
        msg.setSubject(subject);
        msg.setText(body);
        msg.setFrom(new InternetAddress(username));
        msg.addRecipient(Message.RecipientType.TO, new InternetAddress(recipient));
 
        // 발송 처리
        Transport transport = session.getTransport("smtps");
        transport.connect(host, username, password);
        transport.sendMessage(msg, msg.getAllRecipients());
        transport.close();    
        } catch(Exception e) {e.printStackTrace();}
    
    }
}




