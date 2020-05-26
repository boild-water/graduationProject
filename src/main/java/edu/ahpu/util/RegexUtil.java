package edu.ahpu.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * @author jinfei
 * @create 2020-04-24 11:07
 */
public class RegexUtil {


    //正则表达式的字符串
    private String regexStr = "";

    public RegexUtil(String regexStr) {
        this.regexStr = regexStr;
    }

    //正则校验，如果创建对象但是不传入正则表达式而调用该方法就会报错
    public  boolean customMatcher(String testStr){//传入待检测的字符串
        Pattern pattern= Pattern.compile(regexStr);
        Matcher matcher = pattern.matcher(testStr);
        return matcher.matches();
    }
    //正则表达式通用匹配
    public static boolean genericMatcher(String regexExpre,String testStr){
        Pattern pattern=Pattern.compile(regexExpre);
        Matcher matcher = pattern.matcher(testStr);
        return matcher.matches();
    }

    public String getRegexStr() {
        return regexStr;
    }

    public void setRegexStr(String regexStr) {
        this.regexStr = regexStr;
    }

    public static void main(String[] args) {
        //有空格
        System.out.println(RegexUtil.genericMatcher("^((\\s.*)|(.*\\s))$","你好"));
    }

}
