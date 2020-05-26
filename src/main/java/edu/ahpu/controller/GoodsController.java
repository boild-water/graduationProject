package edu.ahpu.controller;

import edu.ahpu.pojo.*;
import edu.ahpu.service.*;
import edu.ahpu.util.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

@Controller
@RequestMapping(value = "/goods")
public class GoodsController {

    @Autowired
    private GoodsService goodsService;
    @Autowired
    private HotSearchService hotSearchService;
    @Autowired
    private ImageService imageService;
    @Autowired
    private CategoryService categoryService;
    @Autowired
    private UserService userService;
    @Autowired
    private AddressService addressService;
    @Autowired
    private BuyinfoService buyinfoService;
    @Autowired
    private GoodsExtendsUtil goodsExtendsUtil;

    //基于用户的物品推荐
    @Autowired
    private UserBehaviorService userBehaviorService;


    /**
     * 首页展示:
     * 1.最热门的8件物品(根据物品浏览量排序)
     * 2.最新发布的8件物品(根据物品发布时间排序)
     */
    @RequestMapping(value = "/homeGoods")
    public ModelAndView homeGoods() throws Exception {
        ModelAndView mv = new ModelAndView();

        //设定要查询的物品数目
        int goodsSize = 8;

        //从全部物品中，按照浏览量排序查询浏览量最高的8个物品信息
        List<Goods> goodsList1 = goodsService.getGoodsOrderByPageviews(goodsSize);

        //从全部物品中，按照时间排序获取最新发布的8个物品信息
        List<Goods> goodsList2 = goodsService.getGoodsOrderByDate(goodsSize);

        //分别为上面查询出的对象封装图片信息
        List<GoodsExtend> goodsExtendsHot = goodsExtendsUtil.getGoodsExtendsWithImg(goodsList1);
        List<GoodsExtend> goodsExtendsNew = goodsExtendsUtil.getGoodsExtendsWithImg(goodsList2);

        mv.addObject("goodsExtendsHot",goodsExtendsHot);
        mv.addObject("goodsExtendsNew",goodsExtendsNew);

        //首页展示最近热搜(5条)
        List<HotSearch> hotSearches = hotSearchService.getHotSearchLimit(5);
        mv.addObject("hotSearches",hotSearches);

        mv.setViewName("goods/homeGoods");
        return mv;
    }

    /**
     * 跳转到分类物品展示页面
     */
    @RequestMapping("/category/{id}")
    public ModelAndView categoryGoods(
            @PathVariable("id") Integer id,
            @RequestParam(value = "search", required = false) String search){

        ModelAndView mv = new ModelAndView();

        if (id == 0){
            Category category = new Category();
            category.setId(0);
            mv.addObject("category",category);
        } else {
            Category category = categoryService.selectByPrimaryKey(id);
            mv.addObject("category",category);
        }

        if (search != null && search.length() > 0){
            mv.addObject("searchStr",search);
        }

        //展示最近热搜(5条)
        List<HotSearch> hotSearches = hotSearchService.getHotSearchLimit(5);
        mv.addObject("hotSearches",hotSearches);

        mv.setViewName("goods/categoryGoods");

        return mv;
    }

