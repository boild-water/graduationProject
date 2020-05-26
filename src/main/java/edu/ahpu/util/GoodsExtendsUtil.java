package edu.ahpu.util;

import edu.ahpu.pojo.Comment;
import edu.ahpu.pojo.Goods;
import edu.ahpu.pojo.GoodsExtend;
import edu.ahpu.pojo.Image;
import edu.ahpu.service.GoodsService;
import edu.ahpu.service.ImageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

/**
 * 将GoodsController中的一些繁琐内容，抽离出来形成一个工具类
 * 为物品封装图片、评论信息。
 * @author jinfei
 * @create 2020-03-31 16:51
 */
@Component
public class GoodsExtendsUtil {

    @Autowired
    private ImageService imageService;

    @Autowired
    private GoodsService goodsService;

    /**
     * 为单个物品封装图片信息
     */
    public GoodsExtend getGoodsExtendWithImg(Goods goods){
        GoodsExtend goodsExtend = new GoodsExtend();
        List<Image> images = imageService.getImagesByGoodsPrimaryKey(goods.getId());
        goodsExtend.setGoods(goods);
        goodsExtend.setImages(images);
        return goodsExtend;
    }

    /**
     * 为物品列表封装图片、评论信息
     */
    public List<GoodsExtend> getGoodsExtendsWithImgAndComment(List<Goods> goodsList){
        List<GoodsExtend> goodsExtends = new ArrayList<>();
        for (int i = 0; i < goodsList.size(); i++) {
            // 将用户信息和image信息、comment信息封装到GoodsExtend类中
            GoodsExtend goodsExtend = new GoodsExtend();
            Goods goods = goodsList.get(i);
            List<Image> images = imageService.getImagesByGoodsPrimaryKey(goods.getId());
            List<Comment> comments = goodsService.selectCommentsByGoodsId(goods.getId());
            goodsExtend.setGoods(goods);
            goodsExtend.setImages(images);
            goodsExtend.setComments(comments);

            goodsExtends.add(i, goodsExtend);
        }
        return goodsExtends;
    }

    /**
     * 为物品列表封装图片信息
     */
    public List<GoodsExtend> getGoodsExtendsWithImg(List<Goods> goodsList){
        List<GoodsExtend> goodsExtends = new ArrayList<>();
        for (int i = 0; i < goodsList.size(); i++) {
            // 将用户信息和image信息、comment信息封装到GoodsExtend类中
            GoodsExtend goodsExtend = new GoodsExtend();
            Goods goods = goodsList.get(i);
            List<Image> images = imageService.getImagesByGoodsPrimaryKey(goods.getId());
            goodsExtend.setGoods(goods);
            goodsExtend.setImages(images);
            goodsExtends.add(i, goodsExtend);
        }
        return goodsExtends;
    }
}
