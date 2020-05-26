package edu.ahpu.controller;

import edu.ahpu.pojo.Address;
import edu.ahpu.pojo.User;
import edu.ahpu.service.AddressService;
import edu.ahpu.util.AddressDescriptionUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

/**
 * @author jinfei
 * @create 2020-04-10 19:39
 */
@Controller
@RequestMapping("/addr")
public class AddressController {

    @Autowired
    AddressService addressService;

    /**
     * 新增地址
     */
    @ResponseBody
    @RequestMapping(value = "",method = RequestMethod.POST)
    public String addAddr(Address address, AddressDescriptionUtil addrUtil, HttpServletRequest request){

        //获取当前用户
        User cur_user = (User) request.getSession().getAttribute("cur_user");
        //address对象中已经封装了username、phone信息，还要为address封装其他信息
        address.setUserId(cur_user.getId());
        address.setDescription(addrUtil.getDescription());

        String parameter = request.getParameter("isDefault");
        if (parameter != null && !parameter.equals("")){
            address.setDefaultAddr(new Byte("0"));
            addressService.addAddress(address);
        } else {
            address.setDefaultAddr(new Byte("1"));
            addressService.addAddress(address);
        }

        return "{\"status\":0,\"msg\":\"添加地址成功！\"}";
    }

    /**
     * 将地址为默认地址
     */
    @RequestMapping("/setDefaultAddr")
    @ResponseBody
    public String setDefaultAddr(Integer addressId, HttpServletRequest request){

        //获取当前用户
        User user = (User) request.getSession().getAttribute("cur_user");
        Address address = new Address();
        address.setId(addressId);
        address.setUserId(user.getId());

        addressService.updateDefaultAddress(address);

        return "{\"status\":0,\"msg\":\"设置成功！\"}";
    }

    /**
     * 点击"编辑"地址，回显信息
     */
    @ResponseBody
    @RequestMapping(value = "/edit",method = RequestMethod.GET)
    public Address toEdit(Integer addressId){

        //根据id查询地址信息
        Address address = addressService.getAddressById(addressId);
        address.setAddressUtil(AddressDescriptionUtil.getAddressDescriptionUtil(address.getDescription()));

        return address;
    }

    /**
     * 点击"修改地址"，更新地址信息
     */
    @ResponseBody
    @RequestMapping(value = "/edit",method = RequestMethod.POST)
    public String updateAddr(Address address, AddressDescriptionUtil addrUtil, HttpServletRequest request){

        //获取当前用户
        User cur_user = (User) request.getSession().getAttribute("cur_user");
        address.setUserId(cur_user.getId());
        address.setDescription(addrUtil.getDescription());
        String parameter = request.getParameter("isDefault");
        if (parameter != null && !parameter.equals("")){
            address.setDefaultAddr(new Byte("0"));
        } else {
            address.setDefaultAddr(new Byte("1"));
        }

        addressService.updateAddress(address);

        return "{\"status\":0,\"msg\":\"修改地址成功！\"}";
    }

    /**
     * 删除地址
     */
    @ResponseBody
    @RequestMapping("/delete")
    public String deleteAddress(Integer addressId){

        addressService.deleteAddressById(addressId);

        return "{\"status\":0,\"msg\":\"删除地址成功！\"}";
    }
}
