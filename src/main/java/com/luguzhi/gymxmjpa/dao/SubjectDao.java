package com.luguzhi.gymxmjpa.dao;


import com.luguzhi.gymxmjpa.entity.Subject;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * @Description: 课程信息Dao层接口
 * @Author: luguzhi
 * @Date: 2024/4/3
 */
public interface SubjectDao extends JpaRepository<Subject,Long> {
}
