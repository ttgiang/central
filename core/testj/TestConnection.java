import java.sql.*;

public class TestConnection{
    public static void main(String[] args){

        String server = "";
        String database = "";
        String user = "";
        String pw = "";

        server = "f01motgd01";	database = "northwind";		user = "sysop";		pw = "otg";
        server = "ase";				database = "cc";				user = "sa";			pw = "msde";
        server = "szhi03";			database = "ccv2";			user = "sa";			pw = "tr1gger";
        server = "d-2020-101385";		database = "ccv2";				user = "sa";			pw = "msde";

        DB db = new DB();
        db.dbConnect("jdbc:jtds:sqlserver://" + server + ":1433/" + database + "","" + user + "","" + pw + "");
    }
}

class DB{

	public DB() {}

	public void dbConnect(String db_connect_string,String db_userid, String db_password){
		try{
			Class.forName("net.sourceforge.jtds.jdbc.Driver");
			Connection conn = DriverManager.getConnection(db_connect_string, db_userid, db_password);

			if (conn != null) {
				System.out.println();
				System.out.println("Successfully connected");
				System.out.println();

				DatabaseMetaData meta = conn.getMetaData();
				System.out.println("\nDriver Information");
				System.out.println("Driver Name: " + meta.getDriverName());
				System.out.println("Driver Version: " + meta.getDriverVersion());
				System.out.println("\nDatabase Information ");
				System.out.println("Database Name: " + meta.getDatabaseProductName());
				System.out.println("Database Version: "+
				meta.getDatabaseProductVersion());

				try {
					boolean run = false;

					if (run){
						CallableStatement cstmt = conn.prepareCall("{? = call dbo.CheckBannerCount(?)}");
						cstmt.registerOutParameter(1,java.sql.Types.INTEGER);
						cstmt.setString(2,"KAP");
						cstmt.execute();
						System.out.println("\nReturn value - CheckBannerCount: " + cstmt.getInt(1));
						cstmt.close();

						String sql = "{ ? = call dbo.sp_ASE_OutlineModify(?,?,?,?,?,?,?) }";
						CallableStatement stmt = conn.prepareCall(sql);
						stmt.registerOutParameter(1,java.sql.Types.INTEGER);
						stmt.setString(2, "LEE");
						stmt.setString(3, "ICS");
						stmt.setString(4, "212");
						stmt.setString(5, "11-14-2008");
						stmt.setString(6, "THANHG");
						stmt.setString(7, "HISTORYID");
						stmt.setString(8, "session");
						stmt.execute();
						System.out.println("\nReturn value - sp_ASE_OutlineModify: " + stmt.getInt(1));
						stmt.close();
					}
				}catch (Exception e) {
					e.printStackTrace();
				}

			}
		}
		catch (Exception e){
			e.printStackTrace();
		}
	}
};
