package lee.attendance.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lee.attendance.commons.ResultMsg;
import lee.attendance.dao.DeptFileMapper;
import lee.attendance.dao.UserDeptMapper;
import lee.attendance.domain.DeptFile;
import lee.attendance.domain.transfer.UserFile;
import lee.attendance.service.FileService;
@Service
public class FileServiceImpl implements FileService{
	@Autowired
	private UserDeptMapper userDeptMapper;
	@Autowired
	private DeptFileMapper deptFileMapper;
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
	public List<UserFile> listFile() {
		return deptFileMapper.findAllFile();
	}

}
