package edu.ahpu.dao;

import java.util.List;

import edu.ahpu.pojo.Image;

public interface ImageMapper {
    int deleteByPrimaryKey(Integer id);

    int deleteImagesByGoodsPrimaryKey(Integer goodsId);

    int insert(Image record);

    int insertSelective(Image record);

    Image selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Image record);

    int updateByPrimaryKeyWithBLOBs(Image record);

    int updateByPrimaryKey(Image record);

    List<Image> selectByGoodsPrimaryKey(Integer goodsId);

    /**
     * 根据goodsId更新物品对应的图片信息
     */
    void updateByGoodsId(Image image);

    /**
     * 根据imgUrl获取image
     * @param imgUrl
     * @return
     */
    Image getImageByImgUrl(String imgUrl);
}