package com.luguzhi.gymxmjpa.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.Date;

import lombok.NoArgsConstructor;

@NoArgsConstructor
@Getter
@Setter
@Entity
@Table(name = "signinrecord")
public class SignInRecord  {

    @Id
    @GeneratedValue(strategy =  GenerationType.IDENTITY)
    private int id;
    private String memberName;
    private Date signInTime;
    public SignInRecord(String memberName, Date signInTime) {
        this.memberName = memberName;
        this.signInTime = signInTime;

    }

    public SignInRecord(String memberName) {
        this.memberName = memberName;
    }
    @PrePersist
    public void prePersist() {
        if (signInTime == null) {
            this.signInTime = Timestamp.valueOf(LocalDateTime.now()); // 设置为当前的日期和时间
        }
    }
}
