package edu.ahpu.pojo;

import java.util.ArrayList;
import java.util.List;

/**
 * 物品拓展 联合查询
 */
public class GoodsExtend {

    private Goods goods;//物品

    private List<Image> images = new ArrayList<>();//物品图片

    private List<Comment> comments = new ArrayList<>();//物品评论


    public List<Image> getImages() {
        return images;
    }

    public Goods getGoods() {
        return goods;
    }

    public void setGoods(Goods goods) {
        this.goods = goods;
    }

    public void setImages(List<Image> images) {
        this.images = images;
    }

    public List<Comment> getComments() {
        return comments;
    }

    public void setComments(List<Comment> comments) {
        this.comments = comments;
    }

    @Override
    public String toString() {
        return "GoodsExtend [goods=" + goods + ", images=" + images + ", comments=" + comments + "]";
    }

}