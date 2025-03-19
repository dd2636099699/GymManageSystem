package com.luguzhi.gymxmjpa.dao;


import com.luguzhi.gymxmjpa.entity.Loos;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * @Description: 丢失物品信息Dao层接口
 * @Author: luguzhi
 * @Date: 2024/4/3
 */
public interface LoosDao extends JpaRepository<Loos,Long> {
}
