import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

public class BuilderMain {
  public static void main(String[] args) {
    InsertBuilder builder = new InsertBuilder();
    builder.setTable("employees");
    builder.addColumnAndData("employee_id", new Integer(221));
    builder.addColumnAndData("first_name", "'Shane'");
    builder.addColumnAndData("last_name", "'Grinnell'");
    builder.addColumnAndData("email", "'al@yahoo.com'");

    String sql = SQLDirector.buildSQL(builder);
    System.out.println(sql);
  }
}

class SQLDirector {
  public static String buildSQL(SQLBuilder builder) {
    StringBuffer buffer = new StringBuffer();
    buffer.append(builder.getCommand());
    buffer.append(builder.getTable());
    buffer.append(builder.getWhat());
    buffer.append(builder.getCriteria());
    return buffer.toString();
  }
}

abstract class SQLBuilder {
  /**
   * Gets the command attribute of the SQLBuilder object
   *
   * @return The command value or what type of Builder this is. This will return
   *         a SQL command.
   * @since
   */
  public abstract String getCommand();

  /**
   * Gets the table attribute of the SQLBuilder object
   *
   * @return The table name value
   * @since
   */
  public abstract String getTable();

  /**
   * Gets the what value of the SQLBuilder object. This attribute will differ
   * based on what type of object we are using. This could be a list of columns
   * and data.
   *
   * @return The what value
   * @since
   */
  public abstract String getWhat();

  /**
   * Gets the criteria attribute of the SQLBuilder object
   *
   * @return The criteria value
   * @since
   */
  public abstract String getCriteria();
}

class InsertBuilder extends SQLBuilder {
  private String table;

  private Map columnsAndData = new HashMap();

  private String criteria;

  /**
   * Sets the table attribute of the InsertBuilder object
   *
   * @param table
   *          The new table value
   * @since
   */
  public void setTable(String table) {
    this.table = table;
  }

  /**
   * Gets the command attribute of the InsertBuilder object
   *
   * @return The command value
   * @since
   */
  public String getCommand() {
    return "INSERT INTO ";
  }

  /**
   * Gets the table attribute of the InsertBuilder object
   *
   * @return The table value
   * @since
   */
  public String getTable() {
    return table;
  }

  /**
   * Gets the what attribute of the InsertBuilder object
   *
   * @return The what value
   * @since
   */
  public String getWhat() {
    StringBuffer columns = new StringBuffer();
    StringBuffer values = new StringBuffer();
    StringBuffer what = new StringBuffer();

    String columnName = null;
    Iterator iter = columnsAndData.keySet().iterator();
    while (iter.hasNext()) {
      columnName = (String) iter.next();
      columns.append(columnName);
      values.append(columnsAndData.get(columnName));
      if (iter.hasNext()) {
        columns.append(',');
        values.append(',');
      }
    }

    what.append(" (");
    what.append(columns);
    what.append(") VALUES (");
    what.append(values);
    what.append(") ");
    return what.toString();
  }

  /**
   * Gets the criteria attribute of the InsertBuilder object
   *
   * @return The criteria value
   * @since
   */
  public String getCriteria() {
    return "";
  }

  /**
   * Adds a feature to the ColumnAndData attribute of the InsertBuilder object
   *
   * @param columnName
   *          The feature to be added to the ColumnAndData attribute
   * @param value
   *          The feature to be added to the ColumnAndData attribute
   * @since
   */
  public void addColumnAndData(String columnName, Object value) {
    if (value != null) {
      columnsAndData.put(columnName, value);
    }
  }
}

