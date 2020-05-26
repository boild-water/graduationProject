package edu.ahpu.dao;

import edu.ahpu.pojo.Comment;

import java.util.List;

public interface CommentsMapper {

    /**
     * 条件查询所有Comment
     * @param comment
     * @return
     */
    List<Comment> getCommentList(Comment comment);

    /**
     * 条件更新字段
     * @param comment
     * @return
     */
    int updateByPrimaryKeySelective(Comment comment);

    /**
     * 根据id查询comment
     * @param comment
     * @return
     */
    Comment getCommentById(Comment comment);

    /**
     * 全字段更新评论信息
     * @param comment
     * @return
     */
    int updateByPrimaryKey(Comment comment);

    /**
     * 根据id删除comment
     * @param comment
     */
    void deleteById(Comment comment);

}