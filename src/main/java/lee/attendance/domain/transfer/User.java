package lee.attendance.domain.transfer;

public class User {
	private String sex;
	private String role;
	private String deptId;
	private String userName;
	private String prefixAccount;
	private String suffixAccount;
	private String number;
	public String getNumber() {
		return number;
	}
	public void setNumber(String number) {
		this.number = number;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public String getDeptId() {
		return deptId;
	}
	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getPrefixAccount() {
		return prefixAccount;
	}
	public void setPrefixAccount(String prefixAccount) {
		this.prefixAccount = prefixAccount;
	}
	public String getSuffixAccount() {
		return suffixAccount;
	}
	public void setSuffixAccount(String suffixAccount) {
		this.suffixAccount = suffixAccount;
	}
}
