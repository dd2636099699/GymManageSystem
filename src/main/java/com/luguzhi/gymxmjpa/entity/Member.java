package com.luguzhi.gymxmjpa.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.io.Serializable;

/**
 * @Description: 会员信息实体类
 */
@Entity
@Table(name = "member")
@Getter
@Setter
public class Member implements Serializable {
  @Id
  @GeneratedValue(strategy =  GenerationType.IDENTITY)
  private long memberId;
  private String memberName;
  private String memberPhone;
  private long memberSex;
  private long memberAge;
  private String birthday;
  private String memberPassword;
  @Column(name = "groud_id")
  private Integer groupId;

  @Column(name = "face_id")
  private String faceId;

  @Lob
  @Column(name = "face_feature")
  private byte[] faceFeature;
  //@Transient
  //private long memberType;
  private java.sql.Date nenberDate;
  @ManyToOne
  @JoinColumn(name = "MemberTypes")
  private Membertype membertypes;

  private long memberStatic;

  private float memberbalance;//余额

  private java.sql.Date Memberxufei;//到期时间
}
