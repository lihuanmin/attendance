package lee.attendance.domain.transfer;

import java.util.List;

public class RoleMenuUpdate {
	private int roleId;
	
	private String roleName;
	
	private String roleDetail;
	
	private int[] menu;
	
	public RoleMenuUpdate(int roleId, String roleName, String roleDetail, int[] menu) {
		super();
		this.roleId = roleId;
		this.roleName = roleName;
		this.roleDetail = roleDetail;
		this.menu = menu;
	}

	public int getRoleId() {
		return roleId;
	}
	
	public void setRoleId(int roleId) {
		this.roleId = roleId;
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

	public int[] getMenu() {
		return menu;
	}

	public void setMenu(int[] menu) {
		this.menu = menu;
	}
	
	
}
