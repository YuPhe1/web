package model;

import java.util.Date;

public class BookVO {
	
	private int seq;
	private String title;
	private String thumbnail;
	private int price;
	private String pdate;
	private String authors;
	private String url;
	private String isbn;
	private String contents;
	private Date rdate;
	private String publisher;
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getThumbnail() {
		return thumbnail;
	}
	public void setThumbnail(String thumbnail) {
		this.thumbnail = thumbnail;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getPdate() {
		return pdate;
	}
	public void setPdate(String pdate) {
		this.pdate = pdate;
	}
	public String getAuthors() {
		return authors;
	}
	public void setAuthors(String authors) {
		this.authors = authors;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public String getIsbn() {
		return isbn;
	}
	public void setIsbn(String isbn) {
		this.isbn = isbn;
	}
	public String getContents() {
		return contents;
	}
	public void setContents(String contents) {
		this.contents = contents;
	}
	public Date getRdate() {
		return rdate;
	}
	public void setRdate(Date rdate) {
		this.rdate = rdate;
	}
	public String getPublisher() {
		return publisher;
	}
	public void setPublisher(String publisher) {
		this.publisher = publisher;
	}
	@Override
	public String toString() {
		return "BookVO [seq=" + seq + ", title=" + title + ", thumbnail=" + thumbnail + ", price=" + price + ", pdate="
				+ pdate + ", authors=" + authors + ", url=" + url + ", isbn=" + isbn + ", contents=" + contents
				+ ", rdate=" + rdate + ", publisher=" + publisher + "]";
	}
	
	
}
