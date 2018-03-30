package lee.attendance.domain.transfer;

import java.util.Date;

public class UserAccountInfo {
		private Integer id;

	    private String portrait;

	    private String introduce;

	    private Boolean sex;

	    private Date registerTime;

	    private String email;

	    private String phone;

	    private String realName;
	    
	    private String account;
	    
	    public String getAccount() {
			return account;
		}

		public void setAccount(String account) {
			this.account = account;
		}

		public Integer getId() {
	        return id;
	    }

	    public void setId(Integer id) {
	        this.id = id;
	    }

	    public String getPortrait() {
	        return portrait;
	    }

	    public void setPortrait(String portrait) {
	        this.portrait = portrait == null ? null : portrait.trim();
	    }

	    public String getIntroduce() {
	        return introduce;
	    }

	    public void setIntroduce(String introduce) {
	        this.introduce = introduce == null ? null : introduce.trim();
	    }

	    public Boolean getSex() {
	        return sex;
	    }

	    public void setSex(Boolean sex) {
	        this.sex = sex;
	    }

	    public Date getRegisterTime() {
	        return registerTime;
	    }

	    public void setRegisterTime(Date registerTime) {
	        this.registerTime = registerTime;
	    }

	    public String getEmail() {
	        return email;
	    }

	    public void setEmail(String email) {
	        this.email = email == null ? null : email.trim();
	    }

	    public String getPhone() {
	        return phone;
	    }

	    public void setPhone(String phone) {
	        this.phone = phone == null ? null : phone.trim();
	    }

	    public String getRealName() {
	        return realName;
	    }

	    public void setRealName(String realName) {
	        this.realName = realName == null ? null : realName.trim();
	    }

		@Override
		public String toString() {
			return "UserAccountInfo [id=" + id + ", portrait=" + portrait + ", introduce=" + introduce + ", sex=" + sex
					+ ", registerTime=" + registerTime + ", email=" + email + ", phone=" + phone + ", realName="
					+ realName + ", account=" + account + "]";
		}
	    
}
