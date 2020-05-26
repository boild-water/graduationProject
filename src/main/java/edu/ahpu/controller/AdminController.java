package edu.ahpu.controller;

import com.alibaba.fastjson.JSON;
import edu.ahpu.pojo.*;
import edu.ahpu.service.*;
import edu.ahpu.util.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.List;

@Controller
@RequestMapping(value = "/admin")
public class AdminController {

    @Autowired
    private AdminService adminService;

    @Autowired
    private UserService userService;

    @Autowired
    private GoodsService goodsService;
    @Autowired
    private ImageService imageService;
    @Autowired
    private GoodsExtendsUtil goodsExtendsUtil;


    @Autowired
    private CategoryService categoryService;

    @Autowired
    private OrderService orderService;

    @Autowired
    private CommentService commentService;

    @Autowired
    private BuyinfoService buyinfoService;

    @Autowired
    private AddressService addressService;


    /**
     * 跳转到登录页面
     */
    @RequestMapping(value = "/login",method = RequestMethod.GET)
    public String loginPage(){

        return "/admin/login";
    }

    /**
     * ajax登录验证
     */
    @ResponseBody
    @RequestMapping(value = "/login",method = RequestMethod.POST)
    public Result login(Admin admin,HttpServletRequest request){

        if (admin != null) {
            Admin admin1 = adminService.findAdminByPhoneAndPassword(admin);
            if (admin1 != null){

                //将管理员信息存入session中
                request.getSession().setAttribute("admin",admin1);

                return Result.build(true,"欢迎您，"+admin1.getUsername()+"，登录成功！",admin1);
            }
        }

        return Result.build(false,"登录失败，请检查账号和密码是否正确！",null);
    }

    /**
     * 管理员注销登录
     */
    @ResponseBody
    @RequestMapping(value = "/logout")
    public Result logout(HttpServletRequest request){

        request.setAttribute("admin",null);

        return Result.build(true,"退出登录成功！",null);
    }

    /**
     * 跳转到管理员主页
     */
    @RequestMapping(value = "/index")
    public String index(){

        return "/admin/index";
    }

    /**
     * 跳转到管理员主页
     */
    @RequestMapping(value = "/welcome")
    public ModelAndView welcome(){

        ModelAndView mv = new ModelAndView();

        //用户统计 查询所有已经注册用户数
        Integer userCount = userService.getAllUsersCount();

        //物品统计
        Integer goodsCount = goodsService.getAllGoodsCount();

        //浏览统计
        Integer pageviewsCount = goodsService.getAllGoodsPageviews();

        //订单统计
        Integer orderCount = orderService.getAllOrdersCount();

        mv.addObject("userCount",userCount);
        mv.addObject("goodsCount",goodsCount);
        mv.addObject("pageviewsCount",pageviewsCount);
        mv.addObject("orderCount",orderCount);
        mv.setViewName("/admin/welcome");
        return mv;

    }


    /**
     * 跳转到管理员“个人资料”展示页面
     */
    @RequestMapping(value = "/user-setting")
    public ModelAndView getInfo(HttpServletRequest request) {

        ModelAndView modelAndView = new ModelAndView();

        //从当前session中获取admin信息
        Admin admin = (Admin) request.getSession().getAttribute("admin");

        modelAndView.addObject("admin", admin);
        modelAndView.setViewName("/admin/user-setting");
        return modelAndView;
    }

    /**
     * 修改个人资料
     */
    @ResponseBody
    @RequestMapping(value = "/changeSetting")
    public Result changeSetting(HttpServletRequest request,Admin admin) {

        //获取当前session中的id，因为前段没有传入admin id，又处于系统安全考虑，非当前登录用户的id被恶意修改
        Admin admin1 = (Admin) request.getSession().getAttribute("admin");
        admin.setId(admin1.getId());

        //这里适合条件更新(不允许更新为空值)
        adminService.updateAdminSelective(admin);

        return Result.build(true,"更改个人信息成功！",null);
    }

