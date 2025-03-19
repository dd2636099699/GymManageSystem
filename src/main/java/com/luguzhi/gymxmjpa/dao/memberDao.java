package com.luguzhi.gymxmjpa.dao;

import com.luguzhi.gymxmjpa.entity.Member;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import javax.transaction.Transactional;
import java.util.Date;

@Transactional
public interface memberDao extends JpaRepository<Member,Long> {
    @Modifying
    @Transactional
    @Query("update Member m set m.memberPassword = :newPassword where m.memberId = :memberId")
    void updPassword(long memberId, String newPassword);


    Member findByMemberNameAndMemberPassword(String username, String md5Hex);

    // 统计已到期的会员数，即memberStatic为2的会员数
    @Query("SELECT COUNT(m) FROM Member m WHERE m.memberStatic = 2")
    long countByExpirationDateBefore();
    // 自定义SQL查询方法，根据name属性查询Member实体
    @Query("SELECT m FROM Member m WHERE m.memberName = ?1")
    Member findByName(String name);

}