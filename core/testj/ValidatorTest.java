import java.io.File;
import java.io.IOException;
import java.net.URL;

import com.ase.validation.Validator;

public class ValidatorTest {
	public static void main(String[] args) {
	  try {
		  /*
			if (args.length != 1) {
				 System.out.println("Usage: java ValidatorTest [schema URL]");
				 return;
			}
			*/

			// Create a valiator
			//File schemaFile = new File(args[0]);
			File schemaFile = new File("C:\\tomcat\\webapps\\central\\core\\xml\\buyShoes.xsd");
			Validator validator = Validator.getInstance(schemaFile.toURL());

			// Create some data
			String shoeSize = "23";
			String width = "DD";
			String brand = "V-Form";
			String numEyelets = "22";

			// Validate the data
			if (validator.isValid("shoeSize", shoeSize)) {
				 System.out.println("Shoe size is valid.");
			} else {
				 System.out.println("Shoe size is not valid.");
			}

			if (validator.isValid("width", width)) {
				 System.out.println("Width is valid.");
			} else {
				 System.out.println("Width is not valid.");
			}

			if (validator.isValid("brand", brand)) {
				 System.out.println("Brand is valid.");
			} else {
				 System.out.println("Brand is not valid.");
			}

			if (validator.isValid("numEyelets", numEyelets)) {
				 System.out.println("Number of eyelets is valid.");
			} else {
				 System.out.println("Number of eyelets is not valid.");
			}
	  } catch (Exception e) {
			e.printStackTrace();
	  }
	}
}