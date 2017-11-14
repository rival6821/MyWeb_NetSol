package comment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import board.boardBean;

public class commentDAO {
	private Connection getConnection() throws Exception {
				//Context객체생성
				//DataSource ds = 메서드호출 lookup(자원의 이름)
				//con = getConnection()
				Connection con = null;
				Context init = new InitialContext();
				DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
				con = ds.getConnection();		
				return con;
			}// getConnection()
	
	public void insertCommentBoard(commentBean cb) {
		Connection con = null;
		String sql = "";
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		try {
			con = getConnection();
			sql = "select max(com_num) from comment";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				cb.setCom_num(rs.getInt(1) + 1);
			}
			sql = "insert into comment values(?,?,?,now(),?,?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, cb.getCom_num());
			pstmt.setInt(2, cb.getCom_board());
			pstmt.setString(3, cb.getCom_id());
			pstmt.setInt(4, cb.getCom_parent());
			pstmt.setString(5, cb.getCom_content());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException se) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException se) {
				}
			if (con != null)
				try {
					con.close();
				} catch (SQLException se) {
				}
		}
	}// insertCommentBoard()
	
	public int getCommentCount(int num) {
		Connection con = null;
		String sql = "";
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		int count = 0;
		try {
			con = getConnection();
			sql = "select count(*) from comment where com_board=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				count = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException se) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException se) {
				}
			if (con != null)
				try {
					con.close();
				} catch (SQLException se) {
				}
		}
		return count;
	}// getCommentCount()
	
	public List getCommentList(int num) {
		Connection con = null;
		String sql = "";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List commentList = new ArrayList();
		try {
			con = getConnection();
			sql = "select * from comment where com_board=? order by com_num desc ";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				commentBean cb = new commentBean();
				cb.setCom_num(rs.getInt("com_num"));
				cb.setCom_board(rs.getInt("com_board"));
				cb.setCom_id(rs.getString("com_id"));
				cb.setCom_date(rs.getDate("com_date"));
				cb.setCom_parent(rs.getInt("com_parent"));
				cb.setCom_content(rs.getString("com_content"));
				commentList.add(cb);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException se) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException se) {
				}
			if (con != null)
				try {
					con.close();
				} catch (SQLException se) {
				}
		}
		return commentList;
	}// getCommentList()
	
	public void deleteComment(int com_num){
		Connection con = null;
		String sql = "";
		PreparedStatement pstmt = null;
		try {
			con = getConnection();
			sql = "delete from comment where com_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, com_num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			if (pstmt!=null) try{pstmt.close();}catch(SQLException se){}
			if (con!=null) try{con.close();}catch(SQLException se){}
		}
	}//deleteComment()
	
	public String getComment(int com_num){
		Connection con = null;
		String sql = "";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String content=null;
		try {
			con = getConnection();
			sql = "select * from comment where com_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, com_num);
			rs = pstmt.executeQuery();
			rs.next();
			content = rs.getString("com_content");
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			if (rs!=null) try{rs.close();}catch(SQLException se){}
			if (pstmt!=null) try{pstmt.close();}catch(SQLException se){}
			if (con!=null) try{con.close();}catch(SQLException se){}
		}
		return content;
	}//deleteComment()
	
	public int updateComment(String com_content,int com_num) {
		Connection con = null;
		String sql = "";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int check = -1;
		try {
			con = getConnection();
					sql = "update comment set com_content=? where com_num=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, com_content);
					pstmt.setInt(2, com_num);
					pstmt.executeUpdate();
					check = 1;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException se) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException se) {
				}
			if (con != null)
				try {
					con.close();
				} catch (SQLException se) {
				}
		}
		return check;
	}// updateComment()

}
