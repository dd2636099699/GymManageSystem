package com.luguzhi.gymxmjpa.dao;

import com.luguzhi.gymxmjpa.dto.CourseSaleDto;
import com.luguzhi.gymxmjpa.entity.CourseSale;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;

public interface CourseSaleDao extends JpaRepository<CourseSale, Integer>, JpaSpecificationExecutor<CourseSale> {
    @Query("SELECT new com.luguzhi.gymxmjpa.dto.CourseSaleDto(cs.id, s.subname, m.memberName, cs.purchaseDate,s.sellingPrice,c.scheduleId) " +
            "FROM CourseSale cs " +
            "JOIN cs.courseSchedule c " +
            "JOIN c.subject s " +
            "JOIN cs.member m")
    Page<CourseSaleDto> findCourseSaleInfo(Pageable pageable);

    @Query("SELECT cs FROM CourseSale cs WHERE cs.member.memberId = :memberId ORDER BY cs.id DESC")
    List<CourseSale> find(@Param("memberId") Long memberId);


}
