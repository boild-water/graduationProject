package edu.ahpu.util;

import edu.ahpu.pojo.UserBehavior;
import edu.ahpu.pojo.UserSimilarity;
import org.apache.poi.util.SystemOutLogger;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

/**
 * 用于商品推荐的工具类
 * @author jinfei
 * @date 2020年5月25日16:42:30
 */
public class RecommendUtils {

    /**
     * 将用户的浏览行为组装成一个map, key为userId,value也是一个map
     * value这个map的key为物品种类id(categoryId),value是它对应的被用户点击的次数(hits)
     * @param userBehaviorList 用户的浏览行为列表
     * @return 组装好的用户的浏览行为的map集合
     */
    public static ConcurrentHashMap<Integer, ConcurrentHashMap<Integer, Long>> assembleUserBehavior(List<UserBehavior> userBehaviorList) {
        ConcurrentHashMap<Integer, ConcurrentHashMap<Integer, Long>> userBehaviorMap = new ConcurrentHashMap<>();
        // 遍历查询到的用户浏览行为数据
        for (UserBehavior userBehavior : userBehaviorList) {
            // 1.获取用户id
            Integer userId = userBehavior.getUserId();
            // 2.获取categoryId
            Integer categoryId = userBehavior.getCategoryId();
            // 3.获取该目录的点击量
            Long hits = userBehavior.getHits();

            // 判断userBehaviorMap中是否已经存在了该userId的信息，如果存在则进行更新
            if (userBehaviorMap.containsKey(userId)) {
                ConcurrentHashMap<Integer, Long> tempMap = userBehaviorMap.get(userId);
                tempMap.put(categoryId, hits);
                userBehaviorMap.put(userId, tempMap);
            } else {
                // 不存在则直接put进
                ConcurrentHashMap<Integer, Long> categoryMap = new ConcurrentHashMap<>();
                categoryMap.put(categoryId, hits);
                userBehaviorMap.put(userId, categoryMap);
            }
        }

        return userBehaviorMap;
    }

    /**
     * 计算用户与用户之间的相似性，返回所有用户之间的相似度集合
     * @param userBehaviorMap 用户对各个物品种类的浏览行为的一个map集合
     * @return
     */
    public static List<UserSimilarity> calcSimilarityBetweenUsers(ConcurrentHashMap<Integer, ConcurrentHashMap<Integer, Long>> userBehaviorMap) {

        // 用户之间的相似度对集合
        List<UserSimilarity> similarityList = new ArrayList<>();

        // 获取所有的键的集合
        Set<Integer> userSet = userBehaviorMap.keySet();

        // 把这些集合放入ArrayList中
        List<Integer> userIdList = new ArrayList<>(userSet);

        // 小于两个说明当前map集合中只有一个map集合的购买行为，或者一个都没有，直接返回
        if (userIdList.size() < 2) {
            return similarityList;
        }

        // 计算所有的用户之间的相似度对(不计算自己与自己之间的相似度)
        for (int i = 0; i < userIdList.size() - 1; i++) {
            for (int j = i + 1; j < userIdList.size(); j++) {
                // 分别获取两个用户对每个目录的点击量
                ConcurrentHashMap<Integer, Long> userCategoryMap = userBehaviorMap.get(userIdList.get(i));
                ConcurrentHashMap<Integer, Long> userRefCategoryMap = userBehaviorMap.get(userIdList.get(j));

                // 获取两个map中categoryId的集合
                Set<Integer> key1Set = userCategoryMap.keySet();
                Set<Integer> key2Set = userRefCategoryMap.keySet();
                Iterator<Integer> it1 = key1Set.iterator();
                Iterator<Integer> it2 = key2Set.iterator();

                //将key1Set、key2Set中所有出现的categoryId组合在一个集合keySets中
                Set<Integer> keySets = new HashSet<>(key1Set);
                if (key1Set.size() <= key2Set.size()){
                    keySets = new HashSet<>(key2Set);
                    for (Integer categoryId:key1Set){
                        keySets.add(categoryId);
                    }
                } else {
                    for (Integer categoryId:key2Set){
                        keySets.add(categoryId);
                    }
                }

                // 两用户之间的相似度
                double similarity = 0.0;
                // 余弦相似度公式中的分子
                double molecule = 0.0;
                // 余弦相似度公式中的分母
                double denominator = 1.0;
                // 余弦相似度公式中分母根号下的两个向量的模的值
                double vector1 = 0.0;
                double vector2 = 0.0;

                for (Integer categoryId:keySets){

                    //获取每个种类(categoryId)的点击次数
                    Long hits1 = userCategoryMap.get(categoryId);
                    Long hits2 = userRefCategoryMap.get(categoryId);
                    if (hits1 == null) {
                        hits1 = 0L;
                    }
                    if (hits2 == null) {
                        hits2 = 0L;
                    }

                    // 累加分子
                    molecule += hits1 * hits2;
                    // 累加分母中的两个向量的模
                    vector1 += Math.pow(hits1, 2);
                    vector2 += Math.pow(hits2, 2);
                }

//                while (it1.hasNext() && it2.hasNext()) {
//                    Integer it1Id = it1.next();
//                    Integer it2Id = it2.next();
//                    // 获取二级类目对应的点击次数
//                    Long hits1 = userCategoryMap.get(it1Id);
//                    Long hits2 = userRefCategoryMap.get(it2Id);
//                    // 累加分子
//                    molecule += hits1 * hits2;
//                    // 累加分母中的两个向量的模
//                    vector1 += Math.pow(hits1, 2);
//                    vector2 += Math.pow(hits2, 2);
//                }

                // 计算分母
                denominator = Math.sqrt(vector1) * Math.sqrt(vector2);
                // 计算整体相似度
                similarity = molecule / denominator;

                // 创建用户相似度对对象
                UserSimilarity userSimilarity = new UserSimilarity();
                userSimilarity.setUserId(userIdList.get(i));
                userSimilarity.setUserRefId(userIdList.get(j));
                userSimilarity.setSimilarity(similarity);
                // 将计算出的用户以及用户之间的相似度对象存入list集合
                similarityList.add(userSimilarity);
            }
        }

        return similarityList;
    }

