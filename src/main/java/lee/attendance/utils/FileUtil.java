package lee.attendance.utils;


import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

public class FileUtil
{
    
    public static List<String> upLoad(HttpServletRequest request,String path)
    {
        
        List<String> list = new ArrayList<String> ();    //存放结果
        //1、将当前上下文初始化给CommonMutipartResolver
        CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver(request.getSession().getServletContext());
        //2、检查Form中encType是否为multipart/form-data
        if(multipartResolver.isMultipart(request))
        {
            //将request转为MultipartHttpServletRequest
            MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
            //获取迭代器遍历multipartRequest里的文件名
            Iterator<String> iter = multipartRequest.getFileNames();
            while(iter.hasNext())
            {
                //获取文件并向下遍历
                MultipartFile file = multipartRequest.getFile(iter.next().toString());
                if(file != null)
                {
                    //获取文件类型，即后缀名
                    String str = file.getOriginalFilename();
                    String suffix = str.substring(str.lastIndexOf("."));
                    String origin = file.getOriginalFilename().substring(0, file.getOriginalFilename().lastIndexOf("."));
                    //用 当前日期+UUID作为文件名避免重名
                    SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
                    String dateStr = sdf.format(new Date()).replaceAll("-", "");
                    String name = origin+"-" + UUID.randomUUID().toString().replaceAll("-", "");
                    
                    //拼接文件绝对路径
                    String filePath = path + name + suffix;
                    try
                    {
                        file.transferTo(new File(filePath));
                    } catch (IllegalStateException | IOException e)
                    {
                        // TODO Auto-generated catch block
                        e.printStackTrace();
                    }
                    list.add(filePath);
                }
            }
        }
        return list;
        
    }

}