package lee.attendance.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lee.attendance.commons.LoginRequired;
import lee.attendance.commons.ResultMsg;
import lee.attendance.domain.DeptFile;
import lee.attendance.domain.Menu;
import lee.attendance.domain.UserInfo;
import lee.attendance.domain.transfer.UserFile;
import lee.attendance.service.FileService;
import lee.attendance.service.HomeService;
import lee.attendance.utils.FileUtil;

@Controller
@RequestMapping("file")
@LoginRequired
public class FileController {
	@Value("${fileUrl}")
	private String url;
	@Autowired
	private HomeService homeService;
	@Autowired
	private FileService fileService;
	@RequestMapping("/upload")
	@ResponseBody
	public ResultMsg upload(HttpServletRequest req) {
		int userId = (int)req.getSession().getAttribute("userId");
		int deptId = fileService.findDeptIdByUserId(userId);
		System.out.println(deptId);
		String parentUrl = "H:"+File.separator;
		File file = new File(parentUrl + deptId);
		if(!file.isDirectory()||!file.exists()){
			file.mkdirs();
		}
		System.out.println(file.getPath());
		//文件路径
        List<String> list = FileUtil.upLoad(req, file.getPath()+File.separator);
        System.out.println(list.get(0));
        DeptFile deptFile = new DeptFile();
        deptFile.setDeptId(deptId);
        deptFile.setFileUrl(list.get(0));
        deptFile.setUserId(userId);
        deptFile.setFileTime(new Date());
        return fileService.addFile(deptFile);
	}
	@RequestMapping("uploadPage")
	public String uploadPage(HttpServletRequest req, Model model) {
		int userId = (int)req.getSession().getAttribute("userId");
		//用户基本信息
		UserInfo userInfo = homeService.selectUserById(userId);
		//用户左侧菜单栏
		List<Menu> menuList = homeService.selectMenuByUserId(userId);
		model.addAttribute("userInfo", userInfo);
		model.addAttribute("menuList", menuList);
		System.out.println(url);
		return "upload/upload";
	}
	/**
	 * 文件列表
	 * @param req
	 * @param model
	 * @return
	 */
	@RequestMapping("listFile")
	public String listFile(HttpServletRequest req, Model model) {
		int userId = (int)req.getSession().getAttribute("userId");
		//用户基本信息
		UserInfo userInfo = homeService.selectUserById(userId);
		//用户左侧菜单栏
		List<Menu> menuList = homeService.selectMenuByUserId(userId);
		model.addAttribute("userInfo", userInfo);
		model.addAttribute("menuList", menuList);
		
		List<UserFile> list = fileService.listFile(fileService.findDeptIdByUserId(userId));
		for(UserFile uf : list) {
			String url = uf.getFileUrl();
			uf.setFileName(url.substring(url.lastIndexOf("\\")+1, url.lastIndexOf("-"))+url.substring(url.lastIndexOf(".")));
			uf.setDownloadName(url.substring(url.lastIndexOf("\\")+1));
		}
		model.addAttribute("fileList", list);
		return "upload/download";
	}
	@RequestMapping("download")
	public void download(HttpServletRequest request, HttpServletResponse response) throws IOException {
	    // 得到要下载的文件名  
//	    String fileName = "H:\\2\\demo-2c459b71bc33488087d4a7502fc6c2cf.html";  
	    String fileName =request.getParameter("filename");
	    fileName = "H:\\"+fileService.findDeptIdByUserId((int)request.getSession().getAttribute("userId"))+"\\"+fileName;
	    System.out.println(fileName);
	    try {  
//	        fileName = new String(fileName.getBytes("iso8859-1"), "UTF-8");  
	        // 得到要下载的文件  
	        File file = new File(fileName);  
	        // 如果文件不存在  
	        if (!file.exists()) {  
	            request.setAttribute("message", "您要下载的资源已被删除！！");  
	            System.out.println("您要下载的资源已被删除！！");  
	            return;  
	        }  
	        // 处理文件名  
	        String realname = fileName.substring(fileName.lastIndexOf("\\")+1, fileName.lastIndexOf("-"))+fileName.substring(fileName.lastIndexOf("."));
	        // 设置响应头，控制浏览器下载该文件  
	        realname = URLEncoder.encode(realname,"UTF-8");  
            
            response.addHeader("Content-Disposition", "attachment;filename=" + realname);    
            response.setContentType("multipart/form-data");
	        // 读取要下载的文件，保存到文件输入流  
	        FileInputStream in = new FileInputStream(fileName);  
	        // 创建输出流  
	        OutputStream out = response.getOutputStream();  
	        // 创建缓冲区  
	        byte buffer[] = new byte[1024];  
	        int len = 0;  
	        // 循环将输入流中的内容读取到缓冲区当中  
	        while ((len = in.read(buffer)) > 0) {  
	            // 输出缓冲区的内容到浏览器，实现文件下载  
	            out.write(buffer, 0, len);  
	        }  
	        // 关闭文件输入流  
	        in.close();  
	        // 关闭输出流  
	        out.close();  
	    } catch (Exception e) {  
	  
	    }  
	}
	
	
	
	
	
	
	
	
	
	
}
