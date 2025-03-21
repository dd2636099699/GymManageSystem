package com.luguzhi.gymxmjpa.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

/**
 * @Description: 教练信息实体类
 * @Author: luguzhi
 * @Date: 2024/4/3
 */
@Entity
@Table(name = "coach")
@Getter
@Setter
public class Coach implements java.io.Serializable {
  @Id
  @GeneratedValue(strategy =  GenerationType.IDENTITY)
  private Long coachId;
  private String coachName;
  private String coachPhone;
  private long coachSex;
  private long coachAge;
  private java.sql.Date coachData;
  private long teach;
  private double coachWages;
  private long coachStatic;
  private String coachAddress;
  private String coachPassword;
}