    /**
     * 跳转到管理员“修改密码”的页面
     */
    @RequestMapping(value = "/user-password")
    public ModelAndView getModify(HttpServletRequest request) {

        ModelAndView modelAndView = new ModelAndView();

        Admin admin = (Admin) request.getSession().getAttribute("admin");

        modelAndView.addObject("admin", admin);
        modelAndView.setViewName("admin/user-password");
        return modelAndView;
    }

    /**
     * 修改密码
     */
    @ResponseBody
    @RequestMapping(value = "/changePassword")
    public Result changePassword(HttpServletRequest request) {
        //获取输入的“旧密码”
        String oldPassword = request.getParameter("old_password");
        //获取session中的密码与旧密码比对
        Admin admin = (Admin) request.getSession().getAttribute("admin");
        if (admin.getPassword().equals(oldPassword)){

            //判断新密码和确认密码是否一致
            String newPassword = request.getParameter("new_password");
            String againPassword = request.getParameter("again_password");

            if (newPassword != null && againPassword != null
                    && newPassword.length() > 0 && againPassword.length() > 0
                    && newPassword.equals(againPassword)) {

                admin.setPassword(newPassword);
                //调用service层修改密码
                adminService.updateAdminSelective(admin);

                //密码修改成功，跳转到重新登录页面
                return Result.build(true,"修改密码成功！",null);

            } else {
                return Result.build(false,"您输入的新密码和确认密码不正确！",null);
            }

        } else {
            return Result.build(false,"您输入的旧密码不正确！",null);
        }
    }

    /*********************************************************
     * 用户管理 1.查找所有用户 2.查看用户 3.修改用户 4.删除用户 5.查询用户
     **********************************************************/

    @RequestMapping("/userPage")
    public String userPage(){

        return "/admin/user";
    }

    /**
     * 分页条件查询所有用户
     */
    @ResponseBody
    @RequestMapping(value = "/user",method = RequestMethod.GET)
    public Result<PageHeader<User>> getUserList(PageHeader ph, String searchParams) {

        User user = null;

        //由于查询数据为get请求，前端get请求传入的json数据，无法使用@RequestBody注解进行自动封装实体类
        //所以这里借助fastJson工具类，先将json转为实体类
        if (searchParams != null && searchParams.length() > 0){
            user = JSON.parseObject(searchParams,User.class);
        }

        //查询指定页码的用户信息
        PageHeader<User> pageHeader = userService.getPageUser(ph,user);

        return Result.build(true,"查询成功！",pageHeader);
    }

    /**
     * 条件更新用户字段信息(支持layui 数据表格单元格可直接进行编辑功能使用,仅限于文本类型数据)
     */
    @ResponseBody
    @RequestMapping(value = "/user/updateField",method = RequestMethod.POST)
    public Result updateField(HttpServletRequest request,User user){

        String fieldName = request.getParameter("fieldName");

        if (fieldName != null && fieldName.length() > 0){

            fieldName = fieldName.toUpperCase().charAt(0) + fieldName.substring(1);
            String updateValue = request.getParameter("updateValue");

            //利用反射为user设置属性值
            Class<? extends User> userClass = user.getClass();
            try {
                Method method = userClass.getMethod("set" + fieldName, String.class);
                method.invoke(user,updateValue);
            } catch (NoSuchMethodException e) {
                e.printStackTrace();
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            } catch (InvocationTargetException e) {
                e.printStackTrace();
            }
        }

        userService.updateUserSelective(user);

        return Result.build(true,"修改成功！",null);
    }

    /**
     * 跳转到编辑页面
     */
    @RequestMapping("/user/editPage")
    public ModelAndView user_editPage(User user){
        ModelAndView mv = new ModelAndView();

        user = userService.getUserById(user.getId());
        mv.addObject("user",user);

        mv.setViewName("/admin/user/edit");
        return mv;
    }