    /**
     * 分页查询某一分类物品信息
     */
    @ResponseBody
    @RequestMapping(value = "/categoryPage/{id}")
    public Result<PageHeader<GoodsExtend>> categoryGoodsPage(
            @PathVariable("id") Integer id,
            PageHeader<Goods> pageHeader,
            @RequestParam(value = "search", required = false) String search) throws Exception {

        PageHeader<Goods> ph = null;

        if (id == 0){
            /**
             * 点击“最新发布”
             *   1.分页查询所有物品，按照擦亮时间排序
             *   2.为什么要传入str?
             *      为了整合搜索功能，可以根据物品名，物品描述信息来搜索物品
             */
            ph = goodsService.getGoodsByStrPage(pageHeader,search);
        } else {
            /**
             * 点击每一种分类
             *  1.根据分类id分页查询该分类下所有的物品，按照擦亮时间排序
             */
            ph = goodsService.getGoodsByCategoryPage(pageHeader, search, id);
        }

        //为goods封装图片信息
        List<GoodsExtend> goodsExtends = goodsExtendsUtil.getGoodsExtendsWithImg(ph.getResults());
        //新创建一个PageHeader对象，封装信息
        PageHeader<GoodsExtend> goodsExtendPageHeader = new PageHeader<>();
        goodsExtendPageHeader.setResults(goodsExtends);
        goodsExtendPageHeader.setRows(ph.getRows());
        goodsExtendPageHeader.setPage(ph.getPage());
        goodsExtendPageHeader.setCount(ph.getCount());
        goodsExtendPageHeader.setTotalPages(ph.getTotalPages());


        //添加热搜
        if (search != null && search.length() > 0) {

            //首先根据content查询热搜表中有没有该条记录
            HotSearch hotSearch = hotSearchService.getHotSearchByContent(search);

            if (hotSearch == null) {
                //说明热搜表中没有此条记录存在，那么添加热搜
                hotSearch = new HotSearch();
                hotSearch.setContent(search);
                hotSearch.setSearchTime(DateUtil.getNowTime());
                hotSearch.setSearchNum(1);

                hotSearchService.addHotSearch(hotSearch);
            } else {
                //说明该条记录已存在,那么更新热搜时间，热搜次数+1
                hotSearch.setSearchTime(DateUtil.getNowTime());
                hotSearch.setSearchNum(hotSearch.getSearchNum() + 1);
                hotSearchService.updateHotSearch(hotSearch);
            }

        }

        return Result.build(true,"获取成功！",goodsExtendPageHeader);
    }


    /**
     * 根据物品id查询该物品详细信息
     */
    @RequestMapping(value = "/goodsId/{id}")
    public ModelAndView getGoodsById(@PathVariable("id") Integer id) throws Exception {

        ModelAndView modelAndView = new ModelAndView();
        //查询该物品的goods信息和image信息 封装到GoodsExtend对象中
        Goods goods = goodsService.getGoodsByPrimaryKey(id);
        List<Image> imageList = imageService.getImagesByGoodsPrimaryKey(id);
        //查询该物品的所属卖家信息
        User seller = userService.selectByPrimaryKey(goods.getUserId());
        //查询该物品下的所有评论信息
        List<Comment> comments = goodsService.selectCommentsByGoodsId(id);
        //添加到goodsExtend对象中
        GoodsExtend goodsExtend = new GoodsExtend();
        goodsExtend.setGoods(goods);
        goodsExtend.setImages(imageList);
        goodsExtend.setComments(comments);
        //查询该物品的分类信息
        Category category = categoryService.selectByPrimaryKey(goods.getCategoryId());

        //把上面查询到的信息都封装到请求域中
        modelAndView.addObject("goodsExtend", goodsExtend);
        modelAndView.addObject("category", category);
        modelAndView.addObject("seller", seller);

        //展示最近热搜(5条)
        List<HotSearch> hotSearches = hotSearchService.getHotSearchLimit(5);
        modelAndView.addObject("hotSearches",hotSearches);

        modelAndView.setViewName("goods/detailGoods");


        return modelAndView;

    }

    /**
     * 在物品下发表评论
     */
    @ResponseBody
    @RequestMapping(value = "/addComments", method = RequestMethod.POST)
    public Result<Comment> addComment(HttpServletRequest request, Comment comment) {
        //获取当前登录用户
        User cur_user = (User) request.getSession().getAttribute("cur_user");
        comment.setUser(cur_user);
        //设置发表时间
        comment.setCreateAt(DateUtil.getNowTime());
        //添加评论
        goodsService.addComments(comment);

        //注意:如果以字符串的方式发送json数据
        // 用单引号引用的变量会导致前端对传过去的json数据解析失败，如"{'msg':'评论成功！','status':0}"
        // 正确的方式应该像下面一样，使用转义符
        return Result.build(true,"发布评论成功！",comment);
    }

