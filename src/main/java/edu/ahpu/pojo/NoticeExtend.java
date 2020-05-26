package edu.ahpu.pojo;

import java.util.List;

/**
 * 商品拓展 联合查询
 */
public class NoticeExtend extends User {

    private List<Buyinfo> buyinfo;

    public List<Buyinfo> getBuyinfo() {
        return buyinfo;
    }

    public void setBuyinfo(List<Buyinfo> buyinfo) {
        this.buyinfo = buyinfo;
    }

    @Override
    public String toString() {
        return "NoticeExtend [buyinfo=" + buyinfo + "]";
    }

}