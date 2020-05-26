package edu.ahpu.pojo;

import javax.activation.MailcapCommandMap;

/**
 * 热搜实体类
 * @author jinfei
 * @create 2020-05-12 12:17
 */
public class HotSearch {

    private Integer id;         //id
    private String content;     //搜索内容
    private Integer searchNum;  //搜索次数
    private String searchTime;  //搜索时间
    private Float addMoney;     //加钱数目

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Float getAddMoney() {
        return addMoney;
    }

    public void setAddMoney(Float addMoney) {
        this.addMoney = addMoney;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Integer getSearchNum() {
        return searchNum;
    }

    public void setSearchNum(Integer searchNum) {
        this.searchNum = searchNum;
    }

    public String getSearchTime() {
        return searchTime;
    }

    public void setSearchTime(String searchTime) {
        this.searchTime = searchTime;
    }

    @Override
    public String toString() {
        return "HotSearch{" +
                "id=" + id +
                ", content='" + content + '\'' +
                ", searchNum=" + searchNum +
                ", searchTime='" + searchTime + '\'' +
                '}';
    }
}
