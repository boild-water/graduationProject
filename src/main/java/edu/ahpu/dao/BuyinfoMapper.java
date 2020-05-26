package edu.ahpu.dao;

import java.util.List;

import edu.ahpu.pojo.Buyinfo;

public interface BuyinfoMapper {

    /************* admin 功能分界线 ************************/

    /**
     * 条件查询所有Buyinfo
     * @param buyinfo
     * @return
     */
    List<Buyinfo> getBuyinfoList(Buyinfo buyinfo);

    /**
     * 条件更新字段
     * @param buyinfo
     * @return
     */
    int updateByPrimaryKeySelective(Buyinfo buyinfo);

    /**
     * 根据id查询buyinfo
     * @param buyinfo
     * @return
     */
    Buyinfo getBuyinfoById(Buyinfo buyinfo);

    /**
     * 全字段更新评论信息
     * @param buyinfo
     * @return
     */
    int updateByPrimaryKey(Buyinfo buyinfo);

    /**
     * 根据id删除buyinfo
     * @param buyinfo
     */
    void deleteById(Buyinfo buyinfo);




    /************* admin 功能分界线 ************************/

    /**
     * 查询所有的求购信息
     */
    List<Buyinfo> findAllBuyinfo();

    /**
     * 添加求购信息
     */
    void addBuyinfo(Buyinfo buyinfo);

    /**
     * 从求购信息表中查询最近的limit条求购信息
     */
    List<Buyinfo> getBuyInfosLimit(Integer limit);


}