package edu.ahpu.service;

import edu.ahpu.pojo.Comment;
import edu.ahpu.util.PageHeader;

/**
 * @author jinfei
 * @create 2020-04-08 17:54
 */
public interface CommentService {


    /**
     * 分页查询所有Comment
     * @param ph
     * @param comment
     * @return
     */
    PageHeader<Comment> getPageComment(PageHeader ph, Comment comment);

    /**
     * 条件更新字段
     * @param comment
     */
    void updateCommentSelective(Comment comment);

    /**
     * 根据id查询comment
     * @param comment
     * @return
     */
    Comment getCommentById(Comment comment);

    /**
     * 全字段更新评论信息
     * @param comment
     */
    void updateComment(Comment comment);

    /**
     * 根据id删除comment
     * @param comment
     */
    void deleteComment(Comment comment);
}
