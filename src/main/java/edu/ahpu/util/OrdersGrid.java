package edu.ahpu.util;

import javax.xml.bind.annotation.XmlRootElement;

import edu.ahpu.pojo.Order;

import java.util.List;

@XmlRootElement
public class OrdersGrid {
    private int current;//当前页面号
    private int rowCount;//每页行数
    private int total;//总行数
    private List<Order> rows;
    private int totalPage;//总页数

    public int getTotalPage() {

        return total % rowCount == 0 ? total / rowCount : (total / rowCount + 1);
    }

    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }

    public int getCurrent() {
        return current;
    }

    public void setCurrent(int current) {
        this.current = current;
    }

    public int getRowCount() {
        return rowCount;
    }

    public void setRowCount(int rowCount) {
        this.rowCount = rowCount;
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    public List<Order> getRows() {
        return rows;
    }

    public void setRows(List<Order> rows) {
        this.rows = rows;
    }
}
