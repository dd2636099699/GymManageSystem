package com.luguzhi.gymxmjpa.controller;



import com.luguzhi.gymxmjpa.dao.*;
import com.luguzhi.gymxmjpa.dto.MemberUpdateDTO;
import com.luguzhi.gymxmjpa.entity.*;
import com.luguzhi.gymxmjpa.service.MenberDaoImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.transaction.Transactional;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @Description: 会员管理Controller控制层
 * @Author: luguzhi
 * @Date: 2024/4/6
 */
@Controller
@RequestMapping("/menber")
public class MenberConntroller {

    @Autowired
    private  chongzhiDao chongzhiDao;
    @Autowired
    private CourseSaleDao courseSaleDao;
    @Autowired
    private CourseScheduleDao courseScheduleDao;
    @Autowired
    private MenberDao menberDao;
    @Autowired
    private memberDao memberDao;
    @Autowired
    private MenberDaoImpl menberDaoiImpl;
    @Autowired
    private RenewalRecordDao  renewalRecordDao;
    @RequestMapping("/jin0")
    public String jin0(){
        return  "WEB-INF/jsp/face_search";
    }
    @RequestMapping("/personalInfojin1")
    public String personalInfojin(){
        return  "WEB-INF/jsp/personalnfo";
    }

         /** 会员个人信息查询
     * @param
     * @param
     * @return
             */
         @PostMapping("/personalnfoQuery")
         public ResponseEntity<?> getPersonalInfo(@RequestParam("memberId") Long memberId) {
             Optional<Member> memberOptional = menberDao.findById(memberId);
             if (memberOptional.isPresent()) {
                 Member member = memberOptional.get();
                 // 封装为BootstrapTable期望的格式
                 Map<String, Object> response = new HashMap<>();
                 response.put("total", 1); // 总数为1
                 response.put("rows", Collections.singletonList(member)); // 将单个member封装为列表
                 return ResponseEntity.ok(response);
             } else {
                 Map<String, Object> response = new HashMap<>();
                 response.put("total", 0);
                 response.put("rows", Collections.emptyList());
                 return ResponseEntity.ok(response);
             }
         }



    /**
     * @Description: 会员管理-进入会员到期界面

     */
    @RequestMapping("/jin2")
    public String jin2(){
        return "WEB-INF/jsp/HYMemberDaoQi";
    }

    /**
     * @Description: 会员管理-进入会员续费充值界面

     */
    @RequestMapping("/jin3")
    public String jin3(){
        return "WEB-INF/jsp/HYMemberChongZhi";
    }

    /**
     * @Description: 会员管理-进入会员余额充值界
     */
    @RequestMapping("/jin11")
    public String jin11(){
        return "WEB-INF/jsp/HYMemberyeChongZhi";
    }

    /**
     * @Description: 会员管理-进入会员列表界面

     */
    @RequestMapping("/jin")
    public String jin(){
        System.out.println(1);
        return "WEB-INF/jsp/HYMember";
    }

    /**
     * @Description: 教练管理-进入会员私教详情界面

     */
    @RequestMapping("/jin4")
    public String jin4(){

        return "WEB-INF/jsp/privatecoachinfo";
    }

    /**
     * @Description: 会员列表-分页查询
     */
    @RequestMapping("/query")
    @ResponseBody
    public Map<String,Object> query(int ktype,String hyname, int pageSize, int pageNumber,int sortById){
        Map<String,Object>  map1=new HashMap<String,Object>();
        map1.put("hyname",hyname);
        map1.put("ktype",ktype);
        map1.put("qi",(pageNumber-1)*pageSize);
        map1.put("shi",pageSize);
        Map<String, Object> query = menberDaoiImpl.query(map1,sortById);
        return query;
    }
    @RequestMapping("/query8")
    @ResponseBody
    public Map<String, Object> query8(Long memberId) {
        Map<String, Object> result = new HashMap<>();
        List<Member> members = new ArrayList<>();
        menberDao.findById(memberId).ifPresent(members::add); // 如果存在，添加到列表中
        result.put("rows", members); // 即使是单条数据，也用列表包装，以符合Bootstrap Table的数据格式
        result.put("total", members.size()); // 总记录数
        return result;
    }
    /**
     * @Description: 会员到期-分页查询

     */
    @RequestMapping("/query2")
    @ResponseBody
    public Map<String,Object> query2(int ktype,String hyname, int pageSize, int pageNumber){
        Map<String,Object>  map1=new HashMap<String,Object>();
        map1.put("hyname",hyname);
        map1.put("ktype",ktype);
        map1.put("qi",(pageNumber-1)*pageSize);
        map1.put("shi",pageSize);
        return menberDaoiImpl.query2(map1);
    }

    /**
     * @Description: 会员续卡-根据会员id查询会员信息

     */
    @RequestMapping("/cha")
    @ResponseBody
    public Member query2(int id){

        return menberDaoiImpl.cha(id);
    }

    /**
     * @Description: 会员管理-根据会员id删除

     */
    @RequestMapping("/delete")
    @ResponseBody
    public Map<String,Object> del(int memid){

        menberDaoiImpl.del(memid);
        return query(0,"",5,1,0);
    }