    /**
     * 全字段更新用户
     */
    @ResponseBody
    @RequestMapping(value = "/user/update",method = RequestMethod.POST)
    public Result update(User user){

        userService.updateUser(user);

        return Result.build(true,"更新成功！",null);
    }

    /**
     * 删除用户
     */
    @ResponseBody
    @RequestMapping(value = "/user/delete",method = RequestMethod.POST)
    public Result deleteUser(User user){

        userService.deleteUser(user);

        return Result.build(true,"删除成功！",null);
    }

    /**
     * 批量删除用户
     */
    //...



    /*********************************************************
     * 物品管理 1.查找所有物品 2.查看物品 3.修改物品 4.删除物品 5.查询物品
     **********************************************************/

    @RequestMapping("/goodsPage")
    public String goodsPage(){

        return "/admin/goods";
    }

    /**
     * 分页条件查询所有物品
     */
    @ResponseBody
    @RequestMapping(value = "/goods",method = RequestMethod.GET)
    public Result<PageHeader<Goods>> getGoodsList(PageHeader ph, String searchParams) {

        Goods goods = null;

        //由于查询数据为get请求，前端get请求传入的json数据，无法使用@RequestBody注解进行自动封装实体类
        //所以这里借助fastJson工具类，先将json转为实体类
        if (searchParams != null && searchParams.length() > 0){
            goods = JSON.parseObject(searchParams,Goods.class);
        }

        //查询指定页码的用户信息
        PageHeader<Goods> pageHeader = goodsService.getPageGoods(ph,goods);

        return Result.build(true,"查询成功！",pageHeader);
    }

    /**
     * 条件更新物品单个字段信息(针对于layui 数据表格单元格可直接进行编辑功能使用,仅限于文本类型数据)
     */
    @ResponseBody
    @RequestMapping(value = "/goods/updateField",method = RequestMethod.POST)
    public Result updateField2(HttpServletRequest request,Goods goods){

        String fieldName = request.getParameter("fieldName");

        if (fieldName != null && fieldName.length() > 0) {
            fieldName = fieldName.toUpperCase().charAt(0) + fieldName.substring(1);
            String updateValue = request.getParameter("updateValue");

            //利用反射为user设置属性值
            Class<? extends Goods> goodsClass = goods.getClass();
            try {
                Method method = goodsClass.getMethod("set" + fieldName, String.class);
                method.invoke(goods,updateValue);
            } catch (NoSuchMethodException e) {
                e.printStackTrace();
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            } catch (InvocationTargetException e) {
                e.printStackTrace();
            }
        }

        goodsService.updateGoodsSelective(goods);

        return Result.build(true,"修改成功！",null);
    }

    /**
     * 跳转到编辑页面
     */
    @RequestMapping("/goods/editPage")
    public ModelAndView goods_editPage(Goods goods){
        ModelAndView mv = new ModelAndView();

        //获取物品分类信息
        List<Category> categories = categoryService.getAllCategory();

        goods = goodsService.getGoodsById(goods.getId());
        //封装地址对象
        goods.setAddressDescUtil(AddressDescriptionUtil.getAddressDescriptionUtil(goods.getAddressDesc()));
        //封装图片信息
        GoodsExtend goodsExtend = goodsExtendsUtil.getGoodsExtendWithImg(goods);

        mv.addObject("categories",categories);
        mv.addObject("goodsExtend",goodsExtend);
        mv.setViewName("/admin/goods/edit");

        return mv;
    }

    /**
     * 全字段更新物品信息
     */
    @ResponseBody
    @RequestMapping(value = "/goods/update",method = RequestMethod.POST)
    public Result update(Goods goods,Image image){

        goods.setAddressDesc(goods.getAddressDescUtil().getDescription());
        goodsService.updateGoods(goods);

        image.setGoodsId(goods.getId());
        //更新物品的图片信息
        imageService.updateByGoodsId(image);

        return Result.build(true,"更新成功！",null);
    }

