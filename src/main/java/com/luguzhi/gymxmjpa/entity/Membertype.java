package com.luguzhi.gymxmjpa.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

/**
 * @Description: 会员卡类型信息实体类

 */
@Entity
@Table(name = "membertype")
@Getter
@Setter
public class Membertype {
  @Id
  @GeneratedValue(strategy =  GenerationType.IDENTITY)
  private long typeId;
  private String typeName;//
  private long typeciShu;
  private long typeDay;//有效天数

  private float typemoney;//价格

  @OneToMany(mappedBy = "membertypes")
  @JsonIgnore
  private List<Member> list=new ArrayList<Member>();


}
