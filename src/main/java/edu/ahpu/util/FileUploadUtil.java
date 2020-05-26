package edu.ahpu.util;

import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

/**
 * 文件上传工具类
 * @author jinfei
 * @create 2020-04-16 14:10
 */
public class FileUploadUtil {

    private MultipartFile file; //要上传的文件
    private String filePath;    //文件要上传的路径

    /**
     * 文件上传的方法，返回一个map类型，方便json传输
     */
    public Map<String,Object> upload() throws IOException {

        //得到该文件的md5加密字符串
        String fileMD5 = MD5.getFileMD5(file.getInputStream());

        Map<String, Object> map = new HashMap<>();

        String oldFileName = this.file.getOriginalFilename();
        // 上传图片
        if (oldFileName != null && oldFileName.length() > 0) {
            // 新的文件名称
            String newFileName = fileMD5 + oldFileName.substring(oldFileName.lastIndexOf("."));
            // 新文件
            File newFile = new File(this.filePath + "/" + newFileName);
            // 将新文件写入磁盘的指定位置
            this.file.transferTo(newFile);
            // 封装上传状态
            map.put("status", 0);//0表示上传成功，1表示上传失败
            map.put("fileUrl", newFileName);
        } else {
            map.put("status", 1);
        }
        // 将新图片名称返回到前端
        return map;
    }

    public FileUploadUtil() {
    }

    public FileUploadUtil(String filePath, MultipartFile file) {
        this.filePath = filePath;
        this.file = file;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public MultipartFile getFile() {
        return file;
    }

    public void setFile(MultipartFile file) {
        this.file = file;
    }
}
