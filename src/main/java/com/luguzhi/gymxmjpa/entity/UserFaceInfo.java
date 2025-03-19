package com.luguzhi.gymxmjpa.entity;


import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;
import java.util.Date;

@NoArgsConstructor
@Data
@Entity // 标记为 JPA 实体
@Table(name = "member") // 可选，仅当数据库表名与类名不同时需要
public class UserFaceInfo {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer MemberId;
    private String memberPassword;

    @Column(name = "groud_id")
    private Integer groupId;

    @Column(name = "face_id")
    private String faceId;
    @Column(name = "MemberName")
    private String name;
    @Column(name = "MemberAge")
    private Integer age;
    @Column(name = "MemberSex")
    private Integer gender;
    private Integer MemberTypes;
    @Column(name = "NenberDate")
    private Date NenberDate;
    private Date Memberxufei;
    private String Birthday;
    private  Integer memberStatic;
    @Column(name = "Memberbalance")
    private float Memberbalance;

    @Column(name = "MemberPhone")
    private String phoneNumber;
    @Column(name = "update_time")
    @Temporal(TemporalType.TIMESTAMP)
    private Date updateTime;
    @Column(name = "face_feature")
    private byte[] faceFeature;

    public UserFaceInfo(String name, Date createTime) {
        this.name = name;
        this.NenberDate = createTime;
    }
    @PrePersist
    void onCreate() {
        this.NenberDate = new Date(); // 创建记录时，设置当前时间为 createTime
        this.updateTime = this.NenberDate; // 同时，将 updateTime 设置为和 createTime 相同的值
        this.Memberxufei=new Date();
    }

    @PreUpdate
    void onUpdate() {
        this.updateTime = new Date(); // 更新记录时，更新 updateTime 为当前时间
    }
}

