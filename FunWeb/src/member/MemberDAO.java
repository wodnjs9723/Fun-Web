package member;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {
	
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
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
	
	
	// joinIdCheck(id)
	public int joinIdCheck(String id){
		int check = 0;
		try {
						
			con = getCon();
						
			String sql = "SELECT * FROM member WHERE id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
				
			if(rs.next()){
				// 아이디 중복
				check = 1;
			}else {
				// 아이디 없음
				check = 0;
			}
			System.out.println("ID 체크완료");
						
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			closeDB();
		}
					
		return check;
	}
	// joinIdCheck(id) 
	
	public void insertMember(MemberBean mb){
		
		try {
			con = getCon();
			System.out.println("DB 연결완료");
			String sql = "INSERT INTO member VALUES(?,?,?,?,?,?,?,?,?,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, mb.getId());
			pstmt.setString(2, mb.getPass());
			pstmt.setString(3, mb.getName());
			pstmt.setString(4, mb.getEmail());
			pstmt.setInt(5, mb.getPostcode());
			pstmt.setString(6, mb.getAddress());
			pstmt.setString(7, mb.getDetailaddress());
			pstmt.setString(8, mb.getExtraaddress());
			pstmt.setString(9, mb.getPhone());
			pstmt.executeUpdate(); 
			
			
			System.out.println("회원가입완료");
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			closeDB();
		}
	}
	// insertMember() �쉶�썝媛��엯
	
	// idCheck(id,pass) �쉶�썝泥댄겕 (濡쒓렇�씤 �룞�옉)
	public int idCheck(String id, String pass){
		int check = -1; 
		try {
			
			con = getCon();
	
			String sql = "SELECT pass FROM member WHERE id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				if(pass.equals(rs.getString("pass"))){
					// 비밀번호 O
					check = 1;
				}else{
					// 비밀번호 틀림
					check = 0;
				}
			} else{
				// 아이디없음 X
				check = -1;
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return check;
	}
	// idCheck(id,pass) �쉶�썝泥댄겕(濡쒓렇�씤 �룞�옉)
	
	
	// getMember(id) id �빐�떦�븯�뒗 �젙蹂� 媛��졇�삤�뒗 硫붿꽌�뱶
	public MemberBean getMember(String id){
		
		MemberBean mb = null;
		
		try {
			// �뵒鍮꾩뿰寃�
			con = getCon();
			
			String sql = "SELECT * FROM member WHERE id =?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			// 4. �떎�뻾
			rs = pstmt.executeQuery();
			// 5. 寃곌낵 泥섎━
			// id�뿉 �빐�떦�븯�뒗 �젙蹂대�� ���옣
			// MemberBean ���옣
			
			if(rs.next()){
				mb = new MemberBean();
				mb.setName(rs.getString("name"));
				mb.setEmail(rs.getString("email"));
				mb.setPostcode(rs.getInt("postcode"));
				mb.setAddress(rs.getString("address"));
				mb.setDetailaddress(rs.getString("detailaddress"));
				mb.setExtraaddress(rs.getString("extraaddress"));
				mb.setPhone(rs.getString("phone"));
			}
			System.out.println("id에 해당하는 정보");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeDB();
		}
		
		return mb;
	}
	// getMember(id) id �빐�떦�븯�뒗 �젙蹂� 媛��졇�삤�뒗 硫붿꽌�뱶
	
	// updateMember(mb)
		public void updateMember(MemberBean mb) {
			int check = 0;
			try {
				// �뱶�씪�씠踰꾨줈�뱶 & �뵒鍮꾩뿰寃�
				con = getCon();
				
				String sql = "update member set pass=?, name=?, email=?, postcode=?, address=?, detailaddress=?, extraaddress=?, phone=? where id =?";

				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, mb.getPass());
				pstmt.setString(2, mb.getName());
				pstmt.setString(3, mb.getEmail());
				pstmt.setInt(4, mb.getPostcode());
				pstmt.setString(5, mb.getAddress());
				pstmt.setString(6, mb.getDetailaddress());
				pstmt.setString(7, mb.getExtraaddress());
				pstmt.setString(8, mb.getPhone());
				pstmt.setString(9, mb.getId());

				pstmt.executeUpdate();
						

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				closeDB();
			}

		}

		// updateMember(mb)
		
		// deleteMember(id,pass)
		public int deleteMember(String id, String pass){
			int check = 0;
			try {
				con = getCon();
				
				String sql = "SELECT pass from member where id=?";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					if(pass.equals(rs.getString("pass"))){
						sql = "DELETE FROM member WHERE id=?";
						
						pstmt = con.prepareStatement(sql);
						pstmt.setString(1, id);
						
						pstmt.executeUpdate();
						check = 1;
					}else{
						check = 0; // 鍮꾨�踰덊샇 �삤瑜�
					}
				}
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally{
				closeDB();
			}
			return check;
		}
		// deleteMember(id,pass)
		
		// getMemberList()
		/* public List<MemberBean> getMemberList(){
			List<MemberBean> memberList = new ArrayList<MemberBean>();
			// ArrayList memberList = new ArrayList();
			
			try {
				con  = getCon();
				String sql = "SELECT * FROM member";
				pstmt = con.prepareStatement(sql);
				rs = pstmt.executeQuery();
				
				while(rs.next()){
					// �븳�궗�엺�쓽 �젙蹂대�� ���옣�븯�뒗 媛앹껜
					MemberBean mb = new MemberBean();
					mb.setAge(rs.getInt("age"));
					mb.setEmail(rs.getString("email"));
					mb.setGender(rs.getString("gender"));
					mb.setName(rs.getString("name"));
					mb.setId(rs.getString("id"));
					mb.setPass(rs.getString("pass"));
					mb.setReg_date(rs.getTimestamp("reg_date"));
					
					// �븳紐낆쓽 �젙蹂�(MemberBean) ArrayList �븳移몄뿉 ���옣
					memberList.add(mb);
				}
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}finally{
				try {
					if (rs != null) {
						rs.close();
					}
					if(pstmt != null){
						pstmt.close();
					}
					if(con != null){
						con.close();
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			
			
			
			return memberList;
		}
		// getMemberList() */
		
	}
