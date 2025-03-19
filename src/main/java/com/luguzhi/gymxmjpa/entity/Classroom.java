package com.luguzhi.gymxmjpa.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Column;
import javax.persistence.Table;
@Getter
@Setter
@Entity
@Table(name = "classroom")
public class Classroom {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer classroomId;

    @Column(name = "classroomName")
    private String classroomName;

    @Column(name = "capacity")
    private Integer capacity;

    @Column(name = "equipment")
    private String equipment;

    @Column(name = "location")
    private String location;
}