    /**
     * 删除物品
     */
    @ResponseBody
    @RequestMapping(value = "/goods/delete",method = RequestMethod.POST)
    public Result deleteGoods(Goods goods){

        goodsService.deleteGoods(goods);

        return Result.build(true,"删除成功！",null);
    }

    /**
     * 批量删除物品
     */
    //... 参考如下 既支持删除单个物品又支持删除多个物品
//    @RequestMapping(value = "/deleteGoods", method = RequestMethod.POST)
//    @ResponseBody
//    public String deleteGoods(HttpServletRequest request, @RequestParam(value = "ids[]") String[] ids) {
//        try {
//            for (int i = 0; i < ids.length; i++) {
//                goodsService.deleteGoodsByPrimaryKeys(Integer.parseInt(ids[i]));
//            }
//        } catch (Exception e) {
//            return "{\"flag\":false,\"msg\":\"删除失败!\"}";
//        }
//        return "{\"flag\":true,\"msg\":\"删除成功!\"}";
//    }


    /*********************************************************
     * 订单管理 1.查找所有订单 2.查看订单 3.修改订单 4.删除订单 5.查询订单
     **********************************************************/

    @RequestMapping("/ordersPage")
    public String ordersPage(){

        return "/admin/orders";
    }

    @RequestMapping("/orderStatusPage")
    public String orderStatusPage(){

        return "/admin/orderStatus";
    }

    /**
     * 分页查询所有订单(支持条件查找)
     */
    @RequestMapping(value = "/orders",method = RequestMethod.GET)
    @ResponseBody
    public Result<PageHeader<Order>> getOrdersList(PageHeader ph, String searchParams) {

        Order order = null;

        //由于查询数据为get请求，前端get请求传入的json数据，无法使用@RequestBody注解进行自动封装实体类
        //所以这里借助fastJson工具类，先将json转为实体类
        if (searchParams != null && searchParams.length() > 0){
            order = JSON.parseObject(searchParams,Order.class);
        }

        //查询指定页码的订单信息
        PageHeader<Order> pageHeader = orderService.getPageOrders(ph,order);

        return Result.build(true,"查询成功！",pageHeader);
    }

    /**
     * 分页查询所有订单状态(支持条件查找)
     */
    @RequestMapping(value = "/orderStatus",method = RequestMethod.GET)
    @ResponseBody
    public Result<PageHeader<OrderStatus>> getOrderStatusList(PageHeader ph, String searchParams) {

        OrderStatus orderStatus = null;

        //由于查询数据为get请求，前端get请求传入的json数据，无法使用@RequestBody注解进行自动封装实体类
        //所以这里借助fastJson工具类，先将json转为实体类
        if (searchParams != null && searchParams.length() > 0){
            orderStatus = JSON.parseObject(searchParams,OrderStatus.class);
        }

        //查询指定页码的用订单状态信息
        PageHeader<OrderStatus> pageHeader = orderService.getPageOrderStatus(ph,orderStatus);

        return Result.build(true,"查询成功！",pageHeader);
    }

    /**
     * 条件更新订单信息
     */
    @ResponseBody
    @RequestMapping(value = "/orders/updateField",method = RequestMethod.POST)
    public Result updateField3(HttpServletRequest request,Order order){

        String fieldName = request.getParameter("fieldName");

        if (fieldName != null && fieldName.length() > 0) {
            fieldName = fieldName.toUpperCase().charAt(0) + fieldName.substring(1);
            String updateValue = request.getParameter("updateValue");

            //利用反射为user设置属性值
            Class<? extends Order> orderClass = order.getClass();
            try {
                Method method = orderClass.getMethod("set" + fieldName, String.class);
                method.invoke(order,updateValue);
            } catch (NoSuchMethodException e) {
                e.printStackTrace();
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            } catch (InvocationTargetException e) {
                e.printStackTrace();
            }
        }

        orderService.updateOrdersSelective(order);

        return Result.build(true,"修改成功！",null);
    }

