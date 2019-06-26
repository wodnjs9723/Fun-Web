package reference;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class ReferenceDAO {
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";
	
	private Connection getCon() throws Exception{
		/*String DRIVER = "com.mysql.jdbc.Driver";
		String URL = "jdbc:mysql://localhost:3306/funity";
		String ID = "root";
		String PW = "1234";
		
		Class.forName(DRIVER);
		con = DriverManager.getConnection(URL, ID, PW);
		return con;*/
		Context init = new InitialContext();	
		DataSource ds = 
		(DataSource)init.lookup("java:comp/env/jdbc/mysqlDB");
				
		con = ds.getConnection();
				
		return con;
	}
	
	public void closeDB(){
		try {
			if(rs != null){ rs.close(); }
			if(pstmt != null){ pstmt.close(); }
			if(con != null){ con.close(); }
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public void insertrefer(ReferenceBean rb){
		int num=0;
		try {
			con = getCon();
			sql = "SELECT COUNT(*) FROM reference";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				 num = rs.getInt(1)+1;
			}
			System.out.println("�ڷ�ǹ�ȣ ����");
			
			sql="INSERT INTO reference (num, refer_id, refer_subject, refer_file_name, refer_content, readcount, reg_date) "
				+"VALUES(?,?,?,?,?,?,now())";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				pstmt.setString(2, rb.getRefer_id());
				pstmt.setString(3, rb.getRefer_subject());
				pstmt.setString(4, rb.getRefer_file_name());
				pstmt.setString(5, rb.getRefer_content());
				pstmt.setInt(6, 0);
				
				pstmt.executeUpdate();
				System.out.println("�ڷ�� ��� �Ϸ�");
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
	}
	
	public int getReferenceCount(){
		int count = 0;
		try {
			con = getCon();
			
			sql ="SELECT COUNT(*) FROM reference";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				count = rs.getInt(1);
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeDB();
		}
		return count;
	}
	
	public List getReferenceList(){
		List referenceList = new ArrayList();
		
		try {
			con = getCon();
			sql = "SELECT * FROM reference ORDER BY num DESC limit 5";
			
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				ReferenceBean rb = new ReferenceBean();
				rb.setNum(rs.getInt("num"));
				rb.setRefer_id(rs.getString("refer_id"));
				rb.setRefer_subject(rs.getString("refer_subject"));
				rb.setRefer_file_name(rs.getString("refer_file_name"));
				rb.setRefer_content(rs.getString("refer_content"));
				rb.setReadcount(rs.getInt("readcount"));
				rb.setReg_date(rs.getTimestamp("reg_date"));
				
				referenceList.add(rb);
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		
		return referenceList;
	}
	
	
	public List getReferenceList(int startRow, int pageSize){
		List referenceList = new ArrayList();
		
		try {
			con = getCon();
			sql = "SELECT * FROM reference ORDER BY num DESC";
			
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				ReferenceBean rb = new ReferenceBean();
				rb.setNum(rs.getInt("num"));
				rb.setRefer_id(rs.getString("refer_id"));
				rb.setRefer_subject(rs.getString("refer_subject"));
				rb.setRefer_file_name(rs.getString("refer_file_name"));
				rb.setRefer_content(rs.getString("refer_content"));
				rb.setReadcount(rs.getInt("readcount"));
				rb.setReg_date(rs.getTimestamp("reg_date"));
				
				referenceList.add(rb);
			}
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		
		return referenceList;
	}
	
	public void updateReadCount(int num){
		int count = 0;
		
		try {
			con = getCon();
			
			sql = "UPDATE reference SET readcount = readcount+1 WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			pstmt.executeUpdate();
			System.out.println("자료실 조회수 증가");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
	}
	
	public ReferenceBean getReference(int num){
		ReferenceBean rb = new ReferenceBean();
			try {
				con = getCon();
				sql="SELECT * FROM reference WHERE num=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setInt(1, num);
				rs = pstmt.executeQuery();
				if(rs.next()){
					rb.setNum(rs.getInt("num"));
					rb.setRefer_id(rs.getString("refer_id"));
					rb.setRefer_subject(rs.getString("refer_subject"));
					rb.setRefer_file_name(rs.getString("refer_file_name"));
					rb.setRefer_content(rs.getString("refer_content"));
					rb.setReg_date(rs.getTimestamp("reg_date"));
					rb.setReadcount(rs.getInt("readcount"));
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally {
				closeDB();
			}
			
		return rb;
	}
	
	public void updaterefer(ReferenceBean rb){
		try {
			con = getCon();
			sql = "UPDATE reference SET refer_subject=?, refer_content=?, refer_file_name=? WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, rb.getRefer_subject());
			pstmt.setString(2, rb.getRefer_content());
			pstmt.setString(3, rb.getRefer_file_name());
			pstmt.setInt(4, rb.getNum());
			
			pstmt.executeUpdate();
			System.out.println("자료실 업데이트 완료");
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}
	
	public String deleteRefer(int num){
		String oldfname = null;
		
		try {
			con = getCon();
			sql = "SELECT refer_file_name FROM reference WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				oldfname = rs.getString(1);
			}
			
			sql="DELETE FROM reference where num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			pstmt.executeUpdate();
			
			System.out.println("자료 삭제 완료");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeDB();
		}
	
		
		return oldfname;
	}
}
