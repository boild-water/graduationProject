package edu.ahpu.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import com.github.pagehelper.PageInfo;
import edu.ahpu.pojo.Comment;
import edu.ahpu.util.PageHeader;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import edu.ahpu.dao.GoodsMapper;
import edu.ahpu.pojo.Goods;
import edu.ahpu.service.GoodsService;
import edu.ahpu.util.DateUtil;

/**
 * 物品service实现层
 */
@Service
public class GoodsServiceImpl implements GoodsService {

    @Autowired
    private GoodsMapper goodsMapper;


    // admin功能 分界线****************************************

    /**
     * 查询所有发布的物品数目
     */
    @Override
    public Integer getAllGoodsCount() {
        return goodsMapper.getAllGoodsCount();
    }

    /**
     * 查询所有物品的浏览量总和
     * @return
     */
    @Override
    public Integer getAllGoodsPageviews() {

        return goodsMapper.getAllGoodsPageviews();
    }

    /**
     * 分页条件查询goods
     */
    @Override
    public PageHeader<Goods> getPageGoods(PageHeader pageHeader, Goods goods) {
        PageHelper.startPage(pageHeader.getPage(), pageHeader.getRows());
        List<Goods> goodsList = goodsMapper.getGoodsList(goods);
        PageInfo<Goods> pageInfo = new PageInfo<>(goodsList);

        //封装pageHeader
        pageHeader.setCount((int) pageInfo.getTotal());
        pageHeader.setResults(goodsList);
        pageHeader.setTotalPages(pageInfo.getPages());

        return pageHeader;
    }

    /**
     * 根据条件选择性的更新goods信息
     */
    @Override
    public void updateGoodsSelective(Goods goods) {
        goodsMapper.updateByPrimaryKeySelective(goods);
    }

    /**
     * 根据id查询goods(每次查询不计入浏览量 getGoodsByPrimaryKey()会计入物品浏览量)
     */
    @Override
    public Goods getGoodsById(Integer goodsId) {
        Goods goods = goodsMapper.getGoodsById(goodsId);
        return goods;
    }

    /**
     * 全字段更新goods信息
     */
    @Override
    public void updateGoods(Goods goods) {
        goodsMapper.updateByPrimaryKey(goods);
    }


    /**
     * 删除物品信息(真正删除)
     */
    @Override
    public void deleteGoods(Goods goods) {
        goodsMapper.deleteGoodsById(goods);
    }


    // admin功能 分界线****************************************

    /**
     * 根据物品浏览量查询浏览量最高的goodsSize个物品信息
     */
    @Override
    public List<Goods> getGoodsOrderByPageviews(int limit) {
        return goodsMapper.selectOrderByPageviews(limit);
    }


    /**
     * 查询最近发布的limit个物品
     */
    @Override
    public List<Goods> getGoodsOrderByDate(Integer limit) {
        List<Goods> goodsList = goodsMapper.selectOrderByDate(limit);
        return goodsList;
    }

    /**
     * 从每一类物品中，按照时间排序查询最新发布的limit个物品信息
     */
    @Override
    public List<Goods> getGoodsByCategoryOrderByDate(Integer categoryId, Integer limit) {
        List<Goods> goodsList = goodsMapper.selectByCategoryOrderByDate(categoryId, limit);
        return goodsList;
    }

    /**
     * 根据goodsId，擦亮该物品
     */
    @Override
    public void polishGoods(Integer goodsId) {
        Goods goods = new Goods();
        goods.setId(goodsId);
        goods.setPolishTime(DateUtil.getNowTime());
        goodsMapper.updateByPrimaryKeySelective(goods);
    }

    /**
     * 添加物品信息
     */
    @Override
    public int addGood(Goods goods) {

        String nowTime = DateUtil.getNowTime();
        //设置物品添加、擦亮时间
        goods.setStartTime(nowTime);//添加物品时，添加时间就是擦亮时间
        goods.setPolishTime(nowTime);

        return goodsMapper.insert(goods);
    }


    /**
     * 根据主键id查询物品
     */
    @Override
    public Goods getGoodsByPrimaryKey(Integer goodsId) {
        Goods goods = goodsMapper.selectByPrimaryKey(goodsId);
        return goods;
    }



    /**
     * 根据id删除物品
     */
    @Override
    public void deleteGoodsByPrimaryKey(Integer id) {
        goodsMapper.deleteByPrimaryKey(id);
    }

    @Override
    public void deleteGoodsByPrimaryKeys(Integer id) {
        goodsMapper.deleteByPrimaryKeys(id);
    }

    @Override
    public List<Goods> getAllGoods() {
        List<Goods> goods = goodsMapper.selectAllGoods();
        return goods;
    }

    @Override
    public List<Goods> searchGoods(String name, String describle) {
        List<Goods> goods = goodsMapper.searchGoods(name, describle);
        return goods;
    }

    /**
     * 根据物品名和物品描述信息 查询最新发布的limit个物品
     */
    @Override
    public List<Goods> getGoodsByStr(String name, String describle) {
        List<Goods> goods = goodsMapper.selectByStr(name, describle);
        return goods;
    }

