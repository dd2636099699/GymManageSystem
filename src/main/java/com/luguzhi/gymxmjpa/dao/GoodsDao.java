package com.luguzhi.gymxmjpa.dao;


import com.luguzhi.gymxmjpa.entity.Goods;
import org.springframework.data.jpa.repository.JpaRepository;

/**
 * @Description: 商品信息Dao层接口
 * @Author: luguzhi
 * @Date: 2024/4/3
 */
public interface GoodsDao extends JpaRepository<Goods,Long> {
}
