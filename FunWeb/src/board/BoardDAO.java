package board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import board.BoardBean;

public class BoardDAO {
	Connection con = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String sql = "";

	private Connection getCon() throws Exception {
		/*
		 * String DRIVER = "com.mysql.jdbc.Driver"; String URL =
		 * "jdbc:mysql://localhost:3306/funity"; String ID = "root"; String PW =
		 * "1234";
		 * 
		 * Class.forName(DRIVER); con = DriverManager.getConnection(URL, ID,
		 * PW); return con;
		 */

		// 커넥션 풀 프로그램 설치
		// Web-INF -> lib -> 파일 복사
		// http://commons.apache.org/
		// commons-collections-3.2.1.jar
		// commons-dbcp-1.4.jar
		// commons-pool-1.6.jar

		// 1. WebContent -> META-INF -> context.xml 생성
		// 1,2단계 처리파일 -> 디비연동, 이름 정의

		// 2. WebContent -> WEB-INF -> web.xml파일 수정
		// 3. 해당 DB 작업 처리 (DAO) -> 연결정보의 이름 호출

		// Context 객체 생성

		Context init = new InitialContext();
		// DataSource 디비 연동이름 호출
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/mysqlDB");

		con = ds.getConnection();

		return con;
	}

	public void closeDB() {
		try {
			if (rs != null) {
				rs.close();
			}
			if (pstmt != null) {
				pstmt.close();
			}
			if (con != null) {
				con.close();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	// insertBoard();
	public void insertBoard(BoardBean bb) {
		int num = 0;
		try {
			con = getCon();

			// num 게시판 글번호 계산
			sql = "SELECT MAX(num) FROM board";
			pstmt = con.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				num = rs.getInt(1) + 1;

				// num = rs.getInt("num")+1; // 에러
				// num = rs.getInt("MAX(num)")+1; // 가능
			}
			System.out.println("num = " + num);

			sql = "INSERT INTO board (" + "num,id,category,subject,content," + "readcount,re_ref,re_lev,re_seq,"
					+ "reg_date,file) VALUES (?,?,?,?,?,?,?,?,?,now())";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num); // 계산한 글 번호값
			pstmt.setString(2, bb.getId());
			pstmt.setString(3, bb.getCategory());
			pstmt.setString(4, bb.getSubject());
			pstmt.setString(5, bb.getContent());
			pstmt.setInt(6, 0); // 글 조회수 0
			pstmt.setInt(7, num); // re_ref 답변글 그룹 == 일반글의 글번호와 동일
			pstmt.setInt(8, 0); // re_lev 답변글 들여쓰기, 일반글은 들여쓰기 X
			pstmt.setInt(9, 0); // re_seq 답변글 순서, 일반글 순서가 제일 위쪽
			// data 정보는 sql 쿼리에서 now() 내장함수 사용
			

			// 4. 실행
			pstmt.executeUpdate();
			System.out.println("게시판 " + num + "번 글 작성 완료");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}
	// insertBoard();

	// getBoardCount()
	public int getBoardCount() {
		int count = 0;
		try {
			// 디비연결, 드라이버 로드
			con = getCon();
			// SQL 작성
			// 게시판에 있는 글 전체의 개수
			sql = "SELECT COUNT(*) FROM board";
			pstmt = con.prepareStatement(sql);
			// 실행
			rs = pstmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt(1);
			}
			System.out.println("작성된 글수 : " + count);

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeDB();
		}

		return count;
	}
	// getBoardCount()

	// getBoardList()
	public List getBoardList() {
		List boardList = new ArrayList();

		try {
			con = getCon();

			sql = "SELECT * FROM board ORDER BY num DESC limit 5;";
			pstmt = con.prepareStatement(sql);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// 글정보가 있다.
				// 글정보를 한번에 저장하는 객첸(BoardBean)
				BoardBean bb = new BoardBean();

				bb.setNum(rs.getInt("num"));
				bb.setId(rs.getString("id"));
				bb.setCategory(rs.getString("category"));
				bb.setSubject(rs.getString("subject"));
				bb.setContent(rs.getString("content"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setRe_ref(rs.getInt("re_ref"));
				bb.setRe_lev(rs.getInt("re_lev"));
				bb.setRe_seq(rs.getInt("re_seq"));
				bb.setReg_date(rs.getTimestamp("reg_date"));

				// bb -> arrayList 한칸저장
				boardList.add(bb);
			}
			System.out.println("게시글 목록 저장 완료");

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeDB();
		}

		return boardList;
	}
	// getBoardList()

	public List getBoardList(int startRow, int pageSize) {
		List boardList = new ArrayList();

		try {
			con = getCon();
			// 최신글이 제일 위쪽 위치
			// 정렬 : 그룹별로 내림차순, 글순서대로 오름차순
			// 글 잘라오기(필요한만큼만 가졍오기)(limit(시작행 -1, 개수))

			sql = "SELECT * FROM board " + "ORDER BY re_ref DESC, " + "re_seq ASC " + "LIMIT ?,?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, startRow - 1);
			pstmt.setInt(2, pageSize);

			rs = pstmt.executeQuery();

			while (rs.next()) {
				// 글정보가 있다.
				// 글정보를 한번에 저장하는 객체(BoardBean)
				BoardBean bb = new BoardBean();

				bb.setNum(rs.getInt("num"));
				bb.setId(rs.getString("id"));
				;
				bb.setCategory(rs.getString("category"));
				bb.setSubject(rs.getString("subject"));
				bb.setContent(rs.getString("content"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setRe_ref(rs.getInt("re_ref"));
				bb.setRe_lev(rs.getInt("re_lev"));
				bb.setRe_seq(rs.getInt("re_seq"));
				bb.setReg_date(rs.getTimestamp("reg_date"));

				// bb -> arrayList 한칸저장
				boardList.add(bb);
			}
			System.out.println("게시글 목록 저장 완료");

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeDB();
		}

		return boardList;
	}
	// getBoardList(startRow, pageSize)

	// updateReadcount(num)
	public void updateReadcount(int num) {

		try {
			con = getCon();
			// 조회수를 1증가 해당 글만 처리(num)
			sql = "UPDATE board SET readcount = readcount+1 WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);

			pstmt.executeUpdate();
			System.out.println("조회수 1증가 완료");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}
	// updateReadcount(num)

	// getBoard(num)
	public BoardBean getBoard(int num) {

		BoardBean bb = null;

		try {
			con = getCon();
			sql = "SELECT * FROM board WHERE num=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				bb = new BoardBean();

				bb.setNum(rs.getInt("num"));
				bb.setId(rs.getString("id"));
				bb.setCategory(rs.getString("category"));
				bb.setSubject(rs.getString("subject"));
				bb.setContent(rs.getString("content"));
				bb.setReadcount(rs.getInt("readcount"));
				bb.setRe_ref(rs.getInt("re_ref"));
				bb.setRe_lev(rs.getInt("re_lev"));
				bb.setRe_seq(rs.getInt("re_seq"));
				bb.setReg_date(rs.getTimestamp("reg_date"));
			}

			System.out.println("글번호에 해당하는 정보 저장 완료!!");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeDB();
		}

		return bb;

	}
	// getBoard(num)

	// updateBoard();
	public void updateBoard(BoardBean bb) {
		try {
			con = getCon();

			// num 게시판 글번호 계산
			sql ="UPDATE board SET category=?,subject=?,content=? where num=?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, bb.getCategory());
			pstmt.setString(2, bb.getSubject());
			pstmt.setString(3, bb.getContent());
			pstmt.setInt(4, bb.getNum());

			// 4. 실행
			pstmt.executeUpdate();
			System.out.println("게시판  글 수정 완료");
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			closeDB();
		}
	}
	// updateBoard();
	
	public int deleteborad(String id, String pass, int num){
		int check = 0;
		try {
			con = getCon();
			String sql = "SELECT pass from member where id=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				if(pass.equals(rs.getString("pass"))){
					sql = "DELETE FROM board WHERE num=?";
					
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, num);
					
					pstmt.executeUpdate();
					check = 1;
				}else{
					check = 0; // 비밀번호 오류
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
}