    /**
     * 根据种类id、物品名称、物品描述信息 查询所有物品
     */
    @Override
    public List<Goods> getGoodsByCategory(Integer id, String name, String describle) {
        List<Goods> goods = goodsMapper.selectByCategory(id, name, describle);
        return goods;
    }


    @Override
    public void updateGoodsByGoodsId(Goods goods) {

        goodsMapper.updateGoodsByGoodsId(goods);

    }



    /**
     * 根据用户id查询其所有的下架物品
     */
    @Override
    public List<Goods> getOffGoodsByUserId(Integer userId) {
        return goodsMapper.getOffGoodsByUserId(userId);
    }


    /**
     * 更新物品信息
     */
    @Override
    public void updateGoodsByPrimaryKeyWithBLOBs(int goodsId, Goods goods) {
        goods.setId(goodsId);
        this.goodsMapper.updateByPrimaryKeyWithBLOBs(goods);
    }

    @Override
    public List<Goods> getGoodsByUserId(Integer user_id) {
        List<Goods> goodsList = goodsMapper.getGoodsByUserId(user_id);
        return goodsList;
    }

    /**
     * 查询所有物品数量
     */
    @Override
    public int getGoodsNum() {
        //获取出所有物品的数量
//        List<Goods> goods = goodsMapper.getGoodsList();
        return 0;
    }



    /**
     * 根据id、name、categoryId、status 四个不确定条件查询物品
     */
    @Override
    public List<Goods> getPageGoodsByGoods(Integer id, String name, Integer categoryId, Integer status, int pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Goods> list = goodsMapper.getPageGoodsByGoods(id, name, categoryId, status);
        return list;
    }

    /**
     * 根据id、name、categoryId、status 四个不确定条件查询物品的总数目
     */
    @Override
    public Integer getPageGoodsNumByGoods(Integer id, String name, Integer categoryId, Integer status) {

        List<Goods> list = goodsMapper.getPageGoodsByGoods(id, name, categoryId, status);
        return list.size();
    }

    /**
     * 根据物品id查询该物品下的所有评论
     */
    @Override
    public List<Comment> selectCommentsByGoodsId(Integer id) {
        return goodsMapper.selectCommentsByGoodsId(id);
    }

    /**
     * 给物品添加评论信息
     */
    @Override
    public void addComments(Comment comment) {
        goodsMapper.addComments(comment);
    }

    /**
     * 更新物品的浏览量
     */
    @Override
    public void updateGoodsPageviews(Integer id) {
        goodsMapper.updateGoodsPageviews(id);
    }

    /**
     *  根据物品名称(str)、详细信息(str)，分页查询所有物品，按照擦亮时间排序
     */
    @Override
    public PageHeader<Goods> getGoodsByStrPage(PageHeader<Goods> pageHeader, String str) {

        //使用pageHelper插件分页查询数据
        PageHelper.startPage(pageHeader.getPage(),pageHeader.getRows());
        List<Goods> goodsList = goodsMapper.selectByStr(str,str);
        //使用pageHelper组件pageInfo近一步包装
        PageInfo<Goods> pageInfo = new PageInfo<>(goodsList);

        //先为pageHeader赋值
        pageHeader.setResults(goodsList);//封装分页数据
        pageHeader.setCount((int) pageInfo.getTotal());//封装总数目
        pageHeader.setTotalPages(pageInfo.getPages());//封装总页数
        //pageHeader中的另外两个字段page、rows都从前端自动封装了过来，此处不再进行封装。

        return pageHeader;

    }

    /**
     *  根据种类id、物品名称(str)、详细信息(str)，分页查询所有物品，按照擦亮时间排序
     */
    @Override
    public PageHeader<Goods> getGoodsByCategoryPage(PageHeader<Goods> pageHeader, String str, Integer id) {
        //使用pageHelper插件分页查询数据
        PageHelper.startPage(pageHeader.getPage(),pageHeader.getRows());
        List<Goods> goodsList = goodsMapper.selectByCategory(id, str, str);
        //使用pageHelper组件pageInfo近一步包装
        PageInfo<Goods> pageInfo = new PageInfo<>(goodsList);

        //先为pageHeader赋值
        pageHeader.setResults(goodsList);//封装分页数据
        pageHeader.setCount((int) pageInfo.getTotal());//封装总数目
        pageHeader.setTotalPages(pageInfo.getPages());//封装总页数
        //pageHeader中的另外两个字段page、rows都从前端自动封装了过来，此处不再进行封装。

        return pageHeader;
    }

    /**
     * 查询用户所有发布物品浏览总量
     */
    @Override
    public Integer findAllGoodsPageViewsByUserId(Integer userId) {

        return goodsMapper.findAllGoodsPageViewsByUserId(userId);
    }

    /**
     * 从每个categoryId对应的种类中，按照物品擦亮时间从高到低排序 查询出一个物品
     * @param recommendCategorySet
     */
    @Override
    public List<Goods> findGoodsByCategoryIdList(Set<Integer> recommendCategorySet) {

        List<Goods> goodsList = new ArrayList<>();

        for (Integer categoryId:recommendCategorySet){

            Goods goods = goodsMapper.findOneGoodsByCategoryId(categoryId);

            if (goods != null){
                goodsList.add(goods);
            }
        }

        return goodsList;
    }

}

