package reference;

import java.sql.Timestamp;

public class ReferenceBean {
	private int num;
	private String refer_id;
	private String refer_subject;
	private String refer_file_name;
	private String refer_content;
	private int readcount;
	private Timestamp reg_date;
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getRefer_id() {
		return refer_id;
	}
	public void setRefer_id(String refer_id) {
		this.refer_id = refer_id;
	}
	public String getRefer_subject() {
		return refer_subject;
	}
	public void setRefer_subject(String refer_subject) {
		this.refer_subject = refer_subject;
	}
	public String getRefer_file_name() {
		return refer_file_name;
	}
	public void setRefer_file_name(String refer_file_name) {
		this.refer_file_name = refer_file_name;
	}
	public String getRefer_content() {
		return refer_content;
	}
	public void setRefer_content(String refer_content) {
		this.refer_content = refer_content;
	}
	public int getReadcount() {
		return readcount;
	}
	public void setReadcount(int readcount) {
		this.readcount = readcount;
	}
	public Timestamp getReg_date() {
		return reg_date;
	}
	public void setReg_date(Timestamp reg_date) {
		this.reg_date = reg_date;
	}
	
	
}