    /**
     * 条件更新订单状态信息
     */
    @ResponseBody
    @RequestMapping(value = "/orderStatus/updateField",method = RequestMethod.POST)
    public Result updateField4(HttpServletRequest request,OrderStatus orderStatus){

        String fieldName = request.getParameter("fieldName");

        if (fieldName != null && fieldName.length() > 0) {
            fieldName = fieldName.toUpperCase().charAt(0) + fieldName.substring(1);
            String updateValue = request.getParameter("updateValue");

            //利用反射为user设置属性值
            Class<? extends OrderStatus> orderStatusClass = orderStatus.getClass();
            try {
                Method method = orderStatusClass.getMethod("set" + fieldName, String.class);
                method.invoke(orderStatus,updateValue);
            } catch (NoSuchMethodException e) {
                e.printStackTrace();
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            } catch (InvocationTargetException e) {
                e.printStackTrace();
            }
        }

        orderService.updateOrderStatusSelective(orderStatus);

        return Result.build(true,"修改成功！",null);
    }

    /**
     * 跳转到编辑页面
     */
    @RequestMapping("/orders/editPage")
    public ModelAndView order_editPage(Order order){
        ModelAndView mv = new ModelAndView();

        order = orderService.getOrderByOrderId(order.getOrderId());

        mv.addObject("order",order);
        mv.setViewName("/admin/orders/edit");
        return mv;
    }

    /**
     * 跳转到编辑页面
     */
    @RequestMapping("/orderStatus/editPage")
    public ModelAndView orderStatus_editPage(OrderStatus orderStatus){
        ModelAndView mv = new ModelAndView();

        orderStatus = orderService.getOrderStatusByOrderId(orderStatus.getOrderId());

        mv.addObject("orderStatus",orderStatus);
        mv.setViewName("/admin/orderStatus/edit");
        return mv;
    }


    /**
     * 全字段更新订单信息
     */
    @ResponseBody
    @RequestMapping(value = "/orders/update",method = RequestMethod.POST)
    public Result updateOrder(Order order){

        orderService.updateOrders(order);

        return Result.build(true,"更新成功！",null);
    }


    /**
     * 全字段更新订单状态信息
     */
    @ResponseBody
    @RequestMapping(value = "/orderStatus/update",method = RequestMethod.POST)
    public Result updateOrderStatus(OrderStatus orderStatus){

        orderService.updateOrderStatusAdmin(orderStatus);

        return Result.build(true,"更新成功！",null);
    }



    /*********************************************************
     * 评论信息管理 1.查找评论信息 2.查看评论信息 3.修改评论信息 4.删除评论
     **********************************************************/
    @RequestMapping("/commentPage")
    public String commentPage(){

        return "/admin/comment";
    }

    /**
     * 分页条件查询所有评论信息
     */
    @ResponseBody
    @RequestMapping(value = "/comment",method = RequestMethod.GET)
    public Result<PageHeader<Comment>> getCommentList(PageHeader ph, String searchParams) {

        Comment comment = null;

        //由于查询数据为get请求，前端get请求传入的json数据，无法使用@RequestBody注解进行自动封装实体类
        //所以这里借助fastJson工具类，先将json转为实体类
        if (searchParams != null && searchParams.length() > 0){
            comment = JSON.parseObject(searchParams,Comment.class);
        }

        //查询指定页码的用户信息
        PageHeader<Comment> pageHeader = commentService.getPageComment(ph,comment);

        return Result.build(true,"查询成功！",pageHeader);
    }

