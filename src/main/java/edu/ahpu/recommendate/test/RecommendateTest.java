//package edu.ahpu.recommendate.test;
//
//import edu.ahpu.pojo.UserBehavior;
//import edu.ahpu.pojo.UserSimilarity;
//import edu.ahpu.service.UserBehaviorService;
//import edu.ahpu.service.impl.UserSimilarityServiceImpl;
//import edu.ahpu.util.RecommendUtils;
//import org.junit.Before;
//import org.junit.Test;
//import org.springframework.context.support.ClassPathXmlApplicationContext;
//
//import java.util.List;
//import java.util.concurrent.ConcurrentHashMap;
//
///**
// * 类描述：测试推荐模块中的一些功能
// * 类名称：com.lyu.shopping.recommendate.test.RecommendateTest
// * @author 曲健磊
// * 2018年3月26日.下午6:57:01
// * @version V1.0
// */
//public class RecommendateTest {
//
//    private ClassPathXmlApplicationContext application;
//
//    @Before
//    public void init() {
//        application = new ClassPathXmlApplicationContext("applicationContext.xml");
//    }
//
//    /**
//     * 测试列出所有用户的购买行为的方法
//     */
//    @Test
//    public void testListAllUserActive() {
//        UserBehaviorService userBehaviorsService = (UserBehaviorService) application.getBean("userActiveService");
//        // 1.查询出所有用户对所有二级类目的浏览记录
//        List<UserBehavior> userBehaviorsList = userBehaviorsService.listAllUserBehaviors();
//
//        // 2.输出浏览记录列表
//        for (UserBehavior userBehaviors : userBehaviorsList) {
//            System.out.println(userBehaviors.getUserId() + "\t" + userBehaviors.getCategoryId() + "\t" + userBehaviors.getHits());
//        }
//
//    }
//
//    /**
//     * 测试组装用户行为数据的方法
//     */
//    @Test
//    public void testAssembleUserBehavior() {
//        UserBehaviorService userBehaviorsService = (UserBehaviorService) application.getBean("userActiveService");
//        // 1.查询所有的用户浏览记录
//        List<UserBehavior> userBehaviorsList = userBehaviorsService.listAllUserBehaviors();
//
//        // 2.调用推荐模块工具类的方法组装成一个ConcurrentHashMap来存储每个用户以及其对应的二级类目的点击量
//        ConcurrentHashMap<Long, ConcurrentHashMap<Long, Long>> activeMap = RecommendUtils.assembleUserBehavior(userBehaviorsList);
//
//        // 3.输出封装后的map的大小（也就是多少个用户的浏览记录）
//        System.out.println(activeMap.size());
//    }
//
//    /**
//     * 计算用户的相似度
//     */
//    @Test
//    public void testCalcSimilarityBetweenUser() {
//        UserBehaviorService userBehaviorsService = (UserBehaviorService) application.getBean("userActiveService");
//        UserSimilarityServiceImpl userSimilarityService = (UserSimilarityServiceImpl) application.getBean("userSimilarityService");
//        // 1.查询所有的用户浏览记录
//        List<UserBehavior> userBehaviorsList = userBehaviorsService.listAllUserBehaviors();
//
//        // 2.调用推荐模块工具类的方法组装成一个ConcurrentHashMap来存储每个用户以及其对应的二级类目的点击量
//        ConcurrentHashMap<Long, ConcurrentHashMap<Long, Long>> activeMap = RecommendUtils.assembleUserBehavior(userBehaviorsList);
//
//        // 3.调用推荐模块工具类的方法计算用户与用户之间的相似度
//        List<UserSimilarity> similarityList = RecommendUtils.calcSimilarityBetweenUsers(activeMap);
//
//        // 4.输出计算好的用户之间的相似度
//        for (UserSimilarity usim : similarityList) {
//            System.out.println(usim.getUserId() + "\t" + usim.getUserRefId() + "\t" + usim.getSimilarity());
//            // 5.如果用户之间的相似度已经存在与数据库中就修改，不存在就添加
//            if (userSimilarityService.isExistsUserSimilarity(usim)) { // 修改
//            	boolean flag = userSimilarityService.updateUserSimilarity(usim);
//            	if (flag) {
//                	System.out.println("修改数据成功");
//                }
//            } else { // 新增
//            	boolean flag = userSimilarityService.saveUserSimilarity(usim);
//                if (flag) {
//                	System.out.println("插入数据成功");
//                }
//            }
//        }
//
//    }
//
//    /**
//     * 测试查询用户相似度集合列表
//     */
//    @Test
//    public void testListUserSimilarity() {
//    	UserSimilarityServiceImpl userSimilarityService = (UserSimilarityServiceImpl) application.getBean("userSimilarityService");
//        // 1.查询出某个用户与其他用户的相似度列表
//    	List<UserSimilarity> userSimilarityList = userSimilarityService.listUserSimilarityByUId(2L);
//
//    	// 2.打印输出
//    	for (UserSimilarity userSimilarityDTO : userSimilarityList) {
//    		System.out.println(userSimilarityDTO.getUserId() + "\t" + userSimilarityDTO.getUserRefId() + "\t" + userSimilarityDTO.getSimilarity());
//    	}
//
//    }
//
//    /**
//     * 测试取出与指定用户相似度最高的前N个用户
//     */
//    @Test
//    public void testGetTopNUser() {
//
//    	UserSimilarityServiceImpl userSimilarityService = (UserSimilarityServiceImpl) application.getBean("userSimilarityService");
//    	// 1.查询出某个用户与其他用户的相似度列表
//    	List<UserSimilarity> userSimilarityList = userSimilarityService.listUserSimilarityByUId(2L);
//
//    	// 2.打印输出
//    	for (UserSimilarity userSimilarityDTO : userSimilarityList) {
//    		System.out.println(userSimilarityDTO.getUserId() + "\t" + userSimilarityDTO.getUserRefId() + "\t" + userSimilarityDTO.getSimilarity());
//    	}
//
//    	// 3.获取与id为2L的用户的浏览行为最相似的前2个用户
//    	List<Long> userIds = RecommendUtils.getSimilarityBetweenUsers(2L, userSimilarityList, 3);
//
//    	// 4.打印输出
//    	System.out.println("与" + 2 + "号用户最相似的前3个用户为：");
//    	for (Long userRefId : userIds) {
//    		System.out.println(userRefId);
//    	}
//
//    }
//
//    /**
//     * 获取被推荐的类目id列表
//     */
//    @Test
//    public void testGetRecommendateCategoy2() {
//    	UserSimilarityServiceImpl userSimilarityService = (UserSimilarityServiceImpl) application.getBean("userSimilarityService");
//    	UserBehaviorService userBehaviorsService = (UserBehaviorService) application.getBean("userActiveService");
//    	// 1.查询出某个用户与其他用户的相似度列表
//    	List<UserSimilarity> userSimilarityList = userSimilarityService.listUserSimilarityByUId(1L);
//
//    	// 2.获取所有的用户的浏览记录
//    	List<UserBehavior> userActiveList = userBehaviorsService.listAllUserBehaviors();
//    	for (UserSimilarity userSimilarityDTO : userSimilarityList) {
//    		System.out.println(userSimilarityDTO.getUserId() + "\t" + userSimilarityDTO.getUserRefId() + "\t" + userSimilarityDTO.getSimilarity());
//    	}
//
//    	// 3.找出与id为1L的用户浏览行为最相似的前3个用户
//    	List<Long> userIds = RecommendUtils.getSimilarityBetweenUsers(1L, userSimilarityList, 3);
//    	System.out.println("与" + 1 + "号用户最相似的前3个用户为：");
//    	for (Long userRefId : userIds) {
//    		System.out.println(userRefId);
//    	}
//
//    	// 4.获取应该推荐给1L用户的二级类目
//    	List<Long> recommendateCategory = RecommendUtils.getRecommendCategory(1L, userIds, userActiveList);
//    	for (Long categoryId : recommendateCategory) {
//    		System.out.println("被推荐的二级类目：" + categoryId);
//    	}
//
//    }
//
//    /**
//     * 测试获取被推荐的商品列表(从被推荐的二级类目找出点击量最大的商品作为推荐的商品)
//     */
////    @Test
////    public void testGetRecommendateProduct() {
////    	UserSimilarityServiceImpl userSimilarityService = (UserSimilarityServiceImpl) application.getBean("userSimilarityService");
////    	UserBehaviorService userActiveService = (UserBehaviorService) application.getBean("userActiveService");
////    	ProductService productService = (ProductService)application.getBean("productService");
////
////    	// 1.查询出某个用户与其他用户的相似度列表
////    	List<UserSimilarity> userSimilarityList = userSimilarityService.listUserSimilarityByUId(1L);
////
////    	// 2.获取所有的用户的浏览记录
////    	List<UserBehavior> userActiveList = userActiveService.listAllUserBehaviors();
////    	for (UserSimilarity userSimilarityDTO : userSimilarityList) {
////    		System.out.println(userSimilarityDTO.getUserId() + "\t" + userSimilarityDTO.getUserRefId() + "\t" + userSimilarityDTO.getSimilarity());
////    	}
////
////    	// 3.找出与id为1L的用户浏览行为最相似的前2个用户
////    	List<Long> userIds = RecommendUtils.getSimilarityBetweenUsers(1L, userSimilarityList, 3);
////    	System.out.println("与" + 1 + "号用户最相似的前3个用户为：");
////    	for (Long userRefId : userIds) {
////    		System.out.println(userRefId);
////    	}
////
////    	// 4.获取应该推荐给1L用户的二级类目
////    	List<Long> recommendateCategory = RecommendUtils.getRecommendCategory(1L, userIds, userActiveList);
////    	for (Long categoryId : recommendateCategory) {
////    		System.out.println("被推荐的二级类目：" + categoryId);
////    	}
////
////    	// 5.找出二级类目中的所有商品
////    	List<Product> recommendateProducts = new ArrayList<Product>();
////    	for (Long categoryId : recommendateCategory) {
////    		List<ProductDTO> productList = productService.listProductByCategoryId(categoryId);
////    		// 找出当前二级类目中点击量最大的商品
////    		Product maxHitsProduct = RecommendUtils.findMaxHitsProduct(productList);
////    		recommendateProducts.add(maxHitsProduct);
////    	}
////
////    	// 6.打印输出
////    	for (Product product : recommendateProducts) {
////    		System.out.println("被推荐的商品：" + product.getProductName());
////    	}
////    }
//}
