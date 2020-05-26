//package edu.ahpu.recommendate.test;
//
//import edu.ahpu.pojo.UserBehavior;
//import edu.ahpu.dao.UserBehaviorMapper;
//import org.junit.Before;
//import org.junit.Test;
//import org.springframework.context.support.ClassPathXmlApplicationContext;
//
///**
// * 类描述：用与测试UserActiveMapper接口的一些方法
// * 类名称：com.lyu.shopping.recommendate.test.UserActiveMapperTest
// * @author 曲健磊
// * 2018年4月4日.下午7:58:56
// * @version V1.0
// */
//public class UserActiveMapperTest {
//
//	private ClassPathXmlApplicationContext application;
//
//	@Before
//	public void init() {
//		application = new ClassPathXmlApplicationContext("applicationContext.xml");
//	}
//
//	/**
//	 * 测试统计某个用户的行为记录的条数
//	 */
//	@Test
//	public void testCountUserActive() {
//		UserBehaviorMapper userActiveMapper = (UserBehaviorMapper) application.getBean("userActiveMapper");
//		UserBehavior userBehaviors = new UserBehavior();
//		userBehaviors.setUserId(1L);
//		userBehaviors.setCategoryId(35L);
//		userBehaviors.setHits(10000L);
//		int rows = userActiveMapper.countUserActive(userBehaviors);
//		if (rows >= 1) {
//			System.out.println("存在用户id为：" + userBehaviors.getUserId() +
//				",二级类目id为：" + userBehaviors.getCategoryId() + "用户行为记录");
//		}
//	}
//
//	/**
//	 * 测试统计某个用户的行为记录的条数
//	 */
//	@Test
//	public void testGetHitsOfUser() {
//		UserBehaviorMapper userActiveMapper = (UserBehaviorMapper) application.getBean("userActiveMapper");
//		UserBehavior userBehaviors = new UserBehavior();
//		Long userId = 1L;
//		Long categoryId = 24L;
//		userBehaviors.setUserId(userId);
//		userBehaviors.setCategoryId(categoryId);
//
//		int hits = userActiveMapper.getHitsByUserBehavior(userBehaviors);
//
//		System.out.println("用户id为：" + userId + "，二级类目id为：" + categoryId + "的点击量为：" + hits);
//
//	}
//
//	/**
//	 * 测试更新某个用户对某个二级类目的点击量
//	 */
//	@Test
//	public void testUpdateHitsOfUser() {
//		UserBehaviorMapper userActiveMapper = (UserBehaviorMapper) application.getBean("userActiveMapper");
//		UserBehavior userBehaviors = new UserBehavior();
//		Long userId = 1L;
//		Long categoryId = 24L;
//		Long hits = 12001L;
//		userBehaviors.setUserId(userId);
//		userBehaviors.setCategoryId(categoryId);
//		userBehaviors.setHits(hits);;
//
//		int rows = userActiveMapper.updateUserBehavior(userBehaviors);
//
//		if (rows > 0) {
//			System.out.println("更新用户的点击量成功!");
//		} else {
//			System.out.println("更新用户的点击量失败!");
//		}
//	}
//}
