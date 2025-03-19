package com.luguzhi.gymxmjpa.entity;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.Data;

import javax.persistence.*;

/**
 * @Description: 充值信息实体类
 */
@Data

@Table(name = "chongzhi")
@Entity
public class Chongzhi {
  @Id
  @GeneratedValue(strategy =  GenerationType.IDENTITY)
  private Integer id;
  @OneToOne
  @JoinColumn(name = "Memberid")
  private Member member;
  private float newMoney;//充值后
  private float OriginalMoney;//原来
  @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss",timezone="GMT+8")
  private java.sql.Timestamp date;
  private float czjine;


}
