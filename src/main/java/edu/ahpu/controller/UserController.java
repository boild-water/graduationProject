package edu.ahpu.controller;

import edu.ahpu.pojo.*;
import edu.ahpu.service.*;
import edu.ahpu.util.*;
import org.apache.poi.ss.formula.functions.T;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.*;

@Controller
@RequestMapping(value = "/user")
public class UserController {

    @Resource
    private UserService userService;

    @Resource
    private GoodsService goodsService;

    @Resource
    private ImageService imageService;

    @Resource
    private FocusService focusService;

    @Resource
    private BuyinfoService buyinfoService;

    @Resource
    private OrderService orderService;

    @Resource
    private GoodsExtendsUtil goodsExtendsUtil;//物品图片、评论信息组装工具类

    /**
     * 跳转到登录页面
     */
    @RequestMapping(value = "/login",method = RequestMethod.GET)
    public String toLoginPage(){

        return "/user/login";
    }

    /**
     * ajax验证手机号是否存在
     */
    @ResponseBody
    @RequestMapping(value = "/ajaxPhone",method = RequestMethod.GET)
    public Result ajaxPhone(String phone){

        User user = userService.getUserByPhone(phone);
        if (user == null) {
            return Result.build(false,"该账号还没有注册！",null);
        }

        return Result.build(true,"该账号已经被注册！",null);
    }

    /**
     * 登录
     */
    @ResponseBody
    @RequestMapping(value = "/login",method = RequestMethod.POST)
    public Result login(User user,HttpServletRequest request) {

        //虽然前端已经进行了表单验证，但是后端仍需要进行表单验证
        boolean b1 = RegexUtil.genericMatcher("^1[3456789]\\d{9}$", user.getPhone());//校验手机
        boolean b2 = RegexUtil.genericMatcher("^[\\S]{6,18}$", user.getPassword());//校验手机

        if (b1 && b2){
            User u = userService.getUserByPhone(user.getPhone());

            if (u == null){
                return Result.build(false,"该账号还没有注册！",null);
            } else {

                if (MD5.md5(user.getPassword()).equals(u.getPassword())){
                    //将user存入session中
                    request.getSession().setAttribute("cur_user",u);

                    //获得该用户的上次登录时间，也放入到session中
                    request.getSession().setAttribute("lastLogin",u.getLastLogin());

                    return Result.build(true,"欢迎您，"+ u.getUsername() +"，登录成功！",null);
                } else {
                    return Result.build(false,"您输入的密码不正确！",null);
                }
            }
        }

        return Result.build(false,"您输入的账号或者密码格式不正确！",null);
    }

    /**
     * 跳转到注册页面
     */
    @RequestMapping(value = "/register",method = RequestMethod.GET)
    public String toRegisterPage(){

        return "/user/register";
    }

    /**
     * 用户注册
     */
    @ResponseBody
    @RequestMapping(value = "/register",method = RequestMethod.POST)
    public Result register(User user) throws Exception {

        //尽管前端已经对数据进行了校验，但是考虑到安全问题，后端还是要进行一次数据校验
        boolean b1 = RegexUtil.genericMatcher("^1[3456789]\\d{9}$", user.getPhone());//校验手机
        boolean b2 = RegexUtil.genericMatcher("^[\\S]{6,18}$", user.getPassword());//校验手机
        //校验用户名
        boolean b3 = (user.getUsername() == null) || (RegexUtil.genericMatcher("^((\\s.*)|(.*\\s))$", user.getUsername()));

        if (b1 && b2 && !b3){
            //1.先判断该账号是否已经注册过
            User u = userService.getUserByPhone(user.getPhone());
            if (u != null) {
                //说明该账号已经被注册
                return Result.build(false,"该账号已经被注册！",null);
            } else {
                //2.执行添加用户操作
                user.setHeadImgUrl("user_head_default.jpeg");
                user.setCreateAt(DateUtil.getNowTime());
                user.setPower(100);
                user.setStatus(new Byte("1"));
                user.setPassword(MD5.md5(user.getPassword()));

                userService.addUser(user);
                return Result.build(true,"恭喜您，注册成功！",null);
            }
        }

        return Result.build(false,"您提交的信息有误！",null);
    }

