package com.luguzhi.gymxmjpa.dto;



public class FaceUserInfo {

    private String faceId;
    private String name;
    private Integer similarValue;
    private byte[] faceFeature;
    // 无参构造函数
    public FaceUserInfo() {
    }
    public FaceUserInfo(String faceId, String name, byte[] faceFeature) {
        this.faceId = faceId;
        this.name = name;
        this.faceFeature = faceFeature;
    }
    public String getFaceId() {
        return faceId;
    }

    public void setFaceId(String faceId) {
        this.faceId = faceId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getSimilarValue() {
        return similarValue;
    }

    public void setSimilarValue(Integer similarValue) {
        this.similarValue = similarValue;
    }

    public byte[] getFaceFeature() {
        return faceFeature;
    }

    public void setFaceFeature(byte[] faceFeature) {
        this.faceFeature = faceFeature;
    }

}