    /**
     * 条件更新评论信息单个字段信息
     * (针对于layui 数据表格单元格可直接进行编辑功能使用,仅限于文本类型数据)
     */
    @ResponseBody
    @RequestMapping(value = "/comment/updateField",method = RequestMethod.POST)
    public Result updateField5(HttpServletRequest request,Comment comment){

        String fieldName = request.getParameter("fieldName");

        if (fieldName != null && fieldName.length() > 0) {
            fieldName = fieldName.toUpperCase().charAt(0) + fieldName.substring(1);
            String updateValue = request.getParameter("updateValue");

            //利用反射为comment设置属性值
            Class<? extends Comment> commentClass = comment.getClass();
            try {
                Method method = commentClass.getMethod("set" + fieldName, String.class);
                method.invoke(comment,updateValue);
            } catch (NoSuchMethodException e) {
                e.printStackTrace();
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            } catch (InvocationTargetException e) {
                e.printStackTrace();
            }
        }

        commentService.updateCommentSelective(comment);

        return Result.build(true,"修改成功！",null);
    }

    /**
     * 跳转到编辑页面
     */
    @RequestMapping("/comment/editPage")
    public ModelAndView commment_editPage(Comment comment){
        ModelAndView mv = new ModelAndView();

        comment = commentService.getCommentById(comment);

        mv.addObject("comment",comment);
        mv.setViewName("/admin/comment/edit");

        return mv;
    }

    /**
     * 全字段更新评论信息
     */
    @ResponseBody
    @RequestMapping(value = "/comment/update",method = RequestMethod.POST)
    public Result updateComment(Comment comment){

        commentService.updateComment(comment);

        return Result.build(true,"更新成功！",null);
    }

    /**
     * 删除评论
     */
    @ResponseBody
    @RequestMapping(value = "/comment/delete",method = RequestMethod.POST)
    public Result deleteComment(Comment comment){

        commentService.deleteComment(comment);

        return Result.build(true,"删除成功！",null);
    }




    /*********************************************************
     * 求购信息管理 1.查找求购信息 2.查看求购信息 3.修改求购信息 4.删除求购信息
     **********************************************************/
    @RequestMapping("/buyinfoPage")
    public String buyinfoPage(){

        return "/admin/buyinfo";
    }

    /**
     * 分页条件查询所有求购信息
     */
    @ResponseBody
    @RequestMapping(value = "/buyinfo",method = RequestMethod.GET)
    public Result<PageHeader<Buyinfo>> getBuyinfoList(PageHeader ph, String searchParams) {

        Buyinfo buyinfo = null;

        //由于查询数据为get请求，前端get请求传入的json数据，无法使用@RequestBody注解进行自动封装实体类
        //所以这里借助fastJson工具类，先将json转为实体类
        if (searchParams != null && searchParams.length() > 0){
            buyinfo = JSON.parseObject(searchParams,Buyinfo.class);
        }

        //查询指定页码的求购信息
        PageHeader<Buyinfo> pageHeader = buyinfoService.getPageBuyinfoList(ph,buyinfo);

        return Result.build(true,"查询成功！",pageHeader);
    }

    /**
     * 条件更新求购信息单个字段信息
     * (针对于layui 数据表格单元格可直接进行编辑功能使用,仅限于文本类型数据)
     */
    @ResponseBody
    @RequestMapping(value = "/buyinfo/updateField",method = RequestMethod.POST)
    public Result updateField6(HttpServletRequest request,Buyinfo buyinfo){

        String fieldName = request.getParameter("fieldName");

        if (fieldName != null && fieldName.length() > 0) {
            fieldName = fieldName.toUpperCase().charAt(0) + fieldName.substring(1);
            String updateValue = request.getParameter("updateValue");

            //利用反射为buyinfo设置属性值
            Class<? extends Buyinfo> buyinfoClass = buyinfo.getClass();
            try {
                Method method = buyinfoClass.getMethod("set" + fieldName, String.class);
                method.invoke(buyinfo,updateValue);
            } catch (NoSuchMethodException e) {
                e.printStackTrace();
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            } catch (InvocationTargetException e) {
                e.printStackTrace();
            }
        }

        buyinfoService.updateBuyinfoSelective(buyinfo);

        return Result.build(true,"修改成功！",null);
    }

