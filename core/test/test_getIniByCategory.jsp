<%@ page import="com.ase.aseutil.*,javax.mail.*,java.util.Properties,javax.mail.internet.*,java.util.*,javax.mail.internet.MimeMessage" %>

<%@ include file="ase.jsp" %>

<%

	//conn,"radio","UserStatus","status",status,0,0
	//fieldType,fieldRef,fieldName,fieldValue,fieldLen,fieldMax

	String alpha = "ICS";
	String num = "241";
	String campus = "LEECC";
	String user = "THANHG";

			String category = "MethodEval";
			String value = "115,112,119,116,117,118";
			boolean bullets = true;

		StringBuffer ini = new StringBuffer();
		String temp = null;
		String junk = null;
		String id = null;
		String[] selected = new String[100];

		boolean found = false;

		int numberOfSelections = 0;
		int selectedIndex = 0;
		int i = 0;

		try {
			String sql = "SELECT id, kdesc FROM tblIni WHERE category=? ORDER BY kdesc ASC";

			selected = value.split(",");
			numberOfSelections = selected.length;
			PreparedStatement preparedStatement = conn.prepareStatement(sql);
			preparedStatement.setString(1, category);
			ResultSet resultSet = preparedStatement.executeQuery();
			i = 0;
			while (resultSet.next()) {
				id = resultSet.getString(1);
				junk = resultSet.getString(2);

				selectedIndex = 0;
				found = false;
				while (!found && selectedIndex < numberOfSelections){
					if (id.equals(selected[selectedIndex++])){
						if (bullets)
							ini.append("<li>" + junk + "</li>");
						else
							ini.append(junk + "<br>");
					}
				}
			}
			resultSet.close();
			preparedStatement.close();

			temp = ini.toString();

			if (bullets)
				temp = "<ul>" + temp + "</ul>";

		} catch (Exception e) {
			out.println("IniDB: getIniByCategory\n" + e.toString());
			temp = null;
		}

		out.println(temp);

%>