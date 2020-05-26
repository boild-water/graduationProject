package edu.ahpu.service.impl;

import java.util.List;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import edu.ahpu.pojo.Buyinfo;
import edu.ahpu.util.PageHeader;
import edu.ahpu.util.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.ahpu.dao.BuyinfoMapper;
import edu.ahpu.service.BuyinfoService;

@Service
public class BuyinfoServiceImpl implements BuyinfoService {

    @Autowired
    private BuyinfoMapper buyinfoMapper;

    /************* admin 功能分界线 ************************/

    /**
     * 分页条件查询所有求购信息
     */
    @Override
    public PageHeader<Buyinfo> getPageBuyinfoList(PageHeader ph, Buyinfo buyinfo) {

        PageHelper.startPage(ph.getPage(),ph.getRows());
        List<Buyinfo> buyinfoList = buyinfoMapper.getBuyinfoList(buyinfo);
        PageInfo<Buyinfo> pageInfo = new PageInfo<>(buyinfoList);

        //封装pageHeader
        ph.setCount((int) pageInfo.getTotal());
        ph.setResults(buyinfoList);
        ph.setTotalPages(pageInfo.getPages());

        return ph;
    }

    /**
     * 条件更新字段
     */
    @Override
    public void updateBuyinfoSelective(Buyinfo buyinfo) {
        buyinfoMapper.updateByPrimaryKeySelective(buyinfo);
    }

    /**
     * 根据id查询buyinfo
     */
    @Override
    public Buyinfo getBuyinfoById(Buyinfo buyinfo) {
        return buyinfoMapper.getBuyinfoById(buyinfo);
    }

    /**
     * 全字段更新buyinfo
     */
    @Override
    public void updateBuyinfo(Buyinfo buyinfo) {
        buyinfoMapper.updateByPrimaryKey(buyinfo);
    }

    /**
     * 根据id删除buyinfo
     * @param buyinfo
     */
    @Override
    public void deleteBuyinfo(Buyinfo buyinfo) {
        buyinfoMapper.deleteById(buyinfo);
    }


    /************* admin 功能分界线 ************************/

    /**
     * 查询所有的求购信息
     */
    @Override
    public List<Buyinfo> findAllBuyinfo() {

        return buyinfoMapper.findAllBuyinfo();
    }

    /**
     * 添加求购信息
     */
    @Override
    public void addBuyinfo(Buyinfo buyinfo) {
        buyinfoMapper.addBuyinfo(buyinfo);
    }

    /**
     * 分页获取求购信息
     */
    @Override
    public Result<PageHeader<Buyinfo>> getPageBuyinfo(PageHeader<Buyinfo> pageHeader) {
        //使用pageHelper插件分页查询数据
        PageHelper.startPage(pageHeader.getPage(),pageHeader.getRows());
        List<Buyinfo> buyinfos = buyinfoMapper.findAllBuyinfo();
        //使用pageHelper组件pageInfo进一次包装
        PageInfo<Buyinfo> pageInfo = new PageInfo<>(buyinfos);

        //先为pageHeader赋值
        pageHeader.setResults(buyinfos);//封装分页数据
        pageHeader.setCount((int) pageInfo.getTotal());//封装总数目
        //pageHeader中的另外两个字段page、rows都从前端自动封装了过来，此处不再进行封装。

        //调用Result类的静态build方法 返回一个Result对象
        return Result.build(true,"查询成功！",pageHeader);
    }

    /**
     * 从求购信息表中查询最近的limit条求购信息
     */
    @Override
    public List<Buyinfo> getBuyInfosLimit(Integer limit) {

        return buyinfoMapper.getBuyInfosLimit(limit);
    }

}
