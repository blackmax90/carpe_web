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
				map.put("category", row.getString("category"));
				map.put("package_name", row.getString("package_name"));
				map.put("app_name", row.getString("app_name"));
				map.put("version", row.getString("version"));
				map.put("installed_time", row.getString("installed_time"));
				map.put("apk_changed_time", row.getString("apk_changed_time"));
				map.put("updated_time", row.getString("updated_time"));
				map.put("deleted_time", row.getString("deleted_time"));
				map.put("fs_ctime", row.getString("fs_ctime"));
				map.put("fs_crtime", row.getString("fs_crtime"));
				map.put("fs_atime", row.getString("fs_atime"));
				map.put("fs_mtime", row.getString("fs_mtime"));
				map.put("is_updated", row.getString("is_updated"));
				map.put("source", row.getString("source"));
				
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
	
	public List<Map> readCallHistory() throws Exception {
		List<Map> list = new ArrayList<Map>();
		
		if (this.isOpened == false) {
			throw new Exception("need open");
		}
		
		PreparedStatement prep = null;
		ResultSet row = null;
		
		String query = "SELECT * FROM call_history";
		
		try {
			prep = this.connection.prepareStatement(query);
			row = prep.executeQuery();
			
			while (row.next()) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("package_name", row.getString("package_name"));
				map.put("timestamp", row.getString("timestamp"));
				map.put("time_duration", row.getString("time_duration"));
				map.put("phonenumber", row.getString("phonenumber"));
				map.put("account", row.getString("account"));
				map.put("digit_positive", row.getString("digit_positive"));
				map.put("file", row.getString("file"));
				map.put("contents", row.getString("contents"));
				map.put("source", row.getString("source"));
				
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
		
		String query = "SELECT * FROM web_browser_history";
		
		try {
			prep = this.connection.prepareStatement(query);
			row = prep.executeQuery();
			
			while (row.next()) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("package_name", row.getString("package_name"));
				map.put("timestamp", row.getString("timestamp"));
				map.put("url", row.getString("url"));
				map.put("account", row.getString("account"));
				map.put("digit_positive", row.getString("digit_positive"));
				map.put("file", row.getString("file"));
				map.put("contents", row.getString("contents"));
				map.put("source", row.getString("source"));
				
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
	
	public List<Map> readGeoData() throws Exception {
		List<Map> list = new ArrayList<Map>();
		
		if (this.isOpened == false) {
			throw new Exception("need open");
		}
		
		PreparedStatement prep = null;
		ResultSet row = null;
		
		String query = "SELECT * FROM geodata";
		
		try {
			prep = this.connection.prepareStatement(query);
			row = prep.executeQuery();
			
			while (row.next()) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("package_name", row.getString("package_name"));
				map.put("timestamp", row.getString("timestamp"));
				map.put("geodata", row.getString("geodata"));
				map.put("contents", row.getString("contents"));
				map.put("source", row.getString("source"));
				
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
	
	public List<Map> readIDPasswordHash() throws Exception {
		List<Map> list = new ArrayList<Map>();
		
		if (this.isOpened == false) {
			throw new Exception("need open");
		}
		
		PreparedStatement prep = null;
		ResultSet row = null;
		
		String query = "SELECT * FROM id_password_hash";
		
		try {
			prep = this.connection.prepareStatement(query);
			row = prep.executeQuery();
			
			while (row.next()) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("package_name", row.getString("package_name"));
				map.put("url", row.getString("url"));
				map.put("account", row.getString("account"));
				map.put("pwd", row.getString("pwd"));
				map.put("contents", row.getString("contents"));
				map.put("timestamp", row.getString("timestamp"));
				map.put("source", row.getString("source"));
				
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
	
	public List<Map> readFileHistory() throws Exception {
		List<Map> list = new ArrayList<Map>();
		
		if (this.isOpened == false) {
			throw new Exception("need open");
		}
		
		PreparedStatement prep = null;
		ResultSet row = null;
		
		String query = "SELECT * FROM file_history";
		
		try {
			prep = this.connection.prepareStatement(query);
			row = prep.executeQuery();
			
			while (row.next()) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("package_name", row.getString("package_name"));
				map.put("timestamp", row.getString("timestamp"));
				map.put("file", row.getString("file"));
				map.put("phonenumber", row.getString("phonenumber"));
				map.put("account", row.getString("account"));
				map.put("contents", row.getString("contents"));
				map.put("source", row.getString("source"));
				
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
