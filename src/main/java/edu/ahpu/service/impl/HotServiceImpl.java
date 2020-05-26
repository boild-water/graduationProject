package edu.ahpu.service.impl;

import edu.ahpu.dao.HotSearchMapper;
import edu.ahpu.pojo.HotSearch;
import edu.ahpu.service.HotSearchService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 热搜 service实现
 * @author jinfei
 * @create 2020-05-12 13:05
 */
@Service
public class HotServiceImpl implements HotSearchService {

    @Autowired
    private HotSearchMapper hotSearchMapper;

    /**
     * 查询最近 i 条热搜
     */
    @Override
    public List<HotSearch> getHotSearchLimit(int i) {

        return hotSearchMapper.getHotSearchLimit(i);
    }

    /**
     * 根据hashcode查询热搜记录
     */
    @Override
    public HotSearch getHotSearchByContent(String content) {
        return hotSearchMapper.getHotSearchByContent(content);
    }

    /**
     * 更新热搜
     */
    @Override
    public void updateHotSearch(HotSearch hotSearch) {
        hotSearchMapper.updateHotSearch(hotSearch);
    }

    /**
     * 添加热搜
     */
    @Override
    public void addHotSearch(HotSearch hotSearch) {
        hotSearchMapper.addHotSearch(hotSearch);
    }
}
