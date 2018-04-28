package lee.attendance.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lee.attendance.commons.ResultMsg;
import lee.attendance.commons.page.PageResponse;
import lee.attendance.dao.DepartmentMapper;
import lee.attendance.dao.DeptFileMapper;
import lee.attendance.dao.UserDeptMapper;
import lee.attendance.dao.UserVerificationMapper;
import lee.attendance.domain.DeptFile;
import lee.attendance.domain.transfer.AllUser;
import lee.attendance.domain.transfer.DeptInfo;
import lee.attendance.domain.transfer.UserFile;
import lee.attendance.service.FileService;
@Service
public class FileServiceImpl implements FileService{
	@Autowired
	private UserDeptMapper userDeptMapper;
	@Autowired
	private DeptFileMapper deptFileMapper;
	@Autowired
	private UserVerificationMapper userVerificationMapper;
	@Override
	public int findDeptIdByUserId(int userId) {
		return userDeptMapper.findDeptIdByUserId(userId);
	}

	@Override
	public ResultMsg addFile(DeptFile deptFile) {
		int result = deptFileMapper.insertSelective(deptFile);
		if(result <= 0)
			return new ResultMsg(Boolean.FALSE, "上传失败");
		return new ResultMsg(Boolean.TRUE, "上传成功");
	}

	@Override
	public List<UserFile> listFile(int deptId) {
		return deptFileMapper.findAllFile(deptId);
	}

	@Override
	public DeptInfo deptInfo(int userId) {
		//用户部门
		int deptId = userDeptMapper.findDeptIdByUserId(userId);
		DeptInfo deptInfo = deptFileMapper.findDeptInfo(deptId);
		return deptInfo;
	}

	@Override
	public PageResponse<AllUser> deptAllMem(int userId, String userName, int pageNumber, int pageSize) {
		//根据用户id，查询用户部门id
		int deptId = userDeptMapper.findDeptIdByUserId(userId);
		int count = userVerificationMapper.queryAccount(userName, deptId);
		List<AllUser> alluser = userVerificationMapper.queryAllUser(deptId, userName, pageSize, pageNumber);
		PageResponse<AllUser> pr = new PageResponse<AllUser>();
		pr.setTotalRecord(count);
		pr.setDataList(alluser);
		return pr;
	}

}
