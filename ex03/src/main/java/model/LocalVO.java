package model;

import java.util.*;

public class LocalVO {
	private int id;
	private String lid;
	private String lname;
	private String laddress;
	private String lphone;
	private String lurl;
	private String x;
	private String y;
	private Date ldate;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getLid() {
		return lid;
	}
	public void setLid(String lid) {
		this.lid = lid;
	}
	public String getLname() {
		return lname;
	}
	public void setLname(String lname) {
		this.lname = lname;
	}
	public String getLaddress() {
		return laddress;
	}
	public void setLaddress(String laddress) {
		this.laddress = laddress;
	}
	public String getLphone() {
		return lphone;
	}
	public void setLphone(String lphone) {
		this.lphone = lphone;
	}
	public String getLurl() {
		return lurl;
	}
	public void setLurl(String lurl) {
		this.lurl = lurl;
	}
	public String getX() {
		return x;
	}
	public void setX(String x) {
		this.x = x;
	}
	public String getY() {
		return y;
	}
	public void setY(String y) {
		this.y = y;
	}
	public Date getLdate() {
		return ldate;
	}
	public void setLdate(Date ldate) {
		this.ldate = ldate;
	}
	@Override
	public String toString() {
		return "LocalVO [id=" + id + ", lid=" + lid + ", lname=" + lname + ", laddress=" + laddress + ", lphone="
				+ lphone + ", lurl=" + lurl + ", x=" + x + ", y=" + y + ", ldate=" + ldate + "]";
	}
	
	
}