    /**
     * 注销登录
     */
    @RequestMapping(value = "/logout")
    public String logout(HttpServletRequest request) {
        request.getSession().setAttribute("cur_user", null);
        return "redirect:/goods/homeGoods";
    }

    /**
     * 个人中心
     */
    @RequestMapping(value = "/home")
    public ModelAndView home(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView();

        User user = (User) request.getSession().getAttribute("cur_user");

        //查询用户所有发布的物品的访问总量
        Integer allGoodsPageViews = goodsService.findAllGoodsPageViewsByUserId(user.getId());

        mv.addObject("allGoodsPageViews",allGoodsPageViews);
        mv.setViewName("/user/home");
        return mv;
    }

    /**
     * 更改用户名
     */
    @RequestMapping(value = "/changeName")
    public ModelAndView changeName(HttpServletRequest request, User user) {
        String url = request.getHeader("Referer");
        // 从session中获取出当前用户
        User cur_user = (User) request.getSession().getAttribute("cur_user");
        cur_user.setUsername(user.getUsername());// 更改当前用户的用户名
        userService.updateUserName(cur_user);// 执行修改操作
        request.getSession().setAttribute("cur_user", cur_user);// 修改session值
        return new ModelAndView("redirect:" + url);
    }


    /**
     * 展示个人信息
     */
    @ResponseBody
    @RequestMapping(value = "/personalSetting")
    public Result<User> basic(HttpServletRequest request) {
        //获取当前登录用户
        User cur_user = (User) request.getSession().getAttribute("cur_user");
        //根据id查询user
        User user = userService.getUserById(cur_user.getId());
        //封装成result对象返回
        return Result.build(true,"获取成功!",user);
    }

    /**
     * 异步上传用户头像图片
     */
    @ResponseBody
    @RequestMapping(value = "/uploadFile")
    public Map<String, Object> uploadFile(HttpSession session, MultipartFile file)
            throws IllegalStateException, IOException {

        String filePath = session.getServletContext().getRealPath("upload/user");//要上传的位置
        FileUploadUtil uploadUtil = new FileUploadUtil(filePath,file);
        // map中封装了 上传状态、上传后的文件名信息
        Map<String, Object> map = uploadUtil.upload();

        return map;
    }

    /**
     * 完善或修改个人信息
     */
    @ResponseBody
    @RequestMapping(value = "/updateInfo",method = RequestMethod.POST)
    public Result<User> updateInfo(HttpServletRequest request, User user) {
        //从session中获取出当前用户
        User cur_user = (User) request.getSession().getAttribute("cur_user");

        user.setId(cur_user.getId());

        userService.updateUserSelective(user);// 执行修改操作

        //更新session中的cur_user值，实际上只需要更新用户头像、用户名即可，导航栏显示需要
        cur_user.setHeadImgUrl(user.getHeadImgUrl());
        cur_user.setUsername(user.getUsername());
        request.getSession().setAttribute("cur_user", cur_user);// 修改session值

        return Result.build(true,"修改个人信息成功！",user);
    }

    /**
     * ajax验证用户修改密码时，输入的原密码是否正确
     */
    @ResponseBody
    @RequestMapping(value = "/ajaxPassword",method = RequestMethod.POST)
    public String ajaxPassword(HttpServletRequest request,String password){

        User cur_user = (User) request.getSession().getAttribute("cur_user");

        //将前台传过来的密码与当前用户的密码进行比较
        if (password != null && MD5.md5(password).equals(cur_user.getPassword())){
            //如果一致 前端提示一个“√”
            return "{\"flag\":true}";
        }

        return "{\"flag\":false}";
    }

    /**
     * 修改密码
     */
    @ResponseBody
    @RequestMapping(value = "/modifyPass",method = RequestMethod.POST)
    public Result<T> modifyPass(HttpServletRequest request, String password){

        User cur_user = (User) request.getSession().getAttribute("cur_user");
        cur_user.setPassword(MD5.md5(password));
        userService.modifyPassword(cur_user);

        //销毁当前session，要求用户重新进行登录
        request.setAttribute("cur_user",null);

        return Result.build(true,"修改密码成功！",null);
    }

