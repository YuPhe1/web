package model;

import java.util.Date;

public class ProductVO {

	private int pcode;
	private String pname;
	private int price;
	private Date rdate;
	public int getPcode() {
		return pcode;
	}
	public void setPcode(int pcode) {
		this.pcode = pcode;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public Date getRdate() {
		return rdate;
	}
	public void setRdate(Date rdate) {
		this.rdate = rdate;
	}
	@Override
	public String toString() {
		return "ProductVO [pcode=" + pcode + ", pname=" + pname + ", price=" + price + ", rdate=" + rdate + "]";
	}
	
	
}