    /**
     * 点击我要发布，跳转到发布物品页面
     */
    @RequestMapping(value = "/publishGoods")
    public ModelAndView publishGoods(HttpServletRequest request) {

        ModelAndView mv = new ModelAndView();

        // 可以校验用户是否登录
        User cur_user = (User) request.getSession().getAttribute("cur_user");

        List<Category> categories = categoryService.getAllCategory();

        /***************前端需要显示 “猜你喜欢”      开始 *******************/

        //查询所有的用户行为信息
        List<UserBehavior> userBehaviorList = userBehaviorService.listAllUserBehaviors();
        //分析用户行为获取系统对当前用户的物品推荐种类
        Integer userId = cur_user.getId();
        Set<Integer> recommendCategorySet = RecommendUtils.getRecommendCategorySet(userBehaviorList, userId);
        //根据查询出的推荐种类，从中各查找一个物品，传到前端展示
        List<Goods> goodsList = goodsService.findGoodsByCategoryIdList(recommendCategorySet);
        //如果没有为该用户推荐到物品，那么就查询最热门的三个物品推荐给用户
        if (goodsList == null || goodsList.size() == 0){
            goodsList = goodsService.getGoodsOrderByPageviews(3);
        }

        /***************前端需要显示 “猜你喜欢”      结束 *******************/

        //前端需要显示“求购信息”，从数据库中查询最近5条求购信息
        List<Buyinfo> buyInfos = buyinfoService.getBuyInfosLimit(5);

        //为查询到的物品封装图片信息
        List<GoodsExtend> goodsExtends = goodsExtendsUtil.getGoodsExtendsWithImg(goodsList);

        mv.addObject("categories",categories);
        mv.addObject("buyInfos",buyInfos);
        mv.addObject("goodsExtends",goodsExtends);

        mv.setViewName("/goods/pubGoods");
        return mv;
    }

    /**
     * 异步上传物品图片
     * 效果:相同内容的文件在服务器上仅保存一份
     */
    @ResponseBody
    @RequestMapping(value = "/uploadFile")
    public Map<String, Object> uploadFile(HttpServletRequest request, MultipartFile file)
            throws IllegalStateException, IOException {

        Map<String, Object> map = new HashMap<>();

        //首先判断该文件在服务器上是否已经存在
        //得到该文件的md5加密字符串
        String fileMD5 = MD5.getFileMD5(file.getInputStream());
        String oldFilename = file.getOriginalFilename();
        String imgUrl = fileMD5 + oldFilename.substring(oldFilename.lastIndexOf("."));
        Image image = imageService.getImageByImgUrl(imgUrl);

        if (image == null){
            //说明该文件没有上传到服务器上，需要进行上传操作
            String filePath = request.getServletContext().getRealPath("upload/goods");
            map = new FileUploadUtil(filePath, file).upload();
        } else {
            //文件在服务器上已存在，不需要上传，直接返回
            map.put("status", 0);//0表示上传成功，1表示上传失败
            map.put("fileUrl", imgUrl);
        }

        return map;
    }

    /**
     * 提交发布的物品信息
     */
    @ResponseBody
    @RequestMapping(value = "/publishGoodsSubmit")
    public Result publishGoodsSubmit(
            HttpServletRequest request,Image ima, Goods goods) throws Exception {

        //查询出当前用户cur_user对象，便于使用id
        User cur_user = (User) request.getSession().getAttribute("cur_user");

        /**
         * 封装goods数据
         */
        //封装浏览量
        goods.setPageviews(0);
        //封装userId
        goods.setUserId(cur_user.getId());
        //封装是否可讲价
        String is_bargain = request.getParameter("is_bargain");
        if (is_bargain != null && is_bargain.length() > 0){
            goods.setIsBargain(new Byte("0"));//设置可讲价
        } else {
            goods.setIsBargain(new Byte("1"));//设置不可讲价
        }
        //封装是否上架
        String onSale = request.getParameter("onSale");
        if (onSale != null && onSale.length() > 0){
            goods.setStatus(1);//上架该物品
        } else {
            goods.setStatus(0);//下架该物品
        }
        //封装物品发布的地址信息
        goods.setAddressDesc(goods.getAddressDescUtil().getDescription());

        //执行插入物品信息操作，插入完成后，会返回该物品的id
        goodsService.addGood(goods);

        //判断卖家是否上传了物品图片
        if (ima.getImgUrl() == null || ima.getImgUrl().length() <= 0){
            //使用默认图片
            ima.setImgUrl("goods_default.jpg");
        }

        //设置图片对应的物品id
        ima.setGoodsId(goods.getId());
        //在image表中插入物品图片
        imageService.insert(ima);

        //重定向到 /user/allGoods请求 使用重定向还有个好处就是防止表单提交后，页面刷新会导致重复提交表单！
//        return "redirect:/user/allGoods";
        return Result.build(true,"发布物品成功！",null);
    }

