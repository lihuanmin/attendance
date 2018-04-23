package lee.attendance.domain;

import java.util.Date;

public class Attendance {
    private Integer id;

    private Integer userId;

    private Date workTime;

    private Date endTime;

    private Integer amStatus;

    private Integer pmStatus;

    private Date reference;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Date getWorkTime() {
        return workTime;
    }

    public void setWorkTime(Date workTime) {
        this.workTime = workTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(Date endTime) {
        this.endTime = endTime;
    }

    public Integer getAmStatus() {
        return amStatus;
    }

    public void setAmStatus(Integer amStatus) {
        this.amStatus = amStatus;
    }

    public Integer getPmStatus() {
        return pmStatus;
    }

    public void setPmStatus(Integer pmStatus) {
        this.pmStatus = pmStatus;
    }

    public Date getReference() {
        return reference;
    }

    public void setReference(Date reference) {
        this.reference = reference;
    }

	@Override
	public String toString() {
		return "Attendance [id=" + id + ", userId=" + userId + ", workTime=" + workTime + ", endTime=" + endTime
				+ ", amStatus=" + amStatus + ", pmStatus=" + pmStatus + ", reference=" + reference + "]";
	}
    
}