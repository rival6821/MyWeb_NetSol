package comment;

import java.sql.Date;

public class commentBean {
	private int com_num;
	private int com_board;
	private String com_id;
	private Date com_date;
	private int com_parent;
	private String com_content;
	public int getCom_num() {
		return com_num;
	}
	public void setCom_num(int com_num) {
		this.com_num = com_num;
	}
	public int getCom_board() {
		return com_board;
	}
	public void setCom_board(int com_board) {
		this.com_board = com_board;
	}
	public String getCom_id() {
		return com_id;
	}
	public void setCom_id(String com_id) {
		this.com_id = com_id;
	}
	public Date getCom_date() {
		return com_date;
	}
	public void setCom_date(Date com_date) {
		this.com_date = com_date;
	}
	public int getCom_parent() {
		return com_parent;
	}
	public void setCom_parent(int com_parent) {
		this.com_parent = com_parent;
	}
	public String getCom_content() {
		return com_content;
	}
	public void setCom_content(String com_content) {
		this.com_content = com_content;
	}
	
	

}
