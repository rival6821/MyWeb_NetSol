package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import javax.naming.*;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class boardDAO {
	private Connection getConnection() throws Exception {
/*		String dbUrl = "jdbc:mysql://localhost:3306/jspdb2?autoReconnect=true&useSSL=false";
		String dbUser = "jspid";
		String dbPass = "jsppass";
		Connection con = null;
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection(dbUrl, dbUser, dbPass);
		return con;*/
		//Context객체생성
		//DataSource ds = 메서드호출 lookup(자원의 이름)
		//con = getConnection()
		Connection con = null;
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MysqlDB");
		con = ds.getConnection();		
		return con;
	}// getConnection()

	public void insertBoard(boardBean bb) {
		Connection con = null;
		String sql = "";
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		try {
			con = getConnection();
			sql = "select max(num) from board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bb.setNum(rs.getInt(1) + 1);
			}
			sql = "insert into board values(?,?,?,?,?,?,?,?,?,?,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bb.getNum());
			pstmt.setString(2, bb.getName());
			pstmt.setString(3, bb.getPass());
			pstmt.setString(4, bb.getSubject());
			pstmt.setString(5, bb.getContent());
			pstmt.setString(6, bb.getFile());
			pstmt.setInt(7, bb.getNum());
			pstmt.setInt(8, 0);
			pstmt.setInt(9, 0);
			pstmt.setInt(10, 0);
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
	}// insertBoard()
	
	public void insertImgBoard(boardBean bb) {
		Connection con = null;
		String sql = "";
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		try {
			con = getConnection();
			sql = "select max(num) from fileboard";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bb.setNum(rs.getInt(1) + 1);
			}
			sql = "insert into fileboard(num,name,pass,subject,content,file,readcount,date) values(?,?,?,?,?,?,?,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bb.getNum());
			pstmt.setString(2, bb.getName());
			pstmt.setString(3, bb.getPass());
			pstmt.setString(4, bb.getSubject());
			pstmt.setString(5, bb.getContent());
			pstmt.setString(6, bb.getFile());
			pstmt.setInt(7, 0);
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
	}// insertImgBoard()

	public int getBoardCount() {
		Connection con = null;
		String sql = "";
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		int count = 0;
		try {
			con = getConnection();
			sql = "select count(*) from board";
			pstmt = con.prepareStatement(sql);
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
	}// getBoardCount()
	
	public int getBoardCount(String search) {
		Connection con = null;
		String sql = "";
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		int count = 0;
		try {
			con = getConnection();
			sql = "select count(*) from board where subject like ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%"+search+"%");
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
	}// getBoardCount(String)
	
	public int getImgBoardCount() {
		Connection con = null;
		String sql = "";
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		int count = 0;
		try {
			con = getConnection();
			sql = "select count(*) from fileboard";
			pstmt = con.prepareStatement(sql);
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
	}// getBoardCount()
	
	public int getImgBoardCount(String search) {
		Connection con = null;
		String sql = "";
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		int count = 0;
		try {
			con = getConnection();
			sql = "select count(*) from fileboard where subject like ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%"+search+"%");
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
	}// getBoardCount(String)

	public List getBoardList(int startRow, int pageSize) {
		Connection con = null;
		String sql = "";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List boardList = new ArrayList();
		try {
			con = getConnection();
			sql = "select * from board order by re_ref desc, re_seq asc limit ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow - 1);
			pstmt.setInt(2, pageSize);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				boardBean bb = new boardBean();
				bb.setNum(rs.getInt("num"));
				bb.setName(rs.getString("name"));
				bb.setPass(rs.getString("pass"));
				bb.setSubject(rs.getString("subject"));
				bb.setContent(rs.getString("content"));
				bb.setFile(rs.getString("file"));
				bb.setRe_ref(rs.getInt("re_ref"));
				bb.setRe_lev(rs.getInt("re_lev"));
				bb.setRe_seq(rs.getInt("re_seq"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setDate(rs.getDate("date"));
				boardList.add(bb);
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
		return boardList;

	}// getBoardList()
	
	public List getBoardList(int startRow, int pageSize, String search) {
		Connection con = null;
		String sql = "";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List boardList = new ArrayList();
		try {
			con = getConnection();
			sql = "select * from board  where subject like ? order by re_ref desc, re_seq asc limit ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%"+search+"%");
			pstmt.setInt(2, startRow - 1);
			pstmt.setInt(3, pageSize);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				boardBean bb = new boardBean();
				bb.setNum(rs.getInt("num"));
				bb.setName(rs.getString("name"));
				bb.setPass(rs.getString("pass"));
				bb.setSubject(rs.getString("subject"));
				bb.setContent(rs.getString("content"));
				bb.setFile(rs.getString("file"));
				bb.setRe_ref(rs.getInt("re_ref"));
				bb.setRe_lev(rs.getInt("re_lev"));
				bb.setRe_seq(rs.getInt("re_seq"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setDate(rs.getDate("date"));
				boardList.add(bb);
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
		return boardList;

	}// getBoardList(int,int,String)
	
	public List getImgBoardList(int startRow, int pageSize) {
		Connection con = null;
		String sql = "";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List boardList = new ArrayList();
		try {
			con = getConnection();
			sql = "select * from fileboard order by num desc limit ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow - 1);
			pstmt.setInt(2, pageSize);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				boardBean bb = new boardBean();
				bb.setNum(rs.getInt("num"));
				bb.setName(rs.getString("name"));
				bb.setPass(rs.getString("pass"));
				bb.setSubject(rs.getString("subject"));
				bb.setContent(rs.getString("content"));
				bb.setFile(rs.getString("file"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setDate(rs.getDate("date"));
				boardList.add(bb);
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
		return boardList;

	}// getImgBoardList()
	
	public List getImgBoardList(int startRow, int pageSize, String search) {
		Connection con = null;
		String sql = "";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List boardList = new ArrayList();
		try {
			con = getConnection();
			sql = "select * from fileboard where subject like ? order by num desc limit ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "%"+search+"%");
			pstmt.setInt(2, startRow - 1);
			pstmt.setInt(3, pageSize);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				boardBean bb = new boardBean();
				bb.setNum(rs.getInt("num"));
				bb.setName(rs.getString("name"));
				bb.setPass(rs.getString("pass"));
				bb.setSubject(rs.getString("subject"));
				bb.setContent(rs.getString("content"));
				bb.setFile(rs.getString("file"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setDate(rs.getDate("date"));
				boardList.add(bb);
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
		return boardList;

	}// getImgBoardList(int,int,String)

	public boardBean getBoard(int num) {
		Connection con = null;
		String sql = "";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boardBean bb = null;
		try {
			con = getConnection();
			sql = "select * from board where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bb = new boardBean();
				bb.setNum(rs.getInt("num"));
				bb.setName(rs.getString("name"));
				bb.setPass(rs.getString("pass"));
				bb.setSubject(rs.getString("subject"));
				bb.setContent(rs.getString("content"));
				bb.setFile(rs.getString("file"));
				bb.setRe_ref(rs.getInt("re_ref"));
				bb.setRe_lev(rs.getInt("re_lev"));
				bb.setRe_seq(rs.getInt("re_seq"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setDate(rs.getDate("date"));
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
		return bb;
	}// getBoard();
	
	public boardBean getImgBoard(int num) {
		Connection con = null;
		String sql = "";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		boardBean bb = null;
		try {
			con = getConnection();
			sql = "select * from fileboard where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bb = new boardBean();
				bb.setNum(rs.getInt("num"));
				bb.setName(rs.getString("name"));
				bb.setPass(rs.getString("pass"));
				bb.setSubject(rs.getString("subject"));
				bb.setContent(rs.getString("content"));
				bb.setFile(rs.getString("file"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setDate(rs.getDate("date"));
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
		return bb;
	}// getImgBoard();

	public void updateReadcount(int num) {
		Connection con = null;
		String sql = "";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			sql = "update board set readcount = readcount+1 where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			}
		 catch (Exception e) {
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
	}// updateReadcount()
	
	public void updateImgReadcount(int num) {
		Connection con = null;
		String sql = "";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			con = getConnection();
			sql = "update fileboard set readcount = readcount+1 where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			}
		 catch (Exception e) {
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
	}// updateImgReadcount()

	public int updateBoard(boardBean bb,int num) {
		Connection con = null;
		String sql = "";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int check = -1;
		try {
			con = getConnection();
			sql = "select pass from board where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			rs.next();
			if (bb.getPass().equals(rs.getString("pass"))) {
					sql = "update board set subject=?, content=?,file=? where num=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, bb.getSubject());
					pstmt.setString(2, bb.getContent());
					pstmt.setString(3, bb.getFile());
					pstmt.setInt(4, num);
					pstmt.executeUpdate();
					check = 1;
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
		return check;
	}// updateBoard()
	
	public int imgUpdateBoard(boardBean bb,int num) {
		Connection con = null;
		String sql = "";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int check = -1;
		try {
			con = getConnection();
			sql = "select pass from fileboard where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			rs.next();
			if (bb.getPass().equals(rs.getString("pass"))) {
					sql = "update fileboard set subject=?, content=?, file=? where num=?";
					pstmt = con.prepareStatement(sql);
					pstmt.setString(1, bb.getSubject());
					pstmt.setString(2, bb.getContent());
					pstmt.setString(3, bb.getFile());
					pstmt.setInt(4, num);
					pstmt.executeUpdate();
					check = 1;
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
		return check;
	}// imgUpdateBoard()
	
	public int deleteBoard(int num, String pass){
		Connection con = null;
		String sql = "";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int check=-1;
		try {
			con = getConnection();
			sql = "select pass from board where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			rs.next();
				if (pass.equals(rs.getString("pass"))) {
					sql = "delete from board where num=? and pass=?";//두개가 동시에 일치하는 조건
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, num);
					pstmt.setString(2, pass);
					pstmt.executeUpdate();
					sql = "delete from comment where com_board=?";//댓글삭제
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, num);
					pstmt.executeUpdate();
					check= 1;
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
	}//delete board
	
	public int imgDeleteBoard(int num, String pass){
		Connection con = null;
		String sql = "";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int check=-1;
		try {
			con = getConnection();
			sql = "select pass from fileboard where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			rs.next();
				if (pass.equals(rs.getString("pass"))) {
					sql = "delete from fileboard where num=? and pass=?";//두개가 동시에 일치하는 조건
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, num);
					pstmt.setString(2, pass);
					pstmt.executeUpdate();
					check= 1;
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
	}//imgDeleteBoard
	
	public void reInsertBoard(boardBean bb){
		Connection con = null;
		String sql = "";
		ResultSet rs = null;
		PreparedStatement pstmt = null;
		try {
			con = getConnection();
			sql = "select max(num) from board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				bb.setNum(rs.getInt(1) + 1);
			}
			
			sql="update board set re_seq=re_seq+1 where re_ref=? and re_seq>?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bb.getRe_ref());
			pstmt.setInt(2, bb.getRe_seq());
			pstmt.executeUpdate();
			
			sql = "insert into board values(?,?,?,?,?,?,?,?,?,?,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, bb.getNum());
			pstmt.setString(2, bb.getName());
			pstmt.setString(3, bb.getPass());
			pstmt.setString(4, bb.getSubject());
			pstmt.setString(5, bb.getContent());
			pstmt.setString(6, bb.getFile());
			pstmt.setInt(7, bb.getRe_ref());
			pstmt.setInt(8, bb.getRe_lev()+1);
			pstmt.setInt(9, bb.getRe_seq()+1);
			pstmt.setInt(10, 0);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
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
	}//reInsertBoard();
	
	
}// memberDAO
