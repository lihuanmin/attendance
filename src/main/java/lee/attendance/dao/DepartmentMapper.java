package lee.attendance.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import lee.attendance.domain.Department;

public interface DepartmentMapper {
    int deleteByPrimaryKey(Integer deptId);

    int insert(Department record);

    int insertSelective(Department record);

    Department selectByPrimaryKey(Integer deptId);

    int updateByPrimaryKeySelective(Department record);

    int updateByPrimaryKey(Department record);
    /**
     * 根据名字获取name，判断名字是否存在
     * @param deptName
     * @return
     */
    String getNameByName(@Param("deptName")String deptName);
    /**
     * 根据名字获取name,并且不再原id中查找
     * @param deptName
     * @return
     */
    String getNameByNameNoId(@Param("deptName")String deptName, @Param("deptId")int deptId);
    /**
     * 根据code获取name，判断code是否存在
     * @param deptCode
     * @return
     */
    String getNameByCode(@Param("deptCode")String deptCode);
    /**
     * 根据code获取名字，并且不再原id中找
     * @param deptCode
     * @param deptId
     * @return
     */
    String getNameByCodeNoId(@Param("deptCode")String deptCode, @Param("deptId")int deptId);
    /**
     * 查询所有的部门
     * @return
     */
    List<Department> selectAllDept();
    /**
     * 根据id查询部门
     * @param deptId
     * @return
     */
    Department selectDeptById(@Param("deptId")int deptId);
    /**
     * 查询所有的部门name,id
     * @return
     */
    List<Department> queryDept();
}