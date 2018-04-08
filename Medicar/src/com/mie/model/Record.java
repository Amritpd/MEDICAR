package com.mie.model;

public class Record {
	
	private int bpSyst, bpDiast, rhr, cholesterol;
	private String date;
	
	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public int getBpSyst() {
		return bpSyst;
	}

	public void setBpSyst(int bpSyst) {
		this.bpSyst = bpSyst;
	}
	
	public int getBpDiast() {
		return bpDiast;
	}

	public void setBpDiast(int bpDiast) {
		this.bpDiast = bpDiast;
	}
	
	public int getRHR() {
		return rhr;
	}

	public void setRHR(int rhr) {
		this.rhr = rhr;
	}
	
	public int getChol() {
		return cholesterol;
	}

	public void setChol(int chol) {
		this.cholesterol = chol;
	}
}