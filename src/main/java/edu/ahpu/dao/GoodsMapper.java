package edu.ahpu.dao;

import java.util.List;

import edu.ahpu.pojo.Comment;
import org.apache.ibatis.annotations.Param;

import edu.ahpu.pojo.Goods;

public interface GoodsMapper {

    // admin功能 分界线****************************************

    /**
     * 查询所有的物品数目
     * @return
     */
    Integer getAllGoodsCount();

    /**
     * 查询所有物品的浏览量总和
     * @return
     */
    Integer getAllGoodsPageviews();

    /**
     * 条件查询所有物品
     */
    List<Goods> getGoodsList(Goods goods);

    /**
     * 条件更新物品信息
     */
    int updateByPrimaryKeySelective(Goods goods);

    /**
     * 根据id查询goods
     */
    Goods getGoodsById(Integer goodsId);

    /**
     * 全字段更新物品信息
     */
    int updateByPrimaryKey(Goods goods);

    /**
     * 删除物品信息(真正的删除)
     */
    void deleteGoodsById(Goods goods);









    // admin功能 分界线****************************************









    /**
     * 查询浏览量最高的物品信息
     */
    List<Goods> selectOrderByPageviews(int limit);

    /**
     * 查询最新发布物品信息，按擦亮时间排序，最新的在前
     */
    List<Goods> selectOrderByDate(@Param("limit") Integer limit);



    /**
     * 通过主键删除
     */
    int deleteByPrimaryKey(Integer id);//更新

    int deleteByPrimaryKeys(Integer id);//删除

    /**
     * 添加物品
     */
    int insert(Goods record);

    /**
     *
     */
    int insertSelective(Goods record);

    /**
     * 通过id查询
     */
    Goods selectByPrimaryKey(Integer id);






    /**
     * 通过主键更改信息，包括大文本信息
     */
    int updateByPrimaryKeyWithBLOBs(Goods record);



    /**
     * 查询所有的物品
     */
    List<Goods> selectAllGoods();

    List<Goods> searchGoods(@Param("name") String name, @Param("description") String description);

    /**
     * 根据物品名和物品描述信息 查询最新发布的limit个物品
     */
    List<Goods> selectByStr(@Param("name") String name, @Param("description") String description);

    /**
     * 根据种类id、物品名称、物品描述信息 查询所有物品
     */
    List<Goods> selectByCategory(@Param("category_id") Integer category_id, @Param("name") String name, @Param("description") String description);

    /**
     * 根据时间先后获取物品信息，进行分页查询
     * 未在xml中实现
     */
    List<Goods> selectByDate(int page, int maxResults);

    /**
     * 根据category_id查询物品信息，结果按擦亮时间排序，最新的在前
     */
    List<Goods> selectByCategoryOrderByDate(@Param("categoryId") Integer categoryId, @Param("limit") Integer limit);


    /**
     * 根据userId查询其所有的上架物品
     */
    List<Goods> getGoodsByUserId(Integer userId);

    /**
     * 根据userId查询其所有的下架物品
     */
    List<Goods> getOffGoodsByUserId(Integer userId);

    /**
     * 提交的订单时，修改物品状态
     */
    int updateGoodsByGoodsId(Goods goods);

    /**
     * 根据id/name/categoryId/status 模糊查询
     */
    List<Goods> getPageGoodsByGoods(@Param("id") Integer id, @Param("name") String name, @Param("categoryId") Integer categoryId, @Param("status") Integer status);

    /**
     * 根据物品id,查询该物品下的所有评论信息
     */
    List<Comment> selectCommentsByGoodsId(@Param("id") Integer id);

    void addComments(Comment comment);

    /**
     * 更新物品的页面浏览量
     */
    void updateGoodsPageviews(Integer id);


    /**
     * 查询用户所有发布的物品的浏览总量
     * @param userId
     * @return
     */
    Integer findAllGoodsPageViewsByUserId(Integer userId);

    /**
     * 根据categoryId从物品表中按照物品擦亮时间从高到低查询出一个物品
     * @param categoryId
     * @return
     */
    Goods findOneGoodsByCategoryId(Integer categoryId);
}