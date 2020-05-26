package edu.ahpu.dao;

import edu.ahpu.pojo.HotSearch;

import java.util.List;

/**
 * 热搜 mapper
 * @author jinfei
 * @create 2020-05-12 13:05
 */
public interface HotSearchMapper {


    /**
     * 查询最近i条热搜
     */
    List<HotSearch> getHotSearchLimit(int i);

    /**
     * 根据hashcode查询热搜记录
     */
    HotSearch getHotSearchByContent(String content);

    /**
     * 添加热搜
     */
    void addHotSearch(HotSearch hotSearch);

    /**
     * 更新热搜
     */
    void updateHotSearch(HotSearch hotSearch);
}