    /**
     * 跳转到 我的闲置页面
     */
    @RequestMapping(value = "/allGoods")
    public ModelAndView myGoodsPage(HttpServletRequest request) {
        ModelAndView mv = new ModelAndView();

        User cur_user = (User) request.getSession().getAttribute("cur_user");
        Integer userId = cur_user.getId();

        //根据userId查询当前用户发布的所有上架物品
        List<Goods> goodsList = goodsService.getGoodsByUserId(userId);
        //然后为上架物品添加其对应的图片和评论信息
        List<GoodsExtend> goodsExtends = goodsExtendsUtil.getGoodsExtendsWithImgAndComment(goodsList);

        //根据userId查询当前用户发布的所有下架物品
        List<Goods> goodsList1 = goodsService.getOffGoodsByUserId(userId);
        //然后为上架物品添加其对应的图片信息
        List<GoodsExtend> goodsExtends1 = goodsExtendsUtil.getGoodsExtendsWithImg(goodsList1);

        mv.addObject("goodsExtends", goodsExtends);
        mv.addObject("goodsExtends1", goodsExtends1);
        mv.setViewName("/user/myGoods");

        return mv;
    }

    /**
     * 查询我的所有上架物品
     */
    @ResponseBody
    @RequestMapping(value = "/myOnSaleGoods", method = RequestMethod.GET)
    public Result myOnSaleGoods(HttpServletRequest request){
        User cur_user = (User) request.getSession().getAttribute("cur_user");
        Integer userId = cur_user.getId();

        //根据userId查询当前用户发布的所有上架物品
        List<Goods> goodsList = goodsService.getGoodsByUserId(userId);
        //然后为上架物品添加其对应的图片和评论信息
        List<GoodsExtend> goodsExtends = goodsExtendsUtil.getGoodsExtendsWithImgAndComment(goodsList);

        return Result.build(true,"查询成功！",goodsExtends);
    }

    /**
     * 查询我的所有下架物品
     */
    @ResponseBody
    @RequestMapping(value = "/myOffGoods", method = RequestMethod.GET)
    public Result myOffGoods(HttpServletRequest request){

        User cur_user = (User) request.getSession().getAttribute("cur_user");
        Integer userId = cur_user.getId();

        //根据userId查询当前用户发布的所有下架物品
        List<Goods> goodsList = goodsService.getOffGoodsByUserId(userId);
        //然后为上架物品添加其对应的图片信息
        List<GoodsExtend> goodsExtends = goodsExtendsUtil.getGoodsExtendsWithImg(goodsList);

        return Result.build(true,"查询成功！",goodsExtends);
    }

    /**
     * 我的关注 查询出所有的用户商品以及商品对应的图片
     */
    @RequestMapping(value = "/allFocus")
    public ModelAndView focus(HttpServletRequest request) {
        User cur_user = (User) request.getSession().getAttribute("cur_user");
        Integer userId = cur_user.getId();
        List<Focus> focusList = focusService.getFocusByUserId(userId);
        for (Focus focus : focusList) {
            //为每一个focus对象封装一个包含物品文字和图片信息的GoodsExtend
            GoodsExtend goodsExtend = new GoodsExtend();
            Goods goods = goodsService.getGoodsByPrimaryKey(focus.getGoodsId());
            List<Image> images = imageService.getImagesByGoodsPrimaryKey(focus.getGoodsId());
            goodsExtend.setGoods(goods);
            goodsExtend.setImages(images);
            focus.setGoodsExtend(goodsExtend);
        }
        ModelAndView mv = new ModelAndView();
        mv.addObject("focusList", focusList);
        mv.setViewName("/user/myFocus");
        return mv;
    }

    /**
     * 取消我的关注
     */
    @RequestMapping(value = "/deleteFocus/{id}")
    public String deleteFocus(HttpServletRequest request, @PathVariable("id") Integer goodsId) {

        User cur_user = (User) request.getSession().getAttribute("cur_user");
        Integer userId = cur_user.getId();
        focusService.deleteFocusByUserIdAndGoodsId(goodsId, userId);

        return "redirect:/user/allFocus";

    }

