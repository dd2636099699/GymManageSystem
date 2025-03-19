package com.luguzhi.gymxmjpa.dao;


import com.luguzhi.gymxmjpa.entity.Membertype;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * @Description: 会员卡类型信息Dao层接口
 * @Author: luguzhi
 * @Date: 2024/4/3
 */
public interface MemberttypeDao extends JpaRepository<Membertype,Long> {
}
