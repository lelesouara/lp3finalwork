package projetofinal.lp3.utils;

import java.util.Date;
import java.util.UUID;


public class ManipulateString {
	
	public static String generateString(){
		UUID uuid = UUID.randomUUID();
		return uuid.toString().toUpperCase().replace('-', 'X') +
				String.valueOf(new Date().getTime()); 
	}

}
