package proj.kw.familyOrganizer.tools;


import org.springframework.web.multipart.MultipartFile;
import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;


public class FileUploader {
	
	
	private static String REAL_PATH = "";

	public static boolean uploadFile(HttpServletRequest request, MultipartFile file, String code) 
	{				

		REAL_PATH = request.getSession().getServletContext().getRealPath("/assets/images/");

		
		if(!new File(REAL_PATH).exists()) {
			new File(REAL_PATH).mkdirs(); 
		}


		try {
			// upload file to server
			file.transferTo(new File(REAL_PATH + code + ".jpg"));

		}
		catch (IOException ex) {
			System.err.print(ex);
			return false;
		}


		return true;
	}

	
}
