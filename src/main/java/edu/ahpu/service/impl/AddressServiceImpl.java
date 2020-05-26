package edu.ahpu.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import edu.ahpu.dao.AddressMapper;
import edu.ahpu.pojo.Address;
import edu.ahpu.service.AddressService;
import edu.ahpu.util.PageHeader;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author jinfei
 * @create 2020-04-08 17:54
 */
@Service
public class AddressServiceImpl implements AddressService {

    @Autowired
    private AddressMapper addressMapper;

    /**
     * 分页查询所有address
     */
    @Override
    public PageHeader<Address> getPageAddress(PageHeader ph, Address address) {
        PageHelper.startPage(ph.getPage(),ph.getRows());
        List<Address> addressList = addressMapper.getAddressList(address);
        PageInfo<Address> pageInfo = new PageInfo<>(addressList);

        //封装pageHeader
        ph.setCount((int) pageInfo.getTotal());
        ph.setResults(addressList);
        ph.setTotalPages(pageInfo.getPages());

        return ph;
    }


    /**
     * 条件更新字段
     */
    @Override
    public void updateAddressSelective(Address address) {
        addressMapper.updateByPrimaryKeySelective(address);
    }

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
    @Override
    public List<Address> getAddressesByUserId(Integer userId) {

        return addressMapper.getAddressesByUserId(userId);
    }

    /**
     * 根据userId查询该用户已经添加了多少条地址
     */
    @Override
    public int getAddressNumByUserId(Integer userId) {
        return addressMapper.getAddressNumByUserId(userId);
    }

    /**
     * 新增地址
     * 业务需求：用户所有地址可以不存在默认地址，如果存在默认地址，默认地址只能是一条。
     *
     * 新增地址之前，需要先判断要新增的地址是否设置为了默认地址
     * 1.如果没有设置为默认地址，那么直接新增该地址
     * 2.如果即将要新增的地址设置为了默认地址，还要判断用户是否已经含有了默认地址
     *  (1).如果用户没有默认地址，那么直接新增地址
     *  (2).如果用户已经含有默认地址，那么需要先将用户原来的默认地址更新为普通地址，然后再新增地址
     */
    @Override
    public void addAddress(Address address) {
        //先判断要新增的地址是否设置为了默认地址
        if (address.getDefaultAddr() == 0) {
            //要新增的地址设置为了默认地址,还要判断用户是否已经含有了默认地址
            Address addr = addressMapper.getDefaultAddressByUserId(address.getUserId());
            if (addr == null) {
                //用户没有默认地址，那么直接新增地址
                addressMapper.addAddress(address);
            } else {
                //用户已经含有默认地址，那么需要先将用户原来的默认地址更新为普通地址，然后再新增地址
                addressMapper.updateDefaultAddrToOrdinaryById(addr.getId());
                addressMapper.addAddress(address);
            }
        } else {
            //要新增的地址没有设置为默认地址，那么直接新增该地址
            addressMapper.addAddress(address);
        }

    }

    /**
     * 更新默认地址
     * 业务需求：用户所有地址可以不存在默认地址，如果存在默认地址，默认地址只能是一条。
     *
     * 1.将原来的默认地址设置为普通地址
     * 2.再将现在的地址设置为默认地址
     */
    @Override
    public void updateDefaultAddress(Address address) {

        Address addr = addressMapper.getDefaultAddressByUserId(address.getUserId());
        if (addr != null){
            addressMapper.updateDefaultAddrToOrdinaryById(addr.getId());
        }
        addressMapper.setDefaultAddressById(address.getId());
    }

    /**
     * 根据id查询地址信息
     */
    @Override
    public Address getAddressById(Integer id) {
        return addressMapper.getAddressById(id);
    }

    /**
     * 更新地址
     * 业务要求：用户所有地址可以不存在默认地址，如果存在默认地址，默认地址只能是一条。
     *
     * 修改地址之前，需要判断即将要更新的地址是否要被更新为默认地址
     * 1.如果不是要更新为默认地址，那么直接进行更新
     * 2.如果要被更新为默认地址，那么还要判断用户是否已经有默认地址
     *  (1).如果用户没有默认地址，那么直接更新该地址
     *  (2).如果用户已经含有一个默认地址，那么还要判断用户已经有的默认地址的id是否与即将要更新的默认地址id一致
     *      a.如果一致，用户原来的默认地址就是本条即将要更新的地址，直接更新地址
     *      b.如果不一致，用户原来的默认地址不是本条即将要更新的地址，需要先将原来的默认地址更新为普通地址，再更新地址
     */
    @Override
    public void updateAddress(Address address) {

        if (address.getDefaultAddr() == 0) {
            //即将要更新的地址设置为了默认地址
            //根据userId查询用户的默认地址
            Address addr = addressMapper.getDefaultAddressByUserId(address.getUserId());
            //判断addr是否为空，即用户是否有默认地址
            if (addr == null) {
                //用户没有默认地址
                //直接更新地址
                addressMapper.updateAddress(address);
            } else {
                //用户已经有默认地址
                //判断用户已经有的默认地址的id是否与即将要更新的默认地址id一致
                if (address.getId().equals(addr.getId())) {
                    //用户原来的默认地址就是本条即将要更新的地址
                    //直接更新地址
                    addressMapper.updateAddress(address);
                } else {
                    //用户原来的默认地址不是本条即将要更新的地址
                    //1.先将原来的默认地址更新为普通地址
                    addressMapper.updateDefaultAddrToOrdinaryById(addr.getId());
                    //2.再更新地址
                    addressMapper.updateAddress(address);
                }
            }
        } else {
            //即将要更新的地址没有设置默认地址
            //直接更新地址
            addressMapper.updateAddress(address);
        }
    }

    /**
     * 删除地址
     */
    @Override
    public void deleteAddressById(Integer addressId) {
        addressMapper.deleteAddressById(addressId);
    }

}
