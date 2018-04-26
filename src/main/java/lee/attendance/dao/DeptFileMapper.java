package lee.attendance.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import lee.attendance.domain.DeptFile;
import lee.attendance.domain.transfer.UserFile;

public interface DeptFileMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(DeptFile record);

    int insertSelective(DeptFile record);

    DeptFile selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(DeptFile record);

    int updateByPrimaryKey(DeptFile record);
    /**
     * 查询出所有的文件
     * @return
     */
    List<UserFile> findAllFile(@Param("deptId")int deptId);
}