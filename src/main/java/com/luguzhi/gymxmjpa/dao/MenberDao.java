package com.luguzhi.gymxmjpa.dao;


import com.luguzhi.gymxmjpa.entity.Member;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

/**
 * @Description: 会员信息Dao层接口
 */
public interface MenberDao extends JpaRepository<Member,Long> {

}
