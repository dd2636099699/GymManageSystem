package com.luguzhi.gymxmjpa.entity;

import com.luguzhi.gymxmjpa.entity.Equipment;
import com.luguzhi.gymxmjpa.entity.Member;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.Date;
@Getter
@Setter
@Entity
@Table(name = "reservation")
public class Reservation {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long reservationId;

    @ManyToOne
    @JoinColumn(name = "eqId", nullable = false)
    private Equipment equipment; // 预约的设备

    @ManyToOne
    @JoinColumn(name = "memberId", nullable = false) // 关联会员ID
    private Member member; // 预约的会员

    @Column(nullable = false)
    private Date date; // 预约的日期

    @Column(nullable = false)
    private String session; // 预约的时间段，例如“上午”或“下午”
}
