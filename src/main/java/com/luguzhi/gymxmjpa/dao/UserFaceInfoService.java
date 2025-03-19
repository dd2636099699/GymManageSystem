package com.luguzhi.gymxmjpa.dao;

import com.luguzhi.gymxmjpa.dto.FaceUserInfo;
import com.luguzhi.gymxmjpa.entity.UserFaceInfo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.util.List;


public interface UserFaceInfoService extends JpaRepository<UserFaceInfo, Integer> {
//    @Query("SELECT new com.luguzhi.gymxmjpa.entity.SignInRecord(u.memberName, u.signInTime) FROM  SignInRecord u")
//    List<SignInRecord> findUserFaceInfoList();
    @Query("SELECT new com.luguzhi.gymxmjpa.dto.FaceUserInfo(u.faceId, u.name, u.faceFeature) FROM UserFaceInfo u WHERE u.groupId = :groupId")
    List<FaceUserInfo> getUserFaceInfoByGroupId(@Param("groupId") Integer groupId);


}