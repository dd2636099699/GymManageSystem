package com.luguzhi.gymxmjpa.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;

/**
 * @Description: 设备信息实体类
 */
@Entity
@Table(name = "equipment")
@Getter
@Setter
public class Equipment {
  @Id
  @GeneratedValue(strategy =  GenerationType.IDENTITY)
  private Integer eqId;
  private String eqName;
  private Integer count;



}
