package edu.ahpu.service;

import java.util.List;

import edu.ahpu.pojo.Buyinfo;
import edu.ahpu.util.PageHeader;
import edu.ahpu.util.Result;

public interface BuyinfoService {

	/************* admin 功能分界线 ************************/

	/**
	 * 分页条件查询所有求购信息
	 * @param ph
	 * @param buyinfo
	 * @return
	 */
	PageHeader<Buyinfo> getPageBuyinfoList(PageHeader ph, Buyinfo buyinfo);

	/**
	 * 条件更新buyinfo
	 * @param buyinfo
	 */
	void updateBuyinfoSelective(Buyinfo buyinfo);

	/**
	 * 根据id查询buyinfo
	 * @param buyinfo
	 * @return
	 */
	Buyinfo getBuyinfoById(Buyinfo buyinfo);

	/**
	 * 全字段更新buyinfo
	 * @param buyinfo
	 */
	void updateBuyinfo(Buyinfo buyinfo);

	/**
	 * 根据id删除buyinfo
	 * @param buyinfo
	 */
	void deleteBuyinfo(Buyinfo buyinfo);

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
	 * 分页获取求购信息
	 */
	Result<PageHeader<Buyinfo>> getPageBuyinfo(PageHeader<Buyinfo> pageHeader);

	/**
	 * 从求购信息表中查询最近的limit条求购信息
	 */
    List<Buyinfo> getBuyInfosLimit(Integer limit);


}
