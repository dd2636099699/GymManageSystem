package com.luguzhi.gymxmjpa.controller;

import com.luguzhi.gymxmjpa.dao.SignInRecordDao;
import com.luguzhi.gymxmjpa.dao.memberDao;
import com.luguzhi.gymxmjpa.entity.Member;
import com.luguzhi.gymxmjpa.entity.SignInRecord;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.*;
import java.util.stream.Collectors;


@RestController
public class UserListController {

    @Autowired
    SignInRecordDao signInRecordDao;
    @Autowired
    memberDao memberDao1;

    // 使用@GetMapping注解定义这是一个处理GET请求的方法，请求路径为"/userInfo"
    @GetMapping("/userInfo")
    public ResponseEntity<Map<String, Object>> getUserInfo() {
        // 从数据库中获取所有会员信息
        List<Member> allMembers = memberDao1.findAll();

        // 从数据库中获取当天所有已签到的记录
        List<SignInRecord> signedInRecordsToday = signInRecordDao.findLatestSignInRecordsForToday();

        // 已签到记录中的会员名字提取出来，存储在一个Set集合中，以便快速查找
        Set<String> signedInMemberNames = signedInRecordsToday.stream()
                .map(SignInRecord::getMemberName)
                .collect(Collectors.toSet());

        // 已到会员记录列表
        List<SignInRecord> arrivedRecords = new ArrayList<>(signedInRecordsToday);

        // 创建一个列表用于存储未到的会员名字
        List<String> absentMemberNames = new ArrayList<>();

        // 遍历所有会员，如果会员名字不在已签到名单中，则认为未到
        for (Member member : allMembers) {
            if (!signedInMemberNames.contains(member.getMemberName())) {
                absentMemberNames.add(member.getMemberName());
            }
        }

        // 创建响应对象，包含已到会员记录列表和未到会员名字列表
        Map<String, Object> response = new HashMap<>();
        response.put("arrivedList", arrivedRecords); // 注意这里现在放的是SignInRecord列表
        response.put("absentList", absentMemberNames); // 未到会员只有名字

        // 将响应对象包装在ResponseEntity中并返回，状态码为200 OK
        return ResponseEntity.ok(response);
    }


}
