package edu.ahpu.dao;

import edu.ahpu.pojo.Address;

import java.util.List;

/**
 * @author jinfei
 * @create 2020-04-08 17:56
 */
public interface AddressMapper {


    /**
     * 条件查询所有address
     * @param address
     * @return
     */
    List<Address> getAddressList(Address address);

    /**
     * 条件更新字段
     * @param address
     * @return
     */
    int updateByPrimaryKeySelective(Address address);

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
     * 将原来的默认地址更新为普通地址
     */
    void updateDefaultAddrToOrdinaryById(Integer id);

    /**
     * 将address设置为默认地址
     */
    void setDefaultAddressById(Integer id);

    /**
     * 根据id查询地址信息
     */
    Address getAddressById(Integer id);

    /**
     * 更新地址
     */
    void updateAddress(Address address);

    /**
     * 根据userId查询该用户的默认地址
     */
    Address getDefaultAddressByUserId(Integer userId);

    /**
     * 根据id删除地址
     */
    void deleteAddressById(Integer addressId);
}
