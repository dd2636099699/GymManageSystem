package com.luguzhi.gymxmjpa.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Column;
import javax.persistence.Table;
import javax.persistence.ManyToOne;
import javax.persistence.JoinColumn;
import java.util.Date;
@Getter
@Setter
@Entity
@Table(name = "course_schedule")
public class CourseSchedule {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer scheduleId;

    @ManyToOne
    @JoinColumn(name = "coachId", nullable = false)
    private Coach coach;

    @ManyToOne
    @JoinColumn(name = "subId", nullable = false)
    private Subject subject;

    @ManyToOne
    @JoinColumn(name = "classroomId", nullable = false)
    private Classroom classroom;

    @Column(name = "classTime")
    private Date classTime;
    @Column(name = "startTime")
    private Date startTime;
    @Column(name = "endTime")
    private Date endTime;
    @Column(name = "courseStatus")
    private Integer courseStatus;
    @Column(name = "purchaseCount")
    private Integer purchaseCount;
}
