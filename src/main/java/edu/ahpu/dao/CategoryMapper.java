package edu.ahpu.dao;

import edu.ahpu.pojo.Category;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface CategoryMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Category record);

    int insertSelective(Category record);

    Category selectByPrimaryKey(Integer id);

    int updateByPrimaryKeySelective(Category record);

    int updateByPrimaryKey(Category record);

    int updateCategoryNum(@Param("id") Integer id, @Param("number") Integer number);

    List<Category> getAllCategory();//根据商品类别查询商品

    int getCount(Category category);
}