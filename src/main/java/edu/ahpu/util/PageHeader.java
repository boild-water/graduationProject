package edu.ahpu.util;

import java.util.List;

/**
 * 分页头工具类
 *
 * @author jinfei
 * @create 2020-04-15 19:42
 */
public class PageHeader<T> {

    private Integer page;//当前页

    private Integer rows;//每页多少条

    private Integer count;//总数

    private Integer totalPages;//总共多少页

    private List<T> results;//数据集合

    public Integer getTotalPages() {
        return totalPages;
    }

    public void setTotalPages(Integer totalPages) {
        this.totalPages = totalPages;
    }

    public Integer getPage() {
        return page;
    }

    public void setPage(Integer page) {
        this.page = page;
    }

    public Integer getRows() {
        return rows;
    }

    public void setRows(Integer rows) {
        this.rows = rows;
    }

    public Integer getCount() {
        return count;
    }

    public void setCount(Integer count) {
        this.count = count;
    }

    public List<T> getResults() {
        return results;
    }

    public void setResults(List<T> results) {
        this.results = results;
    }

}
