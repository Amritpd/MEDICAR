package com.mie.model;

import java.util.Date;

public class File {
	private int fileId, patientId, bpSyst, bpDiast, rhr, chol;
	private Date timeStamp;
	
	
	public int getPatientId() {
		return patientId;
	}

	public void setPatientId(int patientId) {
		this.patientId = patientId;
	}

	public Date getTimeStamp() {
		return timeStamp;
	}

	public void setTimeStamp(Date timeStamp) {
		this.timeStamp = timeStamp;
	}

	public int getFileId() {
		return fileId;
	}

	public void setFileId(int fileId) {
		this.fileId = fileId;
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
		return chol;
	}

	public void setChol(int chol) {
		this.chol = chol;
	}
	
	
}