    /**
     * 找出与userId购买行为最相似的topN个用户
     * @param userId 需要参考的用户id
     * @param topN 与userId相似用户的数量
     * @return 与usereId最相似的topN个用户
     */
    public static List<Integer> getSimilarityBetweenUsers(Integer userId, List<UserSimilarity> userSimilarityList, Integer topN) {
        // 用来记录与userId相似度最高的前N个用户的id
        List<Integer> similarityList = new ArrayList<>(topN);

        // 堆排序找出最高的前N个用户，建立小根堆，遍历的时候当前的这个相似度比堆顶元素大就剔掉堆顶的值，把这个数入堆(把小的都删除干净,所以要建立小根堆)
        PriorityQueue<UserSimilarity> minHeap = new PriorityQueue<UserSimilarity>(new Comparator<UserSimilarity>(){
            @Override
            public int compare(UserSimilarity o1, UserSimilarity o2) {
                if (o1.getSimilarity() - o2.getSimilarity() > 0) {
                    return 1;
                } else if (o1.getSimilarity() - o2.getSimilarity() == 0) {
                    return 0;
                } else {
                    return -1;
                }
            }
        });

        for (UserSimilarity userSimilarity : userSimilarityList) {
            if (minHeap.size() < topN) {
                minHeap.offer(userSimilarity);
                System.out.println(minHeap.peek().getSimilarity());
            } else if (minHeap.peek().getSimilarity() < userSimilarity.getSimilarity()) {
                minHeap.poll();
                minHeap.offer(userSimilarity);
            }
        }
        // 把得到的最大的相似度的用户的id取出来(不要取它自己)
        for (UserSimilarity userSimilarity : minHeap) {
            similarityList.add(userSimilarity.getUserId().equals(userId) ? userSimilarity.getUserRefId() : userSimilarity.getUserId());
        }

        return similarityList;
    }

