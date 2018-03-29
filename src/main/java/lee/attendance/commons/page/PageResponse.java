package lee.attendance.commons.page;

import java.util.List;

public class PageResponse<T> {
    private int totalRecord;
    private List<T> dataList;
    public int getTotalRecord() {
        return totalRecord;
    }
    public void setTotalRecord(int totalRecord) {
        this.totalRecord = totalRecord;
    }
    public List<T> getDataList() {
        return dataList;
    }
    public void setDataList(List<T> dataList) {
        this.dataList = dataList;
    }
    
}
