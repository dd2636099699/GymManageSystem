package com.luguzhi.gymxmjpa.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.Date;
@Entity
@Table(name = "renewalrecords")
@Getter
@Setter
public class RenewalRecord {
    @Id
    @GeneratedValue(strategy =  GenerationType.IDENTITY)
    private int recordId;
    @OneToOne
    @JoinColumn(name = "Typeid")
    private Membertype membertype;
    @OneToOne
    @JoinColumn(name = "Memberid")
    private Member member;//会员id
    private float originalBalance;//原始余额
    private float newBalance;//余额
    private Date renewalTime;//续卡时间
    @PrePersist
    void onCreate() {
        this.renewalTime = new Date(); // 创建记录时，设置当前时间为 createTime
    }

}