    /**
     * 擦亮物品
     */
    @ResponseBody
    @RequestMapping("/polishGoods")
    public String polishGoods(Integer goodsId){

        goodsService.polishGoods(goodsId);//物品擦亮

        return "{\"status\":0}";
    }

    /**
     * 点击编辑物品，进入物品修改页面
     */
    @RequestMapping(value = "/editGoods/{id}")
    public ModelAndView editGoods(HttpServletRequest request, @PathVariable("id") Integer id) throws Exception {

        User cur_user = (User) request.getSession().getAttribute("cur_user");
        Integer userId = cur_user.getId();
        //查询物品
        Goods goods = goodsService.getGoodsByPrimaryKey(id);
        //还要为物品封装地址工具类，供前端显示
        goods.setAddressDescUtil(AddressDescriptionUtil.getAddressDescriptionUtil(goods.getAddressDesc()));
        //查询物品图片
        List<Image> imageList = imageService.getImagesByGoodsPrimaryKey(id);

        //将物品信息和物品图片信息封装成一个GoodsExtend对象
        GoodsExtend goodsExtend = new GoodsExtend();
        goodsExtend.setGoods(goods);
        goodsExtend.setImages(imageList);

        List<Category> categories = categoryService.getAllCategory();

        /**
         * 前端需要显示“猜你喜欢”      开始
         */
        //查询所有的用户行为信息
        List<UserBehavior> userBehaviorList = userBehaviorService.listAllUserBehaviors();
        //分析用户行为获取系统对当前用户的物品推荐种类
        Set<Integer> recommendCategorySet = RecommendUtils.getRecommendCategorySet(userBehaviorList, userId);
        //根据查询出的推荐种类，从中各查找一个物品，传到前端展示
        List<Goods> goodsList = goodsService.findGoodsByCategoryIdList(recommendCategorySet);
        //如果没有为该用户推荐到物品，那么就查询最热门的三个物品推荐给用户
        if (goodsList == null || goodsList.size() == 0){
            goodsList = goodsService.getGoodsOrderByPageviews(3);
        }
        /**
         * 前端需要显示“猜你喜欢”       结束
         */

        //为查询到的物品封装图片信息
        List<GoodsExtend> goodsExtends = goodsExtendsUtil.getGoodsExtendsWithImg(goodsList);

        //前端需要显示“求购信息”，从数据库中查询最近5条求购信息
        List<Buyinfo> buyInfos = buyinfoService.getBuyInfosLimit(5);

        ModelAndView modelAndView = new ModelAndView();
        // 将物品信息添加到model
        modelAndView.addObject("goodsExtend", goodsExtend);
        modelAndView.addObject("categories",categories);
        modelAndView.addObject("buyInfos",buyInfos);
        modelAndView.addObject("goodsExtends",goodsExtends);

        modelAndView.setViewName("/goods/editGoods");
        return modelAndView;
    }

