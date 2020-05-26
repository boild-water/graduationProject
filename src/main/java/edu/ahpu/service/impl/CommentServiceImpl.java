package edu.ahpu.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import edu.ahpu.dao.CommentsMapper;
import edu.ahpu.pojo.Comment;
import edu.ahpu.pojo.Goods;
import edu.ahpu.service.CommentService;
import edu.ahpu.util.PageHeader;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author jinfei
 * @create 2020-05-19 8:31
 */
@Service
public class CommentServiceImpl implements CommentService {

    @Autowired
    private CommentsMapper commentsMapper;

    /**
     * 分页查询所有Comment
     */
    @Override
    public PageHeader<Comment> getPageComment(PageHeader ph, Comment comment) {
        PageHelper.startPage(ph.getPage(),ph.getRows());
        List<Comment> commentList = commentsMapper.getCommentList(comment);
        PageInfo<Comment> pageInfo = new PageInfo<>(commentList);

        //封装pageHeader
        ph.setCount((int) pageInfo.getTotal());
        ph.setResults(commentList);
        ph.setTotalPages(pageInfo.getPages());

        return ph;
    }

    /**
     * 条件更新字段
     */
    @Override
    public void updateCommentSelective(Comment comment) {
        commentsMapper.updateByPrimaryKeySelective(comment);
    }

    /**
     * 根据id查询comment
     */
    @Override
    public Comment getCommentById(Comment comment) {
        return commentsMapper.getCommentById(comment);
    }

    /**
     * 全字段更新评论信息
     */
    @Override
    public void updateComment(Comment comment) {
        commentsMapper.updateByPrimaryKey(comment);
    }

    /**
     * 根据id删除comment
     * @param comment
     */
    @Override
    public void deleteComment(Comment comment) {
        commentsMapper.deleteById(comment);
    }
}
