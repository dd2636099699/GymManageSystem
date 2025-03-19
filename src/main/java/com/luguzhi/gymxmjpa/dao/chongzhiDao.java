package com.luguzhi.gymxmjpa.dao;

import com.luguzhi.gymxmjpa.entity.Chongzhi;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

/**
 * @Description: 充值信息Dao层接口
 */
public interface chongzhiDao extends JpaRepository<Chongzhi,Long> {

    Page<Chongzhi> findAll(Specification<Chongzhi> specification, Pageable pageable);

    @Query(value = "select * FROM  chongzhi where memberid =:memberid",nativeQuery = true)
    public List<Chongzhi> queryByIdNative(@Param("memberid") long memberid) ;

    @Query("SELECT DISTINCT FUNCTION('YEAR', r.date) FROM Chongzhi r ORDER BY FUNCTION('YEAR', r.date) DESC")
    List<Integer> findDistinctYears();
}