    /**
     * 更新物品信息
     */
    @ResponseBody
    @RequestMapping(value = "/editGoodsSubmit",method = RequestMethod.POST)
    public Result editGoodsSubmit(
            HttpServletRequest request, Goods goods,Image image) throws Exception {

        /**
         * 封装goods数据
         */
        //封装是否可讲价
        String is_bargain = request.getParameter("is_bargain");
        if (is_bargain != null && is_bargain.length() > 0){
            //设置可讲价
            goods.setIsBargain(new Byte("0"));
        } else {
            //设置不可讲价
            goods.setIsBargain(new Byte("1"));
        }
        //封装擦亮时间，修改物品时就会自动擦亮物品
        goods.setPolishTime(DateUtil.getNowTime());
        //封装是否上架
        String onSale = request.getParameter("onSale");
        if (onSale != null && onSale.length() > 0){
            //上架该物品
            goods.setStatus(1);
        } else {
            //下架该物品
            goods.setStatus(0);
        }
        //封装物品发布的地址信息
        goods.setAddressDesc(goods.getAddressDescUtil().getDescription());

        //更新物品的文字描述信息
        goodsService.updateGoodsSelective(goods);


        image.setGoodsId(goods.getId());
        //更新物品的图片信息
        imageService.updateByGoodsId(image);

        return Result.build(true,"更新物品信息成功！",null);
    }

    /**
     * 物品下架
     */
    @ResponseBody
    @RequestMapping(value = "/offGoods")
    public String offGoods(Integer goodsId) throws Exception {
        Goods goods = new Goods();
        goods.setId(goodsId);
        goods.setStatus(0);
        goodsService.updateGoodsByGoodsId(goods);
        return "{\"status\":0}";
    }

    /**
     * 物品上架
     */
    @ResponseBody
    @RequestMapping(value = "/onSaleGoods")
    public String onSaleGoods(Integer goodsId) throws Exception {
        Goods goods = new Goods();
        goods.setId(goodsId);
        goods.setStatus(1);
        goodsService.updateGoodsByGoodsId(goods);
        return "{\"status\":0}";
    }

    /**
     * 用户删除物品
     */
    @RequestMapping(value = "/deleteGoods/{id}")
    public String deleteGoods(HttpServletRequest request, @PathVariable("id") Integer id) throws Exception {
        Goods goods = goodsService.getGoodsByPrimaryKey(id);
        // 删除物品后，category的number-1，user表的goods_num-1，image删除,更新session的值
        User cur_user = (User) request.getSession().getAttribute("cur_user");
        goods.setUserId(cur_user.getId());
        Integer category_id = goods.getCategoryId();
        Category category = categoryService.selectByPrimaryKey(category_id);
        categoryService.updateCategoryNum(category_id, category.getNumber() - 1);

        // 修改session值
        request.getSession().setAttribute("cur_user", cur_user);

        //由于删除物品实际上是将物品的status设置为0，物品实际上还会被存在数据库中，所以就不必删除其对应的图片信息
        //imageService.deleteImagesByGoodsPrimaryKey(id);

        goodsService.deleteGoodsByPrimaryKey(id);
        return "redirect:/user/allGoods";
    }

    /**
     * 点击"立即购买"，跳转到订单确认页面，核对订单。
     */
    @RequestMapping(value = "/orderCheck/{id}")
    public ModelAndView orderCheck(HttpServletRequest request, @PathVariable("id") Integer id) throws Exception {

        //1.查询当前用户已经添加的所有收货地址信息
        User cur_user = (User) request.getSession().getAttribute("cur_user");
        List<Address> addresses = addressService.getAddressesByUserId(cur_user.getId());

        //地址处理
        for (Address address:addresses){
            address.setAddressUtil(AddressDescriptionUtil.getAddressDescriptionUtil(address.getDescription()));
        }

        //2.查询物品信息
        Goods goods = goodsService.getGoodsByPrimaryKey(id);
        GoodsExtend goodsExtend = new GoodsExtend();
        List<Image> imageList = imageService.getImagesByGoodsPrimaryKey(id);
        goodsExtend.setGoods(goods);
        goodsExtend.setImages(imageList);

        //3.封装信息
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("goodsExtend", goodsExtend);
        modelAndView.addObject("addresses", addresses);
        modelAndView.setViewName("/user/orderCheck");
        return modelAndView;
    }

}