package com.carpe.sqlite;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class SqliteDataReader {
	private Connection connection;
	private String dbFileName;
	private boolean isOpened = false;

	static {
		try {
			Class.forName("org.sqlite.JDBC");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public SqliteDataReader(String databaseFileName) {
		this.dbFileName = databaseFileName;
	}

	public boolean open() {
		try {
			org.sqlite.SQLiteConfig config = new org.sqlite.SQLiteConfig();
			config.setReadOnly(true);
			this.connection = DriverManager.getConnection("jdbc:sqlite:/" + this.dbFileName, config.toProperties());
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}

		isOpened = true;
		return true;
	}

	public boolean close() {
		if (this.isOpened == false) {
			return true;
		}

		try {
			this.connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		return true;
	}

	public List<Map> readApplicationList() throws Exception {
		List<Map> list = new ArrayList<Map>();

		if (this.isOpened == false) {
			throw new Exception("need open");
		}

		PreparedStatement prep = null;
		ResultSet row = null;

		String query = "SELECT * FROM application_list";

		try {
			prep = this.connection.prepareStatement(query);
			row = prep.executeQuery();

			while (row.next()) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("is_deleted", row.getString("is_deleted"));
				map.put("package_name", row.getString("package_name"));
				map.put("application_name", row.getString("application_name"));
				map.put("version", row.getString("version"));
				map.put("category", row.getString("category"));
				map.put("installed_time", row.getString("installed_time"));
				map.put("updated_time", row.getString("updated_time"));
				map.put("is_updated", row.getString("is_updated"));
				map.put("cnt_permission", row.getString("cnt_permission"));
				
				list.add(map);
			}
		} finally {
			if (row != null) {
				row.close();
			}
			if (prep != null) {
				prep.close();
			}
		}

		return list;
	}
	
	public List<Map> readCallLog() throws Exception {
		List<Map> list = new ArrayList<Map>();
		
		if (this.isOpened == false) {
			throw new Exception("need open");
		}
		
		PreparedStatement prep = null;
		ResultSet row = null;
		
		String query = "SELECT * FROM app_call";
		
		try {
			prep = this.connection.prepareStatement(query);
			row = prep.executeQuery();
			
			while (row.next()) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("id_application", row.getString("id_application"));
				map.put("timestamp_start", row.getString("timestamp_start"));
				map.put("timestamp_end", row.getString("timestamp_end"));
				map.put("time_duration", row.getString("time_duration"));
				map.put("is_group", row.getString("is_group"));
				map.put("id_from", row.getString("id_from"));
				map.put("id_to", row.getString("id_to"));
				map.put("is_recorded", row.getString("is_recorded"));
				map.put("id_file", row.getString("id_file"));
				
				list.add(map);
			}
		} finally {
			if (row != null) {
				row.close();
			}
			if (prep != null) {
				prep.close();
			}
		}
		
		return list;
	}
	
	public List<Map> readWebBrowser() throws Exception {
		List<Map> list = new ArrayList<Map>();
		
		if (this.isOpened == false) {
			throw new Exception("need open");
		}
		
		PreparedStatement prep = null;
		ResultSet row = null;
		
		String query = "SELECT * FROM app_webbrowser";
		
		try {
			prep = this.connection.prepareStatement(query);
			row = prep.executeQuery();
			
			while (row.next()) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("id_application", row.getString("id_application"));
				map.put("timestamp", row.getString("timestamp"));
				map.put("type", row.getString("type"));
				map.put("url_address", row.getString("url_address"));
				map.put("title", row.getString("title"));
				map.put("id_file", row.getString("id_file"));
				
				list.add(map);
			}
		} finally {
			if (row != null) {
				row.close();
			}
			if (prep != null) {
				prep.close();
			}
		}
		
		return list;
	}
	
	public List<Map> readMessage() throws Exception {
		List<Map> list = new ArrayList<Map>();
		
		if (this.isOpened == false) {
			throw new Exception("need open");
		}
		
		PreparedStatement prep = null;
		ResultSet row = null;
		
		String query = "SELECT * FROM app_communication";
		
		try {
			prep = this.connection.prepareStatement(query);
			row = prep.executeQuery();
			
			while (row.next()) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("id_application", row.getString("id_application"));
				map.put("timestamp", row.getString("timestamp"));
				map.put("time_duration", row.getString("time_duration"));
				map.put("id_from", row.getString("id_from"));
				map.put("id_to", row.getString("id_to"));
				map.put("contents", row.getString("contents"));
				
				list.add(map);
			}
		} finally {
			if (row != null) {
				row.close();
			}
			if (prep != null) {
				prep.close();
			}
		}
		
		return list;
	}
	
	public List<Map> readTimeline() throws Exception {
		List<Map> list = new ArrayList<Map>();
		
		if (this.isOpened == false) {
			throw new Exception("need open");
		}
		
		PreparedStatement prep = null;
		ResultSet row = null;
		
		String query = "SELECT * FROM timeline";
		
		try {
			prep = this.connection.prepareStatement(query);
			row = prep.executeQuery();
			
			while (row.next()) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("is_deleted", row.getString("is_deleted"));
				map.put("timestamp", row.getString("timestamp"));
				map.put("time_duration", row.getString("time_duration"));
				map.put("id_application", row.getString("id_application"));
				map.put("id_from", row.getString("id_from"));
				map.put("id_to", row.getString("id_to"));
				map.put("contents", row.getString("contents"));
				map.put("has_attachment", row.getString("has_attachment"));
				map.put("id_file", row.getString("id_file"));
				map.put("attachement_contetns", row.getString("attachement_contetns"));
				
				list.add(map);
			}
		} finally {
			if (row != null) {
				row.close();
			}
			if (prep != null) {
				prep.close();
			}
		}
		
		return list;
	}
	
	public List<Map> readContacts() throws Exception {
		List<Map> list = new ArrayList<Map>();
		
		if (this.isOpened == false) {
			throw new Exception("need open");
		}
		
		PreparedStatement prep = null;
		ResultSet row = null;
		
		String query = "SELECT * FROM contacts_person";
		
		try {
			prep = this.connection.prepareStatement(query);
			row = prep.executeQuery();
			
			while (row.next()) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("is_group", row.getString("is_group"));
				map.put("id_group", row.getString("id_group"));
				map.put("name", row.getString("name"));
				map.put("phonenumber", row.getString("phonenumber"));
				map.put("email", row.getString("email"));
				map.put("ip_address", row.getString("ip_address"));
				map.put("mac_address", row.getString("mac_address"));
				map.put("url", row.getString("url"));
				
				list.add(map);
			}
		} finally {
			if (row != null) {
				row.close();
			}
			if (prep != null) {
				prep.close();
			}
		}
		
		return list;
	}
}
