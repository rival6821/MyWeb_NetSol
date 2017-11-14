package member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class memberDAO {
	
	private Connection getConnection() throws Exception{
/*		String dbUrl = "jdbc:mysql://localhost:3306/jspdb2";
		String dbUser = "jspid";
		String dbPass = "jsppass";
		Connection con = null;
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection(dbUrl, dbUser, dbPass);
		return con;*/
		Connection con = null;
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
		con = ds.getConnection();		
		return con;
	}//getConnection()

	public void insertMember(memberBean mb) {
		Connection con = null;
		String sql = "";
		PreparedStatement pstmt = null;
		try {
			con=getConnection();
			sql = "insert into member(id, pass, name, reg_date, age, gender, email, address, phone, mobile, zipcode, email_check) values(?,?,?,?,?,?,?,?,?,?,?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mb.getId());
			pstmt.setString(2, mb.getPass());
			pstmt.setString(3, mb.getName());
			pstmt.setTimestamp(4, mb.getReg_date());
			pstmt.setInt(5, mb.getAge());
			pstmt.setString(6, mb.getGender());
			pstmt.setString(7, mb.getEmail());
			pstmt.setString(8, mb.getAddress());
			pstmt.setString(9, mb.getPhone());
			pstmt.setString(10, mb.getMobile());
			pstmt.setString(11, mb.getZipcode());
			pstmt.setString(12, mb.getEmail_check());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (pstmt!=null) try{pstmt.close();}catch(SQLException se){}
			if (con!=null) try{con.close();}catch(SQLException se){}
		}
	}// insertMember()

	public int userCheck(String id, String pass) {
		Connection con = null;
		String sql = "";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int check=-1;
		try {
			con=getConnection();
			sql = "select pass from member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if (pass.equals(rs.getString("pass"))) {
					check= 1;
				} else {
					check= 0;
				}
			} else {
				check= -1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs!=null) try{rs.close();}catch(SQLException se){}
			if (pstmt!=null) try{pstmt.close();}catch(SQLException se){}
			if (con!=null) try{con.close();}catch(SQLException se){}
		}
		return check;

	}// userCheck();
	
	public memberBean getMember(String id){
		Connection con = null;
		String sql = "";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		memberBean mb = new memberBean();
		try {
			con = getConnection();
			sql = "select * from member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				mb.setId(rs.getString("id"));
				mb.setPass(rs.getString("pass"));
				mb.setName(rs.getString("name"));;
				mb.setReg_date(rs.getTimestamp("reg_date"));
				mb.setAge(rs.getInt("age"));
				mb.setGender(rs.getString("gender"));
				mb.setEmail(rs.getString("email"));
				mb.setAddress(rs.getString("address"));
				mb.setPhone(rs.getString("phone"));
				mb.setMobile(rs.getString("mobile"));
				mb.setZipcode(rs.getString("zipcode"));
				mb.setEmail_check(rs.getString("email_check"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			if (rs!=null) try{rs.close();}catch(SQLException se){}
			if (pstmt!=null) try{pstmt.close();}catch(SQLException se){}
			if (con!=null) try{con.close();}catch(SQLException se){}
		}
		return mb;
	}// getMember();
	
	public int updateMember(memberBean mb) {
		Connection con = null;
		String sql = "";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int check=0;
		try {
			con = getConnection();
			sql = "select pass from member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mb.getId());
			rs = pstmt.executeQuery();
			rs.next();
				if (mb.getPass().equals(rs.getString("pass"))) {
					sql = "update member set name=?, age=?, gender=?, email=?, address=?, phone=?, mobile=?, zipcode=?,email_check=?  where id=? and pass=?";//두개가 동시에 일치하는 조건
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, mb.getName());
		 			pstmt.setInt(2, mb.getAge());
					pstmt.setString(3, mb.getGender());
					pstmt.setString(4, mb.getEmail()); 
					pstmt.setString(5, mb.getAddress());
					pstmt.setString(6, mb.getPhone());
					pstmt.setString(7, mb.getMobile());
					pstmt.setString(8, mb.getZipcode());
					pstmt.setString(9, mb.getEmail_check());
					pstmt.setString(10, mb.getId());
					pstmt.setString(11, mb.getPass());
					pstmt.executeUpdate();
					check= 1;
				} else {
					check= 0;
				}
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			if (rs!=null) try{rs.close();}catch(SQLException se){}
			if (pstmt!=null) try{pstmt.close();}catch(SQLException se){}
			if (con!=null) try{con.close();}catch(SQLException se){}
		}
		return check;
	}//updateMember();
	
	public int deleteMember(String id, String pass){
		Connection con = null;
		String sql = "";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int check=-1;
		try {
			con = getConnection();
			sql = "select pass from member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				if (pass.equals(rs.getString("pass"))) {
					sql = "delete from member where id=? and pass=?";//두개가 동시에 일치하는 조건
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, id);
					pstmt.setString(2, pass);
					pstmt.executeUpdate();
					check= 1;
				} else {
					check= 0;
				}
			} else {
				check= -1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			if (rs!=null) try{rs.close();}catch(SQLException se){}
			if (pstmt!=null) try{pstmt.close();}catch(SQLException se){}
			if (con!=null) try{con.close();}catch(SQLException se){}
		}
		return check;
		
	}//deleteMember();
	
	public List getMemberList(){
		Connection con = null;
		String sql = "";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List memberList = new ArrayList(); 
		try{
			con = getConnection();
			sql = "select * from member";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				memberBean mb = new memberBean();
				mb.setId(rs.getString("id"));
				mb.setPass(rs.getString("pass"));
				mb.setName(rs.getString("name"));
				mb.setReg_date(rs.getTimestamp("reg_date"));
				mb.setAge(rs.getInt("age"));
				mb.setGender(rs.getString("gender"));
				mb.setEmail(rs.getString("email"));
				memberList.add(mb);
			}
		} catch(Exception e){
			e.printStackTrace();
		}finally{
			if (rs!=null) try{rs.close();}catch(SQLException se){}
			if (pstmt!=null) try{pstmt.close();}catch(SQLException se){}
			if (con!=null) try{con.close();}catch(SQLException se){}
		}
		return memberList;
	}
	
	public int idCheck(String id){
		Connection con = null;
		String sql = "";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int check = -1;
		try {
			con = getConnection();
			sql="select * from member where id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if(rs.next()){
				check = 1;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs!=null) try{rs.close();}catch(SQLException se){}
			if (pstmt!=null) try{pstmt.close();}catch(SQLException se){}
			if (con!=null) try{con.close();}catch(SQLException se){}
		}
		return check;
	}//idCheck();
	
	
}// 클래스
