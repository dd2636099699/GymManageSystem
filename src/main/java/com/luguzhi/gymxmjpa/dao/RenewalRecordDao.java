package com.luguzhi.gymxmjpa.dao;

import com.luguzhi.gymxmjpa.entity.RenewalRecord;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

/**
 * 续卡
 */
public interface RenewalRecordDao extends JpaRepository<RenewalRecord, Integer>, JpaSpecificationExecutor<RenewalRecord> {
    @Query(value = "SELECT SUM(r.czjine) FROM Chongzhi r WHERE MONTH(r.date) = ?1 AND YEAR(r.date) = ?2", nativeQuery = true)
    Double findTotalIncomeByMonthAndYear(int month, int year);






}
