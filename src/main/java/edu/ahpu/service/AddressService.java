package edu.ahpu.service;

import edu.ahpu.pojo.Address;
import edu.ahpu.util.PageHeader;

import java.util.List;

/**
 * @author jinfei
 * @create 2020-04-08 17:54
 */
public interface AddressService {


    /**
     * 分页查询所有Address
     * @param ph
     * @param address
     * @return
     */
    PageHeader<Address> getPageAddress(PageHeader ph, Address address);

    /**
     * 条件更新字段
     * @param address
     */
    void updateAddressSelective(Address address);

    /**
     * 全字段更新地址 见下面代码
     */

    /**
     * 根据id删除地址 见下面代码
     */

    /**
     * 根据id查询地址 见下面代码
     */





    /**
     * 根据userId查询出该用户已经添加的所有地址信息
     */
    List<Address> getAddressesByUserId(Integer userId);

    /**
     * 根据userId查询该用户已经添加了多少条地址
     */
    int getAddressNumByUserId(Integer userId);

    /**
     * 往数据库中添加一个新地址
     */
    void addAddress(Address address);

    /**
     * 更新默认地址
     * 1.将原来的默认地址设置为普通地址
     * 2.再将现在的地址设置为默认地址
     */
    void updateDefaultAddress(Address address);

    /**
     * 根据id查询地址信息
     */
    Address getAddressById(Integer id);

    /**
     * 全字段更新地址
     */
    void updateAddress(Address address);

    /**
     * 删除地址
     */
    void deleteAddressById(Integer addressId);
}
