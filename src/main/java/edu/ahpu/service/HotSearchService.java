package edu.ahpu.service;

import edu.ahpu.pojo.HotSearch;

import java.util.List;

/**
 * 热搜 service
 * @author jinfei
 * @create 2020-05-12 13:04
 */
public interface HotSearchService {

    /**
     * 查询最近i条热搜
     */
    List<HotSearch> getHotSearchLimit(int i);

    /**
     * 根据hashcode查询热搜记录
     */
    HotSearch getHotSearchByContent(String hashcode);


    /**
     * 更新热搜
     */
    void updateHotSearch(HotSearch hotSearch);

    /**
     * 添加热搜
     */
    void addHotSearch(HotSearch hotSearch);
}
