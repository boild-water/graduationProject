package edu.ahpu.util;

import com.sun.tools.internal.ws.wsdl.document.soap.SOAPUse;

import java.io.*;
import java.math.BigInteger;
import java.security.DigestInputStream;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * MD5加密类
 *
 * @描述：密码加密
 */
public final class MD5 {

    /**
     * 字符串 Md5加密
     * @param s
     * @return
     */
    public final static String md5(String s) {
        char hexDigits[] = {'0', '1', '2', '3', '4',
                '5', '6', '7', '8', '9',
                'A', 'B', 'C', 'D', 'E', 'F'};
        try {
            byte[] btInput = s.getBytes();
            MessageDigest mdInst = MessageDigest.getInstance("MD5");
            mdInst.update(btInput);
            byte[] md = mdInst.digest();
            int j = md.length;
            char str[] = new char[j * 2];
            int k = 0;
            for (int i = 0; i < j; i++) {
                byte byte0 = md[i];
                str[k++] = hexDigits[byte0 >>> 4 & 0xf];
                str[k++] = hexDigits[byte0 & 0xf];
            }
            return new String(str);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }


    /**
     * 文件MD5加密
     *
     * @param file
     * @return
     */
    public static final String getFileMD5(File file) {
        FileInputStream fis;
        try {
            fis = new FileInputStream(file);
            return getFileMD5(fis);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        return "";
    }

    /**
     * 文件MD5加密
     *
     * @param fis
     * @return
     */
    public static final String getFileMD5(InputStream fis) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] buffer = new byte[1024];
            int length = -1;
            while ((length = fis.read(buffer, 0, 1024)) != -1) {
                md.update(buffer, 0, length);
            }
            BigInteger bigInt = new BigInteger(1, md.digest());
            return bigInt.toString(16);
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        } catch (NoSuchAlgorithmException e) {
            e.printStackTrace();
        } catch (IOException e) {
            e.printStackTrace();
        }
        return "";
    }


    public static void main(String[] args) {
        File file1 = new File("E:/a.txt");
        File file2 = new File("E:/b.txt");
        System.out.println(getFileMD5(file1));
        System.out.println(getFileMD5(file2));
    }
}
