package com.luguzhi.gymxmjpa.dto;

public class MemberUpdateDTO {
    private Long memberId;
    private String memberName;
    private String memberPhone;
    private Integer memberSex;
    private String birthday;
    private Integer memberAge;

    public Long getMemberId() {
        return memberId;
    }

    public void setMemberId(Long memberId) {
        this.memberId = memberId;
    }

    public String getMemberName() {
        return memberName;
    }

    public void setMemberName(String memberName) {
        this.memberName = memberName;
    }

    public String getMemberPhone() {
        return memberPhone;
    }

    public void setMemberPhone(String memberPhone) {
        this.memberPhone = memberPhone;
    }

    public Integer getMemberSex() {
        return memberSex;
    }

    public void setMemberSex(Integer memberSex) {
        this.memberSex = memberSex;
    }

    public String getBirthday() {
        return birthday;
    }

    public void setBirthday(String birthday) {
        this.birthday = birthday;
    }

    public Integer getMemberAge() {
        return memberAge;
    }

    public void setMemberAge(Integer memberAge) {
        this.memberAge = memberAge;
    }
// 省略构造函数、getter和setter
}
