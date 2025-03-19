package com.luguzhi.gymxmjpa.dao;


import com.luguzhi.gymxmjpa.entity.Coach;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

/**
 * @Description: 教练信息Dao层接口
 */
public interface CoachDao extends JpaRepository<Coach,Long> {
    Coach findByCoachNameAndCoachPassword(String username, String md5Hex);

    // 使用JPQL查询所有教练的工资总和
    @Query("SELECT SUM(c.coachWages) FROM Coach c")
    Double findTotalWages();

}
