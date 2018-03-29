package lee.attendance.domain;

public class UserVerification {
    private Integer id;

    private String account;

    private String password;

    private String salt;

    private Boolean isLock;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account == null ? null : account.trim();
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password == null ? null : password.trim();
    }

    public String getSalt() {
        return salt;
    }

    public void setSalt(String salt) {
        this.salt = salt == null ? null : salt.trim();
    }

    public Boolean isLock() {
        return isLock;
    }

    public void setLock(Boolean isLock) {
        this.isLock = isLock;
    }
}