    /**
     * 跳转到编辑页面
     */
    @RequestMapping("/buyinfo/editPage")
    public ModelAndView buyinfo_editPage(Buyinfo buyinfo){
        ModelAndView mv = new ModelAndView();

        buyinfo = buyinfoService.getBuyinfoById(buyinfo);

        mv.addObject("buyinfo",buyinfo);
        mv.setViewName("/admin/buyinfo/edit");

        return mv;
    }

    /**
     * 全字段更新求购信息
     */
    @ResponseBody
    @RequestMapping(value = "/buyinfo/update",method = RequestMethod.POST)
    public Result updateBuyinfo(Buyinfo buyinfo){

        buyinfoService.updateBuyinfo(buyinfo);

        return Result.build(true,"更新成功！",null);
    }

    /**
     * 删除求购信息
     */
    @ResponseBody
    @RequestMapping(value = "/buyinfo/delete",method = RequestMethod.POST)
    public Result deleteBuyinfo(Buyinfo buyinfo){

        buyinfoService.deleteBuyinfo(buyinfo);

        return Result.build(true,"删除成功！",null);
    }



    /*********************************************************
     * 地址信息管理 1.查找地址信息 2.查看地址信息 3.修改地址信息 4.删除地址信息
     **********************************************************/
    @RequestMapping("/addressPage")
    public String addressPage(){

        return "/admin/address";
    }

    /**
     * 分页条件查询所有评论信息
     */
    @ResponseBody
    @RequestMapping(value = "/address",method = RequestMethod.GET)
    public Result<PageHeader<Address>> getAddressList(PageHeader ph, String searchParams) {

        Address address = null;

        //由于查询数据为get请求，前端get请求传入的json数据，无法使用@RequestBody注解进行自动封装实体类
        //所以这里借助fastJson工具类，先将json转为实体类
        if (searchParams != null && searchParams.length() > 0){
            address = JSON.parseObject(searchParams,Address.class);
        }

        //查询指定页码的用户信息
        PageHeader<Address> pageHeader = addressService.getPageAddress(ph,address);

        return Result.build(true,"查询成功！",pageHeader);
    }

    /**
     * 条件更新评论信息单个字段信息
     * (针对于layui 数据表格单元格可直接进行编辑功能使用,仅限于文本类型数据)
     */
    @ResponseBody
    @RequestMapping(value = "/address/updateField",method = RequestMethod.POST)
    public Result updateField7(HttpServletRequest request,Address address){

        String fieldName = request.getParameter("fieldName");

        if (fieldName != null && fieldName.length() > 0) {
            fieldName = fieldName.toUpperCase().charAt(0) + fieldName.substring(1);
            String updateValue = request.getParameter("updateValue");

            //利用反射为comment设置属性值
            Class<? extends Address> addressClass = address.getClass();
            try {
                Method method = addressClass.getMethod("set" + fieldName, String.class);
                method.invoke(address,updateValue);
            } catch (NoSuchMethodException e) {
                e.printStackTrace();
            } catch (IllegalAccessException e) {
                e.printStackTrace();
            } catch (InvocationTargetException e) {
                e.printStackTrace();
            }
        }

        addressService.updateAddressSelective(address);

        return Result.build(true,"修改成功！",null);
    }

    /**
     * 跳转到编辑页面
     */
    @RequestMapping("/address/editPage")
    public ModelAndView address_editPage(Address address){
        ModelAndView mv = new ModelAndView();

        address = addressService.getAddressById(address.getId());

        mv.addObject("address",address);
        mv.setViewName("/admin/address/edit");

        return mv;
    }

    /**
     * 全字段更新评论信息
     */
    @ResponseBody
    @RequestMapping(value = "/address/update",method = RequestMethod.POST)
    public Result updateAddress(Address address){

        addressService.updateAddress(address);

        return Result.build(true,"更新成功！",null);
    }

    /**
     * 删除评论
     */
    @ResponseBody
    @RequestMapping(value = "/address/delete",method = RequestMethod.POST)
    public Result deleteAddress(Address address){

        addressService.deleteAddressById(address.getId());

        return Result.build(true,"删除成功！",null);
    }

}