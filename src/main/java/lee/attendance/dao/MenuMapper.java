package lee.attendance.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import lee.attendance.domain.Menu;

public interface MenuMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Menu record);

    int insertSelective(Menu record);

    Menu selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Menu record);

    int updateByPrimaryKey(Menu record);
    /**
     * 根据用户id查询用户菜单
     * @param userId
     * @return
     */
    List<Menu> selectMenuByUserId(@Param("userId")int userId);
    /**
     * 查询所有的菜单
     * @return
     */
    List<Menu> selectAllMenu();
}