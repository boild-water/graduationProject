package edu.ahpu.service.impl;

import edu.ahpu.dao.ImageMapper;
import edu.ahpu.pojo.Image;
import edu.ahpu.service.ImageService;

import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service("imageService")
public class ImageServiceImpl implements ImageService {

    @Resource
    private ImageMapper imageMapper;

    @Override
    public int insert(Image record) {
        return imageMapper.insert(record);
    }

    @Override
    public List<Image> getImagesByGoodsPrimaryKey(Integer goodsId) {
        List<Image> image = imageMapper.selectByGoodsPrimaryKey(goodsId);
        return image;
    }

    @Override
    public int deleteImagesByGoodsPrimaryKey(Integer goodsId) {
        return imageMapper.deleteImagesByGoodsPrimaryKey(goodsId);
    }

    @Override
    public void updateByGoodsId(Image image) {
        imageMapper.updateByGoodsId(image);
    }

    /**
     * 根据imgUrl查询image
     */
    @Override
    public Image getImageByImgUrl(String imgUrl) {
        return imageMapper.getImageByImgUrl(imgUrl);
    }
}
