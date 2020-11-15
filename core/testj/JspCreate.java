import java.util.*;
import java.io.*;

import com.ase.aseutil.*;

/**
* Recursive file listing under a specified directory.
*
*/
public final class JspCreate {

	/**
	* Demonstrate use.
	*
	* @param aArgs - <tt>aArgs[0]</tt> is the full name of an existing
	* directory that can be read.
	*/
	public static void main(String... aArgs) throws FileNotFoundException {

		//File startingDirectory= new File(aArgs[0]);

		File startingDirectory = new File(AseUtil.getCurrentDrive() + ":\\tomcat\\webapps\\central\\core");

		List<File> files = JspCreate.getFileListing(startingDirectory);

		//print out all file names, in the the order of File.compareTo()
		//for(File file : files ){
			//System.out.println(file);
		//}
	}

	/**
	* Recursively walk a directory tree and return a List of all
	* Files found; the List is sorted using File.compareTo().
	*
	* @param aStartingDir is a valid directory, which can be read.
	*/
	static public List<File> getFileListing(File aStartingDir) throws FileNotFoundException {

		validateDirectory(aStartingDir);

		List<File> result = getFileListingNoSort(aStartingDir);

		Collections.sort(result);

		return result;
	}

	/**
	* getFileListingNoSort
	*/
	static private List<File> getFileListingNoSort(File aStartingDir) throws FileNotFoundException {

		List<File> result = new ArrayList<File>();

		File[] filesAndDirs = aStartingDir.listFiles();

		List<File> filesDirs = Arrays.asList(filesAndDirs);

		for(File file : filesDirs) {

			result.add(file); //always add, even if directory
			if (! file.isFile()) {

				List<File> deeperList = getFileListingNoSort(file);

				// create directory structure to store our JSPs to Java files
				String newDir = file.toString();

				newDir = newDir.replace(AseUtil.getCurrentDrive() + ":\\tomcat\\webapps\\central\\core\\",
												AseUtil.getCurrentDrive() + ":\\tomcat\\webapps\\central\\build\\core\\");

 				boolean success = (new File(newDir)).mkdir();

				result.addAll(deeperList);
			}
			else{

				boolean runThis = true;

				if (runThis){

					String fullName = file.toString();

					System.out.println(fullName);

					String fname = "";

					String ext = "";

					int mid = fullName.lastIndexOf(".");

					fname = file.getName();

					ext = fullName.substring(mid+1,fullName.length());

					if (ext.equals("jsp")){

						fullName = fullName.replace(AseUtil.getCurrentDrive() + ":\\tomcat\\webapps\\central\\core\\",
														AseUtil.getCurrentDrive() + ":\\tomcat\\webapps\\central\\build\\core\\");

						File newFile = new File(fullName);

						try{
							if(!newFile.exists()){
								newFile.createNewFile();
							}

							setContents(newFile,getContents(file));
						}
						catch(Exception e){
							System.out.println(e.toString());
						}
					} // if jsp
				} // runThis

			} // else
		}

		return result;
	}

	/**
	* Directory is valid if it exists, does not represent a file, and can be read.
	*/
	static private void validateDirectory (File aDirectory) throws FileNotFoundException {
		if (aDirectory == null) {
			throw new IllegalArgumentException("Directory should not be null.");
		}

		if (!aDirectory.exists()) {
			throw new FileNotFoundException("Directory does not exist: " + aDirectory);
		}

		if (!aDirectory.isDirectory()) {
			throw new IllegalArgumentException("Is not a directory: " + aDirectory);
		}

		if (!aDirectory.canRead()) {
			throw new IllegalArgumentException("Directory cannot be read: " + aDirectory);
		}
	}

	/**
	* Fetch the entire contents of a text file, and return it in a String.
	* This style of implementation does not throw Exceptions to the caller.
	*
	* @param aFile is a file which already exists and can be read.
	*/
	static public String getContents(File aFile) {

		StringBuffer contents = new StringBuffer();
		String content = "";

		try {
			BufferedReader input =  new BufferedReader(new FileReader(aFile));
			try {
				String line = null; //not declared within while loop
				/*
				* readLine is a bit quirky :
				* it returns the content of a line MINUS the newline.
				* it returns null only for the END of the stream.
				* it returns an empty String if two newlines appear in a row.
				*/
				while (( line = input.readLine()) != null){
					contents.append(line);
					contents.append(System.getProperty("line.separator"));
				}

				content = contents.toString();
				content = content.replace("<%@ include ","<jsp:include ");
				content = content.replace("jsp\" %>","jsp\" />");
			}
			finally {
				input.close();
			}
		}
		catch (IOException ex){
			ex.printStackTrace();
		}

		return content;
	}

  /**
  * Change the contents of text file in its entirety, overwriting any
  * existing text.
  *
  * This style of implementation throws all exceptions to the caller.
  *
  * @param aFile is an existing file which can be written to.
  * @throws IllegalArgumentException if param does not comply.
  * @throws FileNotFoundException if the file does not exist.
  * @throws IOException if problem encountered during write.
  */
  static public void setContents(File aFile, String aContents) throws FileNotFoundException, IOException {
    if (aFile == null) {
      throw new IllegalArgumentException("File should not be null.");
    }

    if (!aFile.exists()) {
      throw new FileNotFoundException ("File does not exist: " + aFile);
    }

    if (!aFile.isFile()) {
      throw new IllegalArgumentException("Should not be a directory: " + aFile);
    }

    if (!aFile.canWrite()) {
      throw new IllegalArgumentException("File cannot be written: " + aFile);
    }

    //use buffering
    Writer output = new BufferedWriter(new FileWriter(aFile));
    try {
      output.write( aContents );
    }
    finally {
      output.close();
    }
  }

}