package edu.ahpu.service;

import java.util.List;
import java.util.Set;

import edu.ahpu.pojo.Comment;
import edu.ahpu.pojo.Goods;
import edu.ahpu.util.PageHeader;

public interface GoodsService {

    // admin功能 分界线****************************************

    /**
     * 查询所有物品的浏览量总和
     * @return
     */
    Integer getAllGoodsPageviews();

    /**
     * 查询所有发布的物品数目
     * @return
     */
    Integer getAllGoodsCount();

    PageHeader<Goods> getPageGoods(PageHeader pageHeader, Goods goods);

    /**
     * 条件更新物品信息
     */
    void updateGoodsSelective(Goods goods);

    /**
     * 根据id查询goods(每次查询不计入浏览量 getGoodsByPrimaryKey()会计入浏览量)
     */
    Goods getGoodsById(Integer goodsId);

    /**
     * 全字段更新goods
     */
    void updateGoods(Goods goods);

    /**
     * 删除物品信息(真正删除)
     */
    void deleteGoods(Goods goods);


    // admin功能 分界线****************************************







    void polishGoods(Integer goodsId);


    /**
     * 添加物品信息
     */
    int addGood(Goods goods);

    /**
     * 通过主键获取商品
     */
    Goods getGoodsByPrimaryKey(Integer goodsId);



    /**
     * 更新商品信息
     */
    void updateGoodsByPrimaryKeyWithBLOBs(int goodsId, Goods goods);

    /**
     * 通过主键删除商品(实际上是下架物品)
     */
    void deleteGoodsByPrimaryKey(Integer id);//更新

    void deleteGoodsByPrimaryKeys(Integer id);//删除

    /**
     * 获取所有商品信息
     */
    List<Goods> getAllGoods();

    List<Goods> searchGoods(String name, String describle);

    /**
     * 通过最新发布分类获取商品信息
     */
    List<Goods> getGoodsByStr(String name, String describle);

    /**
     * 通过商品分类获取商品信息
     */
    List<Goods> getGoodsByCategory(Integer id, String name, String describle);

    /**
     * 根据物品浏览量查询浏览量最高的goodsSize个物品信息
     */
    List<Goods> getGoodsOrderByPageviews(int limit);

    /**
     * 获取 最新发布 物品，根据时间排序,获取前limit个结果
     */
    List<Goods> getGoodsOrderByDate(Integer limit);

    /**
     * 根据分类id,并进行时间排序,获取前limit个结果
     */
    List<Goods> getGoodsByCategoryOrderByDate(Integer categoryId, Integer limit);

    /**
     * 根据用户的id，查询出该用户的所有闲置
     */
    public List<Goods> getGoodsByUserId(Integer user_id);

    /**
     * 提交订单时，根据goodsId修改商品状态
     */
    public void updateGoodsByGoodsId(Goods goods);

    /**
     * 获取商品数
     */
    int getGoodsNum();



    /**
     * 模糊查询
     */
    List<Goods> getPageGoodsByGoods(Integer id, String name, Integer categoryId, Integer status, int pageNum, int pageSize);


    List<Comment> selectCommentsByGoodsId(Integer id);

    /**
     * 新增评论
     */
    void addComments(Comment comment);

    Integer getPageGoodsNumByGoods(Integer id, String name, Integer categoryId, Integer status);

    void updateGoodsPageviews(Integer id);



    /**
     * 根据用户id查询其所有的下架物品
     */
    List<Goods> getOffGoodsByUserId(Integer userId);

    /**
     *  根据物品名称(str)、详细信息(str)，分页查询所有物品，按照擦亮时间排序
     */
    PageHeader<Goods> getGoodsByStrPage(PageHeader<Goods> pageHeader, String str);

    /**
     *  根据种类id、物品名称(str)、详细信息(str)，分页查询所有物品，按照擦亮时间排序
     */
    PageHeader<Goods> getGoodsByCategoryPage(PageHeader<Goods> pageHeader, String str, Integer id);


    /**
     * 查询用户所有发布的闲置物品总量
     * @param userId
     * @return
     */
    Integer findAllGoodsPageViewsByUserId(Integer userId);

    /**
     * 从每个categoryId对应的种类中，按照物品浏览量从高到底排序 查询出一个物品
     * @param recommendCategoryList
     * @return
     */
    List<Goods> findGoodsByCategoryIdList(Set<Integer> recommendCategoryList);
}