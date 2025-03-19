package com.luguzhi.gymxmjpa.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

/**
 * @Description: 课程信息实体类
 * @Author: luguzhi
 * @Date: 2024/4/3
 */
@Entity
@Table(name = "subject")
@Getter
@Setter
public class Subject {
  @Id
  @GeneratedValue(strategy =  GenerationType.IDENTITY)
  private Long subId;
  private String subname;
  private double sellingPrice;
 /* @JoinColumn
  private List<PrivateCoachInfo> privateCoachInfos;*/
// @OneToMany
// @JoinColumn(name = "subjectid")
//  private PrivateCoachInfo privateCoachInfo;

  /*

  @OneToMany
  @JsonIgnore
  private List<PrivateCoach> privateCoachList;*/

}
