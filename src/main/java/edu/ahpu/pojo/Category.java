package edu.ahpu.pojo;

/**
 * 物品分类 实体类
 */
public class Category {
    private Integer id;//分类id

    private String name;//分类名称

    private Integer number;//该分类下的物品数目

    private Byte status;//该分类的状态，0表示正常使用，1表示暂停使用

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public Integer getNumber() {
        return number;
    }

    public void setNumber(Integer number) {
        this.number = number;
    }

    public Byte getStatus() {
        return status;
    }

    public void setStatus(Byte status) {
        this.status = status;
    }
}