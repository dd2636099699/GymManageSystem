package com.luguzhi.gymxmjpa.dao;

import com.luguzhi.gymxmjpa.entity.SignInRecord;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

/**
 * 签到记录
 */
public interface SignInRecordDao extends JpaRepository<SignInRecord, Integer> {

    // 查找5分钟内存在返回过去5分钟内某成员的签到次数 大于1为已经签到过了
    @Query(value = "SELECT COUNT(*) FROM signinrecord WHERE MemberName = ?1 AND SignInTime > DATE_ADD(NOW(), INTERVAL -5 MINUTE)", nativeQuery = true)
    int countRecentSignInsByMemberName(String memberName);


    // 获取当天每个用户最新的签到记录
    @Query("SELECT new com.luguzhi.gymxmjpa.entity.SignInRecord(u.memberName, MAX(u.signInTime)) " +
            "FROM SignInRecord u " +
            "WHERE FUNCTION('DATE', u.signInTime) = CURRENT_DATE " + // 确保签到时间是当天
            "GROUP BY u.memberName")
    List<SignInRecord> findLatestSignInRecordsForToday();
}