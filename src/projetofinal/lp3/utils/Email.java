package projetofinal.lp3.utils;

import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.SimpleEmail;

public class Email {
	
	public static void enviarEmail (String[] args) throws  EmailException{
		
		SimpleEmail email = new SimpleEmail();
		email.setHostName("smtp.gmail.com");
		email.addTo(args[0], args[1]);
		email.setFrom(args[2], args[3]);
		email.setSubject(args[4]);
		email.setMsg(args[5]);
		email.setAuthentication(args[6], args[7]);
		email.setSmtpPort(465);
		email.setSSL(true);
		email.setTLS(true);
		email.send();
	
	}

}
