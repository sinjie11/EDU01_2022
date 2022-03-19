package com.mydev.edu.mber.vo;

import java.io.Serializable;

public class MberVO implements Serializable {

	private static final long serialVersionUID = 1L;
	
	/* 회원번호 */
	private String mberNo;
	
	/* 회원아이디 */
	private String mberId;
	
	/* 회원비밀번호 */
	private String mberPw;
	
	/* 이름 */
	private String name;
	
	/* 생년월일 */
	private String birth;
	
	/* 이메일 */
	private String email;
	
	/* 휴대폰번호 */
	private String mobileTelNo;
	
	/* 사용여부 */
	private String useYn;
	
	/* 등록자ID */
	private String regId;
	
	/* 등록일시 */
	private String regDate;
	
	/* 수정자ID */
	private String updtId;
	
	/* 수정일시 */
	private String updtDate;
	
	private String rnum;

	public String getMberNo() {
		return mberNo;
	}

	public void setMberNo(String mberNo) {
		this.mberNo = mberNo;
	}

	public String getMberId() {
		return mberId;
	}

	public void setMberId(String mberId) {
		this.mberId = mberId;
	}

	public String getMberPw() {
		return mberPw;
	}

	public void setMberPw(String mberPw) {
		this.mberPw = mberPw;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getBirth() {
		return birth;
	}

	public void setBirth(String birth) {
		this.birth = birth;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getMobileTelNo() {
		return mobileTelNo;
	}

	public void setMobileTelNo(String mobileTelNo) {
		this.mobileTelNo = mobileTelNo;
	}

	public String getUseYn() {
		return useYn;
	}

	public void setUseYn(String useYn) {
		this.useYn = useYn;
	}

	public String getRegId() {
		return regId;
	}

	public void setRegId(String regId) {
		this.regId = regId;
	}

	public String getRegDate() {
		return regDate;
	}

	public void setRegDate(String regDate) {
		this.regDate = regDate;
	}

	public String getUpdtId() {
		return updtId;
	}

	public void setUpdtId(String updtId) {
		this.updtId = updtId;
	}

	public String getUpdtDate() {
		return updtDate;
	}

	public void setUpdtDate(String updtDate) {
		this.updtDate = updtDate;
	}

	public String getRnum() {
		return rnum;
	}

	public void setRnum(String rnum) {
		this.rnum = rnum;
	}
	
	
	
}