package com.luguzhi.gymxmjpa.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Id;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Column;
import javax.persistence.ManyToOne;
import javax.persistence.JoinColumn;
import java.util.Date;
@Getter
@Setter
@Entity
@Table(name = "CourseSale")
public class CourseSale {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "scheduleId", nullable = false)
    private CourseSchedule courseSchedule;

    @ManyToOne
    @JoinColumn(name = "memberId", nullable = false)
    private Member member;

    @Column(name = "purchaseDate", nullable = false)
    private Date purchaseDate;

    // Constructors, Getters and Setters
    public CourseSale() {
    }

}