    /**
     * 从与当前用户相似的每个用户中各查询出一个物品浏览行为与当前用户差距最大的一个物品种类，封装成集合返回
     * @param userId 当前用户(被推荐物品的用户)
     * @param similarUserList 与当前用户相似的用户集合
     * @param allUserBehaviorList 所有用户的浏览行为
     * @return 可以推荐给userId的categoryId列表
     */
    public static Set<Integer> getRecommendCategory(Integer userId, List<Integer> similarUserList, List<UserBehavior> allUserBehaviorList) {

        //用hashSet来存储推荐物品种类categoryId，防止重复目录的产生
        Set<Integer> recommendCategoryIdSet = new HashSet<>();

        //当前用户的浏览行为列表
        List<UserBehavior> curUserBehaviorList = findUsersBrowsBehavior(userId, allUserBehaviorList);


        //对当前用户的浏览行为按照categoryId排个序，方便后续与推荐的用户的浏览行为中的种类的点击次数直接相减，避免时间复杂度为O(n2)
        Collections.sort(curUserBehaviorList, new Comparator<UserBehavior>(){
            @Override
            public int compare(UserBehavior o1, UserBehavior o2) {
                return o1.getCategoryId().compareTo(o2.getCategoryId());
            }
        });

        // 1.从与useId浏览行为相似的每个用户中找出一个推荐的二级类目
        for (Integer refId : similarUserList) {
            // 计算当前用户所点击的二级类目次数与被推荐的用户所点击的二级类目的次数的差值
            // 找到当前这个用户的浏览行为
            List<UserBehavior> refUserBehaviorList = findUsersBrowsBehavior(refId, allUserBehaviorList);

            // 排序，同上述理由
            Collections.sort(refUserBehaviorList, new Comparator<UserBehavior>(){
                @Override
                public int compare(UserBehavior o1, UserBehavior o2) {
                    return o1.getCategoryId().compareTo(o2.getCategoryId());
                }
            });

            // 记录差值最大的物品种类的id
            Integer maxCategory = 0;

            // 记录最大的差值
            double maxDifference = 0.0;

            for (int i = 0; i < refUserBehaviorList.size(); i++) {
                //求出点击量差值最大的二级类目，即为要推荐的类目
                Long hits1 = 0L;
                Long hits2 = 0L;
                try{
                    hits1 = refUserBehaviorList.get(i).getHits();
                } catch (Exception e){
                    System.out.println("数组下标越界异常！======= RecommendUtils.getRecommendCategory()");
                }
                try{
                    hits2 = curUserBehaviorList.get(i).getHits();
                } catch (Exception e){
                    System.out.println("数组下标越界异常！======= RecommendUtils.getRecommendCategory()");
                }
                double difference = Math.abs(hits1 - hits2);
                if (difference >= maxDifference) {
                    maxDifference = difference;
                    maxCategory = refUserBehaviorList.get(i).getCategoryId();
                }
            }
            recommendCategoryIdSet.add(maxCategory);
        }
        return recommendCategoryIdSet;
    }


    /**
     * 找到当前用户的浏览行为列表
     * @param userId 当前用户id
     * @param allUserBehaviorList 所有用户的浏览行为列表
     * @return 当前用户的浏览行为列表
     */
    public static List<UserBehavior> findUsersBrowsBehavior(Integer userId, List<UserBehavior> allUserBehaviorList) {

        List<UserBehavior> userBehaviorList = new ArrayList<>();
        for (UserBehavior userBehavior : allUserBehaviorList) {
            if (userBehavior.getUserId().equals(userId)) {
                userBehaviorList.add(userBehavior);
            }
        }
        return userBehaviorList;
    }


    /**
     * 整合上面的各个方法，通过分析用户行为得出推荐目录
     */
    public static Set<Integer> getRecommendCategorySet(List<UserBehavior> userBehaviorList, Integer userId){

        //调用RecommendUtil的相关方法
        //1.将所有的用户行为信息封装成userBehaviorMap
        ConcurrentHashMap<Integer, ConcurrentHashMap<Integer, Long>> userBehaviorMap
                = assembleUserBehavior(userBehaviorList);
        //2.对userBehaviorMap进行余弦相似度处理，得到所有的用户相似度列表
        List<UserSimilarity> userSimilarityList
                = calcSimilarityBetweenUsers(userBehaviorMap);

        //3.此处也可以将上面获取到的userSimilarityList存入数据库，然后再从数据库中查询与当前用户相关的所有相似度列表
        //这里不存数据库了，直接获取与当前用户相关的所有用户相似度列表
        List<UserSimilarity> usl = new ArrayList<>();

        for (UserSimilarity userSimilarity : userSimilarityList){
            if (userSimilarity.getUserId().equals(userId) || userSimilarity.getUserRefId().equals(userId)){
                usl.add(userSimilarity);
            }
        }

        //4.从与当前用户相关的相似度列表中取出与当前用户最为相似的前三个用户
        List<Integer> userRefIdList =
                getSimilarityBetweenUsers(userId, usl, 3);

        //5.从每个相似用户的行为中取出一个与当前用户差异最大的一个种类 作为推荐种类
        Set<Integer> recommendCategorySet = getRecommendCategory(userId, userRefIdList, userBehaviorList);

        return recommendCategorySet;
    }



    /**
     * 找到当前商品列表中点击量最高的商品
     * @param productList 商品列表
     * @return 点击量最高的商品
     */
//    public static Product findMaxHitsProduct(List<? extends Product> productList) {
//        if (productList == null || productList.size() == 0) {
//            return null;
//        }
//        // 记录当前最大的点击量
//        Long maxHits = 0L;
//
//        // 记录当前点击量最大的商品
//        Product product = null;
//        for (Product temp : productList) {
//            if (temp.getHits() >= maxHits) {
//                maxHits = temp.getHits();
//                product = temp;
//            }
//        }
//        return product;
//    }

}
