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

public class CommentDAO {
	
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
	
	public void insertcomment(CommentBean cb){
		int num = 0;
        try {
           con = getCon();
           
           // �۹�ȣ ���
           // DB�� ����� �۹�ȣ�� ���� ū���� �����ͼ�
           // +1 �ۼ����� ��ȣ�� ����
           sql = "SELECT MAX(num) FROM comment";
           pstmt = con.prepareStatement(sql);
           rs = pstmt.executeQuery();
           
           if(rs.next()){
              num = rs.getInt(1)+1;
           }
           System.out.println("��� ��ȣ ����"+num);
           
           // sql & pstmt (�Խñ� �ۼ�)
           sql = "INSERT INTO comment ("
                 +"num, id, re_ref, re_lev, re_seq,"
                 +"comment, board_num, reg_date)"
                 +" VALUES ("
                 +"?,?,?,?,?,?,?,now())";
           
           pstmt = con.prepareStatement(sql);
           pstmt.setInt(1, num); // ����� �� ��ȣ��
           pstmt.setString(2, cb.getId());
           pstmt.setInt(3, num); // re_ref �亯�� �׷� == �Ϲݱ��� �۹�ȣ�� ����
           pstmt.setInt(4, 0); // re_lev �亯�� �鿩����, �Ϲݱ��� �鿩���� X
           pstmt.setInt(5, 0); // re_seq �亯�� ����, �Ϲݱ� ������ ���� ����
           pstmt.setString(6, cb.getComment());
           pstmt.setInt(7, cb.getBoard_num());
           
           pstmt.executeUpdate();
           System.out.println("��� �ۼ� �Ϸ�");
           
           
           
           
        }catch (Exception e) {
        	e.printStackTrace();
		}finally {
			closeDB();
		}
	}
	
	public int getCommentCount(int board_num){
		int count=0;
		try {
			con = getCon();
			sql = "SELECT COUNT(*) FROM comment WHERE board_num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, board_num);
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
	
	
	public List getComment(int board_num){
		List commentList = new ArrayList();
		
		try {
			con = getCon();
			sql = "SELECT * FROM comment "
					+"WHERE board_num=? "
					+"ORDER BY re_ref ASC, re_seq ASC";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, board_num);
			
			rs = pstmt.executeQuery();
			
			while(rs.next()){
				CommentBean cb = new CommentBean();
				
				cb.setNum(rs.getInt("num"));
				cb.setId(rs.getString("id"));
				cb.setComment(rs.getString("comment"));
				cb.setRe_ref(rs.getInt("re_ref"));
				cb.setRe_lev(rs.getInt("re_lev"));
				cb.setRe_seq(rs.getInt("re_seq"));
				cb.setBoard_num(rs.getInt("board_num"));
				cb.setReg_date(rs.getTimestamp("reg_date"));
				cb.setRe_id(rs.getString("re_id"));
				
				commentList.add(cb);
			}
			System.out.println("�۹�ȣ�� �ش��ϴ� ��� ���� �Ϸ�!!");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeDB();
		}
		
		return commentList;
	}
	
	public void insertRe_Comment(CommentBean cb){
		int num = 0;
		
		try {
			con = getCon();
			sql = "SELECT MAX(num) FROM comment";
	        pstmt = con.prepareStatement(sql);
	        rs = pstmt.executeQuery();
	            
	        if(rs.next()){
	           num = rs.getInt(1)+1;
	        }
	        // ��� ���� ���ġ
            // re_ref(�۹�ȣ) / re_seq(�ۼ���)
            // ����ó�� : ���� �׷��ȣ(re_ref) ������ �ۼ������� ū
            // ���� ������� (re_seq)�� ���� +1 ����
            sql = "UPDATE comment SET re_seq = re_seq+1 "
                 +"WHERE re_ref=? AND re_seq>?";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, cb.getRe_ref());
            pstmt.setInt(2, cb.getRe_seq());
            pstmt.executeUpdate();
            
            sql = "INSERT INTO comment ("
            		  +"num,id,re_ref,re_lev,re_seq,"
	                  +"comment,board_num,reg_date,re_id) VALUES ("
	                  +"?,?,?,?,?,?,"
	                  +"?,now(),?)";
            pstmt = con.prepareStatement(sql);
            pstmt.setInt(1, num); // ����� �� ��ȣ��
            pstmt.setString(2, cb.getId());
            pstmt.setInt(3, cb.getRe_ref()); // re_ref �亯�� �׷� == �Ϲݱ��� �۹�ȣ�� ����
            pstmt.setInt(4, cb.getRe_lev()+1); // re_lev �亯�� �鿩����, �Ϲݱ��� �鿩���� X
            pstmt.setInt(5, cb.getRe_seq()+1); // re_seq �亯�� ����, �Ϲݱ� ������ ���� ����
            pstmt.setString(6, cb.getComment());
            pstmt.setInt(7, cb.getBoard_num());
            // pstmt.setDate(8, x); // data ������ sql �������� now() �����Լ� ���
            pstmt.setString(8, cb.getRe_id());
            
            pstmt.executeUpdate();
            System.out.println("댓글 작성 완료");
            
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}
	
	public CommentBean getCommentUpdate(int re_ref,int re_lev,int re_seq){
		CommentBean cb = new CommentBean();
		try {
			con = getCon();
			sql="SELECT * FROM comment where re_ref=? AND re_lev=? AND re_seq=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, re_ref);
			pstmt.setInt(2, re_lev);
			pstmt.setInt(3, re_seq);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				cb.setNum(rs.getInt("num"));
				cb.setId(rs.getString("id"));
				cb.setComment(rs.getString("comment"));
				cb.setRe_ref(rs.getInt("re_ref"));
				cb.setRe_lev(rs.getInt("re_lev"));
				cb.setRe_seq(rs.getInt("re_seq"));
				cb.setBoard_num(rs.getInt("board_num"));
				cb.setReg_date(rs.getTimestamp("reg_date"));
				cb.setRe_id(rs.getString("re_id"));
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return cb;
	}
	
	public void insertcommentUpdate(CommentBean cb){
		try {
			con = getCon();
			
			sql="UPDATE comment SET comment=? where num=?";
			
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, cb.getComment());
			pstmt.setInt(2, cb.getNum());
			
			pstmt.executeUpdate();
			System.out.println("댓글수정완룐");
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeDB();
		}
		
	}
	
	public void deletecomment(int num){
		try {
			con = getCon();
			sql = "DELETE FROM comment WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			System.out.println("댓글삭제 완료");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}
}
