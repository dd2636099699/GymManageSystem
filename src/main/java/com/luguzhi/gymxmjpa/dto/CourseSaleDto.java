package com.luguzhi.gymxmjpa.dto;

import java.util.Date;

public class CourseSaleDto {
    private Long id;
    private String courseName;
    private String memberName;
    private Date purchaseDate;
    private Double cost;
    private Integer scheduleId;

    public CourseSaleDto(Long id, String courseName, String memberName, Date purchaseDate, Double cost,Integer  scheduleId)

    {
        this.id = id;
        this.courseName = courseName;
        this.memberName = memberName;
        this.purchaseDate = purchaseDate;
        this.cost = cost;
        this.scheduleId=scheduleId;
    }

    public Integer getScheduleId() {
        return scheduleId;
    }

    public void setScheduleId(Integer scheduleId) {
        this.scheduleId = scheduleId;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public String getMemberName() {
        return memberName;
    }

    public void setMemberName(String memberName) {
        this.memberName = memberName;
    }

    public Date getPurchaseDate() {
        return purchaseDate;
    }

    public void setPurchaseDate(Date purchaseDate) {
        this.purchaseDate = purchaseDate;
    }

    public Double getCost() {
        return cost;
    }

    public void setCost(Double cost) {
        this.cost = cost;
    }
// Getter和Setter
}