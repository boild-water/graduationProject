package edu.ahpu.service;

import java.util.List;

import edu.ahpu.pojo.Image;

public interface ImageService {

    int insert(Image record);
    /**
     * 通过物品id获取该物品的图片
     */
    List<Image> getImagesByGoodsPrimaryKey(Integer goodsId);

    /**
     * 通过物品Id删除物品
     */
    int deleteImagesByGoodsPrimaryKey(Integer goodsId);

    /**
     * 通过物品id更新物品对应的图片
     */
    void updateByGoodsId(Image image);

    /**
     * 根据imgUrl查询image
     * @param imgUrl
     * @return
     */
    Image getImageByImgUrl(String imgUrl);
}