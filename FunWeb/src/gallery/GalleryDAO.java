package gallery;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class GalleryDAO {
	
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
	
	public void insertImage(GalleryBean gb){
		int num=0;
		try {
			con = getCon();
			
			sql = "SELECT COUNT(*) FROM gallery";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				 num = rs.getInt(1)+1;
			}
			System.out.println("갤러리번호 생성");
			
			sql="INSERT INTO gallery (num, img_title, img_name, realpath, reg_date) "
				+"VALUES(?,?,?,?,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.setString(2, gb.getImg_title());
			pstmt.setString(3, gb.getImg_name());
			pstmt.setString(4, gb.getRealpath());
			
			pstmt.executeUpdate();
			System.out.println("갤러리 등록 완료");
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeDB();
		}
	}
	
	public int getCount(){
		int count=0;
		
		try {
			con = getCon();
			
			sql ="SELECT COUNT(*) FROM gallery";
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
	
	public List getGallery(){
		List galleryList = new ArrayList();
		
		try {
			con = getCon();
			
			sql = "SELECT * FROM gallery "
				  +"ORDER BY num DESC";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()){
				GalleryBean gb = new GalleryBean();
				gb.setNum(rs.getInt("num"));
				gb.setImg_title(rs.getString("img_title"));
				gb.setImg_name(rs.getString("img_name"));
				gb.setRealpath(rs.getString("realpath"));
				gb.setReg_date(rs.getTimestamp("reg_date"));
				
				galleryList.add(gb);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		
		return galleryList;
	}
	
	public List main_getGallery(){ // 메인에 불러올 갤러리메서드
		List galleryList = new ArrayList();
		
		try {
			con = getCon();
			
			sql = "SELECT * FROM gallery "
				  +"ORDER BY num DESC limit 3";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()){
				GalleryBean gb = new GalleryBean();
				gb.setNum(rs.getInt("num"));
				gb.setImg_title(rs.getString("img_title"));
				gb.setImg_name(rs.getString("img_name"));
				gb.setRealpath(rs.getString("realpath"));
				gb.setReg_date(rs.getTimestamp("reg_date"));
				
				galleryList.add(gb);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		
		return galleryList;
	}
}
