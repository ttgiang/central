import com.ase.textdiff.*;

public class Testing{
	public static void main(java.lang.String[] args){
		try{
			Report report = new TextDiff().compare( "D:\\tomcat\\webapps\\central\\src\\com\\ase\\textdiff\\TextFileIn.java", "D:\\tomcat\\webapps\\central\\src\\com\\ase\\textdiff\\TextFileIn.java" );
			report.print( );
		}
		catch(Exception e){
			System.out.println(e.toString());
		}

	}
}
