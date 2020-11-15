
	Statement stmt = conn.createStatement();
	ResultSet rs = stmt.executeQuery("select COF_NAME from COFFEES");

	SQLWarning warning = stmt.getWarnings();
	if (warning != null) {
		System.out.println("\n---Warning---\n");
		while (warning != null) {
			System.out.println("Message: "
                                           + warning.getMessage());
			System.out.println("SQLState: "
                                           + warning.getSQLState());
			System.out.print("Vendor error code: ");
			System.out.println(warning.getErrorCode());
			System.out.println("");
			warning = warning.getNextWarning();
		}
	}
	SQLWarning warn = rs.getWarnings();
	if (warn != null) {
		System.out.println("\n---Warning---\n");
		while (warn != null) {
			System.out.println("Message: "
                                           + warn.getMessage());
			System.out.println("SQLState: "
                                           + warn.getSQLState());
			System.out.print("Vendor error code: ");
			System.out.println(warn.getErrorCode());
			System.out.println("");
			warn = warn.getNextWarning();
		}
	}
