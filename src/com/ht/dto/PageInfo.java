package com.ht.dto;


import java.util.List;

public class PageInfo {
	
	private int current = 1;
	private int count;
	private int offset = 5;
	private int total;
	private int start;
	
	
	private List<?> list;


	
	
	/**
	 * @param current
	 */
	public PageInfo(int current) {
		this.current = current;
	}


	/**
	 * 
	 */
	public PageInfo() {}


	public int getCurrent() {
		return current;
	}


	public void setCurrent(int current) {
		this.current = current;
	}


	public int getCount() {
		return count;
	}


	public void setCount(int count) {
		this.count = count;
		
		
		this.setTotal(
			this.count / this.offset 
				+ ((this.count % this.offset) > 0 ? 1 : 0)
				);
	}


	public int getOffset() {
		return offset;
	}


	public void setOffset(int offset) {
		if( offset > 0 )
			this.offset = offset;
	}


	public int getTotal() {
		return total;
	}


	public void setTotal(int total) {
		this.total = total;
	}


	public int getStart() {
		
		this.start = (this.current - 1) * this.offset;
		
		return start;
	}


	public void setStart(int start) {
		this.start = start;
	}


	public List<?> getList() {
		return list;
	}


	public void setList(List<?> list) {
		this.list = list;
	}


	@Override
	public String toString() {
		return "PageInfo [current=" + current + ", count=" + count + ", offset=" + offset + ", total=" + total
				+ ", start=" + start + ", list=" + list + "]";
	}

}
