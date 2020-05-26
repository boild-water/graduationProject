package edu.ahpu.service;

import java.util.List;

import edu.ahpu.pojo.Category;

/**
 */
public interface CategoryService {

    public List<Category> getAllCategory();

    public int getCount(Category category);

    Category selectByPrimaryKey(Integer id);

    int updateByPrimaryKey(Category record);

    int updateCategoryNum(Integer id, Integer number);
}