    /**
     * 查看当前用户是否已经关注某物品
     */
    @ResponseBody
    @RequestMapping(value = "/isFocus",method = RequestMethod.GET)
    public Result isFocus(Integer goodsId, HttpServletRequest request){

        User cur_user = (User) request.getSession().getAttribute("cur_user");

        //封装成一个focus对象
        Focus focus = new Focus();
        focus.setUserId(cur_user.getId());
        focus.setGoodsId(goodsId);
        focus.setFocusTime(DateUtil.getNowTime());

        //根据goodsId和userId，查询物品关注表中是否存在该条记录
        Focus f = focusService.getFocus(focus);

        if (f == null){
            //用户没有关注该物品
            return Result.build(true,"当前用户没有关注该物品！",null);
        } else {
            //该物品已经被关注，则取消关注该物品
            return Result.build(false,"当前用户已经关注该物品！",null);
        }
    }

    /**
     * 添加或者取消我的关注
     */
    @ResponseBody
    @RequestMapping(value = "/addOrCancelFocus",method = RequestMethod.GET)
    public Result addOrCancelFocus(Integer goodsId, HttpServletRequest request) {

        User cur_user = (User) request.getSession().getAttribute("cur_user");
        Integer userId = cur_user.getId();

        //封装成一个focus对象
        Focus focus = new Focus();
        focus.setUserId(userId);
        focus.setGoodsId(goodsId);
        focus.setFocusTime(DateUtil.getNowTime());

        //根据goodsId和userId，查询物品关注表中是否存在该条记录
        Focus f = focusService.getFocus(focus);

        if (f == null){
            //用户没有关注该物品
            focusService.addFocus(focus);
            return Result.build(true,"关注成功",null);
        } else {
            //该物品已经被关注，则取消关注该物品
            focusService.deleteFocusByUserIdAndGoodsId(goodsId, userId);
            return Result.build(false,"取消关注成功",null);
        }
    }


    /**
     * 跳转到求购信息页面
     */
    @RequestMapping("/buyinfo")
    public ModelAndView buyInfo() {
        ModelAndView modelAndView = new ModelAndView();

        modelAndView.setViewName("/user/buyinfo");

        return modelAndView;
    }

    /**
     * 分页展示求购信息，因为求购信息量大，并且要求实时性，所以采用pageHelper物理分页
     */
    @ResponseBody
    @RequestMapping(value = "/buyinfoPage")
    public Result<PageHeader<Buyinfo>> buyinfoPage(PageHeader<Buyinfo> pageHeader){

        return buyinfoService.getPageBuyinfo(pageHeader);
    }

    /**
     * 求购信息的发布
     */
    @ResponseBody
    @RequestMapping(value = "/buyinfo", method = RequestMethod.POST)
    public Buyinfo addBuyinfo(Buyinfo buyinfo, HttpServletRequest request){

        User user = (User) request.getSession().getAttribute("cur_user");
        buyinfo.setUserId(user.getId());
        buyinfo.setCreateAt(DateUtil.getNowTime());

        buyinfoService.addBuyinfo(buyinfo);

        System.out.println(buyinfo);
        return buyinfo;
    }

    /**
     * 我的订单 查询当前登录用户的所有买到和卖出的订单
     */
    @RequestMapping(value = "/myOrders")
    public ModelAndView orders(HttpServletRequest request) {

        ModelAndView mv = new ModelAndView();

        User cur_user = (User) request.getSession().getAttribute("cur_user");
        Integer userId = cur_user.getId();

        //查询当前用户所有买到的物品订单
        List<Order> orderList1 = orderService.getOrdersByUserId(userId);

        //为每一个order封装orderStatus
        for (Order order:orderList1){
            OrderStatus orderStatus = orderService.getOrderStatusByOrderId(order.getOrderId());
            order.setOrderStatus(orderStatus);
        }

        //查询当前用户所有卖出的物品订单
        List<Order> orderList2 = orderService.getOrdersOfSellBySellerId(userId);
        //为每一个order封装orderStatus
        for (Order order:orderList2){
            OrderStatus orderStatus = orderService.getOrderStatusByOrderId(order.getOrderId());
            order.setOrderStatus(orderStatus);
        }

        mv.addObject("ordersOfBuy", orderList1);
        mv.addObject("ordersOfSell", orderList2);

        //跳转到显示用户所有订单状态的页面
        mv.setViewName("/user/myOrders");
        return mv;
    }

}
