package edu.ahpu.test;

import edu.ahpu.pojo.*;
import edu.ahpu.service.*;
import edu.ahpu.util.DateUtil;
import edu.ahpu.util.IdWorker;
import edu.ahpu.util.PageHeader;
import edu.ahpu.util.Result;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

/**
 * @author jinfei
 * @create 2019-12-23 19:53
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MyTest {

    @Autowired
    CategoryService categoryService;

    @Autowired
    GoodsService goodsService;

    @Autowired
    AddressService addressService;

    @Autowired
    OrderService orderService;

    @Autowired
    BuyinfoService buyinfoService;

    @Autowired
    UserService userService;

    @Test
    public void test01() {
        List<Category> categories = categoryService.getAllCategory();
        System.out.println(categories.isEmpty());
    }

    /**
     * 测试 PageviewsAop
     */
    @Test
    public void test02() {
        System.out.println("=================");
        goodsService.getGoodsByPrimaryKey(123);
    }

    @Test
    public void test03() {
        List<Address> addresses = addressService.getAddressesByUserId(26);
        for (Address address : addresses) {
            System.out.println(address);
        }
    }

    /**
     * 测试订单生成
     */
    @Test
    public void test04() {
        Order order = new Order();
        IdWorker worker = new IdWorker(1, 1, 1);
        order.setOrderId(worker.nextId());
        order.setUserId(2);
        order.setGoodsId(123);
        order.setOrderPrice(99.0f);
        order.setCreateTime(DateUtil.getNowTime());
        order.setAddressId(1);
        order.setOrderNote("哈哈哈");
        order.setOrderType(new Byte("0"));

        orderService.addOrder(order);
    }

    /**
     * 测试地址数目查询
     */
    @Test
    public void test05() {
        int num = addressService.getAddressNumByUserId(26);
        System.out.println(num);
    }

    /**
     * 测试查询所有求购信息
     */
    @Test
    public void test06(){
        List<Buyinfo> buyinfos = buyinfoService.findAllBuyinfo();
        buyinfos.stream().forEach(System.out::println);
    }

    /**
     * 测试分页查询所有求购信息
     */
    @Test
    public void test07(){
        PageHeader<Buyinfo> pageHeader = new PageHeader<>();
        pageHeader.setPage(2);
        pageHeader.setRows(2);
        Result<PageHeader<Buyinfo>> result = buyinfoService.getPageBuyinfo(pageHeader);
        result.getData().getResults().stream().forEach(System.out::println);
    }

    /**
     * 根据id查询user
     */
    @Test
    public void test08(){
        User user = userService.getUserById(26);
        System.out.println(user);
    }

    /**
     * 测试根据物品种类id分页查询所有物品
     */
    @Test
    public void test09(){
        PageHeader<Goods> ph = new PageHeader<>();
        ph.setPage(1);
        ph.setRows(3);
//        PageHeader<Goods> pageHeader = goodsService.getGoodsByStrPage(ph, null);
        PageHeader<Goods> pageHeader = goodsService.getGoodsByCategoryPage(ph, "8", 1);
        pageHeader.getResults().stream().forEach(System.out::println);
    }

}
