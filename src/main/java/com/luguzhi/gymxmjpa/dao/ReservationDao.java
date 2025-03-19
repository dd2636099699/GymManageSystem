package com.luguzhi.gymxmjpa.dao;

import com.luguzhi.gymxmjpa.entity.Classroom;
import com.luguzhi.gymxmjpa.entity.Reservation;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

/**
 * 设备预约
 */
@Repository
public interface ReservationDao  extends JpaRepository<Reservation, Long>, JpaSpecificationExecutor<Reservation> {
    @Query("SELECT e.count FROM Equipment e WHERE e.eqId = :eqId")
    Integer findCountByEqId(Integer eqId);
    // 根据会员ID查找预约并按指定条件排序
    List<Reservation> findByMemberMemberId(Long memberId, Sort sort);
}
