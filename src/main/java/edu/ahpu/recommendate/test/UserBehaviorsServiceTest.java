//package edu.ahpu.recommendate.test;
//
//import edu.ahpu.pojo.UserBehavior;
//import edu.ahpu.service.UserBehaviorService;
//import org.junit.Before;
//import org.junit.Test;
//import org.springframework.context.support.ClassPathXmlApplicationContext;
//
//import java.util.List;
//
///**
// * 类描述：用与测试UserActiveService接口的一些方法
// * 类名称：com.lyu.shopping.recommendate.test.UserBehaviorsServiceTest
// * @author 曲健磊
// * 2018年3月26日.下午6:36:40
// * @version V1.0
// */
//public class UserBehaviorsServiceTest {
//
//	private ClassPathXmlApplicationContext application;
//
//	@Before
//	public void init() {
//		application = new ClassPathXmlApplicationContext("applicationContext.xml");
//	}
//
//	/**
//	 * 测试查询所有的用户行为
//	 */
//	@Test
//	public void testListAllUserActive() {
//		UserBehaviorService userBehaviorsService = (UserBehaviorService) application.getBean("userActiveService");
//
//		List<UserBehavior> userBehaviorsList = userBehaviorsService.listAllUserBehaviors();
//
//		System.out.println(userBehaviorsList.size());
//
//	}
//
//	/**
//	 * 测试更新用户行为数据
//	 */
//	@Test
//	public void testSaveUserActive() {
//		UserBehaviorService userBehaviorsService = (UserBehaviorService) application.getBean("userActiveService");
//
//		UserBehavior userBehaviors = new UserBehavior();
//		userBehaviors.setUserId(1L);
//		userBehaviors.setCategoryId(1111L);
//		userBehaviors.setHits(10000L);
//		boolean flag = userBehaviorsService.saveUserBehavior(userBehaviors);
//		if (flag) {
//			System.out.println("更新用户行为数据成功!!!");
//		}
//	}
//
//}
