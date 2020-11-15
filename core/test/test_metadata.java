import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.Statement;

public class Main {
  public static void main(String[] args) throws Exception {
    Connection conn = getMySqlConnection();
    System.out.println("Got Connection.");
    Statement st = conn.createStatement();
    st.executeUpdate("drop table survey;");
    st.executeUpdate("create table survey (id int,name varchar(30));");
    st.executeUpdate("insert into survey (id,name ) values (1,'nameValue')");

    st = conn.createStatement();
    ResultSet rs = st.executeQuery("SELECT * FROM survey");

    ResultSetMetaData rsMetaData = rs.getMetaData();

    int numberOfColumns = rsMetaData.getColumnCount();
    System.out.println("resultSet MetaData column Count=" + numberOfColumns);

    for (int i = 1; i <= numberOfColumns; i++) {
      System.out.println("column MetaData ");
      System.out.println("column number " + i);
      // indicates the designated column's normal maximum width in
      // characters
      System.out.println(rsMetaData.getColumnDisplaySize(i));
      // gets the designated column's suggested title
      // for use in printouts and displays.
      System.out.println(rsMetaData.getColumnLabel(i));
      // get the designated column's name.
      System.out.println(rsMetaData.getColumnName(i));

      // get the designated column's SQL type.
      System.out.println(rsMetaData.getColumnType(i));

      // get the designated column's SQL type name.
      System.out.println(rsMetaData.getColumnTypeName(i));

      // get the designated column's class name.
      System.out.println(rsMetaData.getColumnClassName(i));

      // get the designated column's table name.
      System.out.println(rsMetaData.getTableName(i));

      // get the designated column's number of decimal digits.
      System.out.println(rsMetaData.getPrecision(i));

      // gets the designated column's number of
      // digits to right of the decimal point.
      System.out.println(rsMetaData.getScale(i));

      // indicates whether the designated column is
      // automatically numbered, thus read-only.
      System.out.println(rsMetaData.isAutoIncrement(i));

      // indicates whether the designated column is a cash value.
      System.out.println(rsMetaData.isCurrency(i));

      // indicates whether a write on the designated
      // column will succeed.
      System.out.println(rsMetaData.isWritable(i));

      // indicates whether a write on the designated
      // column will definitely succeed.
      System.out.println(rsMetaData.isDefinitelyWritable(i));

      // indicates the nullability of values
      // in the designated column.
      System.out.println(rsMetaData.isNullable(i));

      // Indicates whether the designated column
      // is definitely not writable.
      System.out.println(rsMetaData.isReadOnly(i));

      // Indicates whether a column's case matters
      // in the designated column.
      System.out.println(rsMetaData.isCaseSensitive(i));

      // Indicates whether a column's case matters
      // in the designated column.
      System.out.println(rsMetaData.isSearchable(i));

      // indicates whether values in the designated
      // column are signed numbers.
      System.out.println(rsMetaData.isSigned(i));

      // Gets the designated column's table's catalog name.
      System.out.println(rsMetaData.getCatalogName(i));

      // Gets the designated column's table's schema name.
      System.out.println(rsMetaData.getSchemaName(i));
    }

    st.close();
    conn.close();
  }

  private static Connection getHSQLConnection() throws Exception {
    Class.forName("org.hsqldb.jdbcDriver");
    System.out.println("Driver Loaded.");
    String url = "jdbc:hsqldb:data/tutorial";
    return DriverManager.getConnection(url, "sa", "");
  }

  public static Connection getMySqlConnection() throws Exception {
    String driver = "org.gjt.mm.mysql.Driver";
    String url = "jdbc:mysql://localhost/demo2s";
    String username = "oost";
    String password = "oost";

    Class.forName(driver);
    Connection conn = DriverManager.getConnection(url, username, password);
    return conn;
  }

  public static Connection getOracleConnection() throws Exception {
    String driver = "oracle.jdbc.driver.OracleDriver";
    String url = "jdbc:oracle:thin:@localhost:1521:caspian";
    String username = "mp";
    String password = "mp2";

    Class.forName(driver); // load Oracle driver
    Connection conn = DriverManager.getConnection(url, username, password);
    return conn;
  }
}
