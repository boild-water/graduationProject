package edu.ahpu.controller;

import edu.ahpu.service.CategoryService;
import org.springframework.stereotype.Controller;

import javax.annotation.Resource;

@Controller
public class CategoryController {

    @Resource
    private CategoryService categoryService;

}
