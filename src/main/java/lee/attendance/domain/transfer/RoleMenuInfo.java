package lee.attendance.domain.transfer;

import java.util.List;

import lee.attendance.domain.Menu;

public class RoleMenuInfo {
	private Integer id;

    private String roleName;

    private String roleDetail;
    
    private List<Menu> menu;
    
   	public List<Menu> getMenu() {
   		return menu;
   	}

   	public void setMenu(List<Menu> menu) {
   		this.menu = menu;
   	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public String getRoleDetail() {
		return roleDetail;
	}

	public void setRoleDetail(String roleDetail) {
		this.roleDetail = roleDetail;
	}

	@Override
	public String toString() {
		return "RoleMenuInfo [id=" + id + ", roleName=" + roleName + ", roleDetail=" + roleDetail + ", menu=" + menu
				+ "]";
	}

}