    /**
     * @Description: 会员管理-添加新会员

     */
    @RequestMapping("/insert")
    @ResponseBody
    public Map<String,Object> insert(Member member){
        menberDaoiImpl.insert(member);
        return query(0,"",5,1,0);
    }

    /**
     * @Description: 会员管理-修改会员信息

     */
    @PostMapping("/update")
    public ResponseEntity<?> updateMember(@RequestBody MemberUpdateDTO memberUpdateDTO) {
        int result = menberDaoiImpl.updateMember(memberUpdateDTO);
        if (result == 1) {
            return ResponseEntity.ok().body("修改成功");
        } else {
            return ResponseEntity.status(HttpStatus.NOT_FOUND).body("会员不存在");
        }
    }
    /**
     * 续卡操作
     * @return
     * 更新续卡记录  会员id 续卡类型 原来余额 现在余额
     * 更新会员表 到期时间 余额 卡类型
     */
    @RequestMapping("/xuka")
    @ResponseBody
    public  Map<String, Object> xuka(RenewalRecord renewalRecord,String daoqi){
        renewalRecordDao.save(renewalRecord);
        float newBalance = renewalRecord.getNewBalance();//新余额
        Member member=menberDao.findById(renewalRecord.getMember().getMemberId()).get();
        Membertype membertype=new Membertype();
        membertype.setTypeId(renewalRecord.getMembertype().getTypeId());
        member.setMemberId(renewalRecord.getMember().getMemberId());
        member.setMemberStatic(1L);
        member.setMembertypes(membertype);
        member.setMemberbalance(newBalance);

        java.sql.Date date=java.sql.Date.valueOf(daoqi);

        member.setMemberxufei(date);
        menberDao.save(member);
        Map<String, Object> query = query(0, null, 5, 1,0);
        System.out.println("2");
        return query;
    }
    /**
     * @Description: 会员卡续费-添加会员卡续费记录

     */
    @RequestMapping("/ins")
    @ResponseBody
    public Map<String, Object> insert(Chongzhi chongzhi, String daoqi){
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        java.sql.Timestamp dat=java.sql.Timestamp.valueOf(df.format(new Date()));

        chongzhi.setDate(dat);
        chongzhiDao.save(chongzhi);
        Membertype membertype=new Membertype();


        Member member=menberDao.findById(chongzhi.getMember().getMemberId()).get();
        member.setMemberId(chongzhi.getMember().getMemberId());
        member.setMemberStatic(1L);
        member.setMembertypes(membertype);

        java.sql.Date date=java.sql.Date.valueOf(daoqi);

        member.setMemberxufei(date);
        menberDao.save(member);

        return query(0,null,5,1,0);
    }

    /**
     * 个人查询
     * @param memberId
     * @return
     */
    @PostMapping("/personalquery")
    public ResponseEntity<?> personalQuery(@RequestParam("memberId") Long memberId) {
        return menberDao.findById(memberId)
                .map(ResponseEntity::ok) // 如果找到了，直接返回Member对象，Spring会将其转换为JSON
                .orElseGet(() -> ResponseEntity.badRequest().body((Member) Collections.singletonMap("error", "Member not found"))); // 如果未找到，返回一个包含错误信息的JSON对象
    }

    /**
     * 统计人数
     * @return
     */
    @GetMapping("/count")
    @ResponseBody
    public Map<String, Object> getMemberStatistics() {
        Map<String, Object> stats = new HashMap<>();
        stats.put("totalMembers", memberDao.count());
        stats.put("expiredMembers", memberDao.countByExpirationDateBefore());
        return stats;
    }
    @PostMapping("/personalpurchase")
    @Transactional
    public ResponseEntity<?> personalPurchase(@RequestParam("memberId") Long memberId, @RequestParam("scheduleId") Integer scheduleId) {
        // 获取Member实体
        Member member = memberDao.findById(memberId).orElse(null);
        if (member == null) {
            return ResponseEntity.badRequest().body("Member not found");
        }

        // 获取CourseSchedule实体
        CourseSchedule courseSchedule = courseScheduleDao.findById(scheduleId).orElse(null);
        if (courseSchedule == null) {
            return ResponseEntity.badRequest().body("Schedule not found");
        }

        // 获取sellingPrice并更新member的balance
        double sellingPrice = courseSchedule.getSubject().getSellingPrice();
        double newBalance = member.getMemberbalance() - sellingPrice; // 假设Member类中有getMemberbalance和setMemberbalance方法
        if (newBalance < 0) {
            return ResponseEntity.badRequest().body("Insufficient balance");
        }
        member.setMemberbalance((float) newBalance);
        memberDao.save(member);

        // 创建新的CourseSale记录
        CourseSale courseSale = new CourseSale();
        courseSale.setMember(member);
        courseSale.setCourseSchedule(courseSchedule);
        courseSale.setPurchaseDate(new Date()); // 设置购买日期为当前日期
        courseSaleDao.save(courseSale);

        // 更新CourseSchedule的purchaseCount
        int newPurchaseCount = courseSchedule.getPurchaseCount() + 1;
        courseSchedule.setPurchaseCount(newPurchaseCount);
        courseScheduleDao.save(courseSchedule);

        return ResponseEntity.ok("Purchase successful");
    }}
