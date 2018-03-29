package lee.attendance.commons;

public class ResultMsg {
    private boolean success;
    
    private String msg;
    
    private Object object;
    
    public ResultMsg() {
        super();
    }

    public ResultMsg(boolean success, String msg){
        this.success = success;
        this.msg = msg;
    }
    
    public ResultMsg(boolean success, String msg, Object object) {
        super();
        this.success = success;
        this.msg = msg;
        this.object = object;
    }

    public boolean isSuccess() {
        return success;
    }

    public void setSuccess(boolean success) {
        this.success = success;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public Object getObject() {
        return object;
    }

    public void setObject(Object object) {
        this.object = object;
    }
}
