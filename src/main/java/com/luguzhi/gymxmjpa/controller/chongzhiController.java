package com.luguzhi.gymxmjpa.controller;


import com.alibaba.druid.util.StringUtils;
import com.luguzhi.gymxmjpa.dao.MenberDao;
import com.luguzhi.gymxmjpa.dao.RenewalRecordDao;
import com.luguzhi.gymxmjpa.dao.chongzhiDao;
import com.luguzhi.gymxmjpa.entity.RenewalRecord;
import com.luguzhi.gymxmjpa.service.MenberDaoImpl;
import com.luguzhi.gymxmjpa.entity.Chongzhi;
import com.luguzhi.gymxmjpa.entity.Member;
import com.luguzhi.gymxmjpa.service.StatisticsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;

import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.persistence.criteria.Predicate;
import javax.servlet.http.HttpSession;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @Description: 会员充值管理Controller控制层
 */
@Controller
@RequestMapping("/cz")
public class chongzhiController {

    @Autowired
    private chongzhiDao chongzhiDao;

    @Autowired
    private MenberDao menberDao;

    @Autowired
    private MenberDaoImpl menberDaoImpl;
    @Autowired
    private RenewalRecordDao renewalRecordDao;
    @Autowired
    private  StatisticsService statisticsService;
    @PersistenceContext
    private EntityManager entityManager;


    /**
     * @Description: 会员充值管理-进入会员充值记录界面
     */
    @RequestMapping("/jin")
    public String jin(){
        return "WEB-INF/jsp/HYMemberjilu";
    }
    @RequestMapping("/personaljin")
    public String personaljin(){
        return "WEB-INF/jsp/personalMemberjilu1";
    }
    @RequestMapping("/chongzhiandxukajin")
    public String chongzhiandxukajin(){
        return "WEB-INF/jsp/personalchongzhiandxuka";
    }
    /**
     * @Description: 信息统计-进入收入统计界面
     */
    @RequestMapping("/jin2")
    public String jin2(){
        return "WEB-INF/jsp/ShouRuTongji";
    }
    @RequestMapping("/xuka")
    public String xuka(){
        return "WEB-INF/jsp/HYMemberjilu2";
    }
    @RequestMapping("/personalxuka")
    public String personalxuka(){
        return "WEB-INF/jsp/personalMemberjilu2";
    }

    /**
     * @Description: 会员余额充值
     */
    @RequestMapping("/xin")
    @ResponseBody
    public Map<String,Object> cye(Chongzhi chongzhi){

        //充值money
        Member member=menberDao.findById(chongzhi.getMember().getMemberId()).get();
        member.setMemberbalance(chongzhi.getNewMoney());
        menberDao.save(member);

        //添加充值记录
        SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        java.sql.Timestamp dat=java.sql.Timestamp.valueOf(df.format(new Date()));
        chongzhi.setDate(dat);
        chongzhiDao.save(chongzhi);
        Map<String,Object>  map1=new HashMap<String,Object>();
        map1.put("hyname",null);
        map1.put("ktype",0);
        map1.put("qi",1);
        map1.put("shi",5);
       return menberDaoImpl.query(map1,0);
   }
    @RequestMapping("/xukaquery")
    @ResponseBody
    public Map<String, Object> xukaquery(
            int pageSize,
            int pageNumber,
            String xdate,
            String ddate,
            String memberName) {

        // 定义以续卡时间降序排序
        Sort sort = Sort.by(Sort.Direction.DESC, "renewalTime");
        Pageable pageable = PageRequest.of(pageNumber - 1, pageSize, sort);

        Specification<RenewalRecord> specification = (root, query, cb) -> {
            List<Predicate> predicates = new ArrayList<>();

            // 根据日期范围添加查询条件
            if (!StringUtils.isEmpty(xdate) && !StringUtils.isEmpty(ddate)) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                try {
                    Date startDate = sdf.parse(xdate);
                    Date endDate = sdf.parse(ddate);

                    Calendar cal = Calendar.getInstance();
                    cal.setTime(endDate);
                    cal.add(Calendar.DATE, 1); // 将结束日期增加一天
                    endDate = cal.getTime();

                    Calendar cal1 = Calendar.getInstance();
                    cal1.setTime(startDate);
                    cal1.add(Calendar.DATE, -1); // 将开始日期减少一天
                    startDate = cal1.getTime();

                    predicates.add(cb.between(root.get("renewalTime"), startDate, endDate));
                } catch (ParseException e) {
                    e.printStackTrace();
                }
            }

            // 根据会员名字添加查询条件
            if (!StringUtils.isEmpty(memberName)) {
                // 注意这里假设你的Member实体中有一个名为"memberName"的属性
                predicates.add(cb.like(root.get("member").get("memberName"), "%" + memberName + "%"));
            }

            query.orderBy(cb.desc(root.get("renewalTime"))); // 指定按续卡时间降序排序

            return cb.and(predicates.toArray(new Predicate[0]));
        };

        // 假设你的续卡记录DAO是renewalRecordDao
        Page<RenewalRecord> page = renewalRecordDao.findAll(specification, pageable);
        Map<String, Object> result = new HashMap<>();
        result.put("total", page.getTotalElements());
        result.put("rows", page.getContent());
        return result;
    }
    @RequestMapping("/personalxukaquery")
    @ResponseBody
    public Map<String, Object> personalxukaquery(
            int pageSize,
            int pageNumber,
            String xdate,
            String ddate,
            HttpSession httpSession) {

        // 从会话中获取当前登录的会员信息
        Member member = (Member) httpSession.getAttribute("user");
        if (member == null) {
            // 如果会员信息为空，可以根据实际情况进行处理，比如返回错误信息或者默认值
            Map<String, Object> errorResult = new HashMap<>();
            errorResult.put("error", "会员信息未找到");
            return errorResult;
        }

        // 定义以续卡时间降序排序
        Sort sort = Sort.by(Sort.Direction.DESC, "renewalTime");
        Pageable pageable = PageRequest.of(pageNumber - 1, pageSize, sort);

        Specification<RenewalRecord> specification = (root, query, cb) -> {
            List<Predicate> predicates = new ArrayList<>();

            // 根据会员ID添加查询条件
            predicates.add(cb.equal(root.get("member").get("memberId"), member.getMemberId()));

            query.orderBy(cb.desc(root.get("renewalTime"))); // 指定按续卡时间降序排序

            return cb.and(predicates.toArray(new Predicate[0]));
        };

        // 假设你的续卡记录DAO是renewalRecordDao
        Page<RenewalRecord> page = renewalRecordDao.findAll(specification, pageable);
        Map<String, Object> result = new HashMap<>();
        result.put("total", page.getTotalElements());
        result.put("rows", page.getContent());
        return result;
    }
    /**
     * @Description: 充值记录-根据所选日期分页查询数据记录
     */
    @RequestMapping("/query")
    @ResponseBody
    public Map<String, Object> query(
            int pageSize,
            int pageNumber,
            String xdate,
            String ddate,
            String memberName) {

        // 定义以日期降序排序
        Sort sort = Sort.by(Sort.Direction.DESC, "date");
        Pageable pageable = PageRequest.of(pageNumber - 1, pageSize, sort);

        Specification<Chongzhi> specification = (root, query, cb) -> {
            List<Predicate> predicates = new ArrayList<>();

            // 根据日期范围添加查询条件
            if (!StringUtils.isEmpty(xdate) && !StringUtils.isEmpty(ddate)) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                try {
                    Date startDate = sdf.parse(xdate);
                    Date endDate = sdf.parse(ddate);

                    // 创建Calendar对象，并设置为endDate
                    Calendar cal = Calendar.getInstance();
                    cal.setTime(endDate);
                    // 将结束日期增加一天
                    cal.add(Calendar.DATE, 1);
                    endDate = cal.getTime();

                    // 创建Calendar对象，并设置为startDate
                    Calendar cal1 = Calendar.getInstance();
                    cal1.setTime(startDate);
                    // 将开始日期减少一天
                    cal1.add(Calendar.DATE, -1);
                    startDate = cal1.getTime();
                    // 现在endDate为2024-03-01，可以包含2024-02-29当天的所有数据
                    predicates.add(cb.between(root.get("date"), startDate, endDate));
                } catch (ParseException e) {
                    e.printStackTrace();
                }
            }

            // 根据会员名字添加查询条件
            if (!StringUtils.isEmpty(memberName)) {
                predicates.add(cb.like(root.get("member").get("memberName"), "%" + memberName + "%"));
            }

            query.orderBy(cb.desc(root.get("date"))); // 也可以在这里指定排序

            return cb.and(predicates.toArray(new Predicate[0]));
        };

        Page<Chongzhi> page = chongzhiDao.findAll(specification, pageable);
        Map<String, Object> result = new HashMap<>();
        result.put("total", page.getTotalElements());
        result.put("rows", page.getContent());
        return result;
    }
    @RequestMapping("/personalquery")
    @ResponseBody
    public Map<String, Object> personalquery(
            int pageSize,
            int pageNumber,
            String xdate,
            String ddate,
            String memberName,
            HttpSession httpSession) {

        Member member = (Member) httpSession.getAttribute("user");
        long memberId = member.getMemberId();

        // 定义以日期降序排序
        Sort sort = Sort.by(Sort.Direction.DESC, "date");
        Pageable pageable = PageRequest.of(pageNumber - 1, pageSize, sort);

        Specification<Chongzhi> specification = (root, query, cb) -> {
            List<Predicate> predicates = new ArrayList<>();

            // 根据会员ID添加查询条件
            predicates.add(cb.equal(root.get("member").get("memberId"), memberId));

            query.orderBy(cb.desc(root.get("date"))); // 也可以在这里指定排序

            return cb.and(predicates.toArray(new Predicate[0]));
        };

        Page<Chongzhi> page = chongzhiDao.findAll(specification, pageable);
        Map<String, Object> result = new HashMap<>();
        result.put("total", page.getTotalElements());
        result.put("rows", page.getContent());
        return result;
    }





    /**
     * @Description: 信息统计-进入收入统计界面
     * @Author: luguzhi
     * @Date: 2024/4/25
     */
    @RequestMapping("/tongji")
    @ResponseBody
    public int[] TOngji(){
        String[] array= new String[]{"2023-01", "2023-02", "2023-03", "2023-04", "2023-05", "2023-06", "2023-07", "2023-08", "2023-09", "2023-10", "2023-11", "2023-12"};
        int[] intar=new int[12];
        for (int i=0;i<array.length;i++){
            String jpa= String.format("select sum(a.money) from Chongzhi as a where Date like('%%%s%%')", array[i]);
            Query query=entityManager.createQuery(jpa);
            Object obj = query.getSingleResult();
            if(obj==null){
            	intar[i]=0;
            }else{
            	intar[i]=((Long)obj).intValue();
            }
        }
        return intar;
   }
    @PostMapping("/tongjiByYear")
    public ResponseEntity<Map<String, Object>> getIncomeAndExpenditureByYear(@RequestParam("year") int year) {
        Map<String, Object> statistics = statisticsService.getMonthlyNetIncomeByYear(year);
        return ResponseEntity.ok(statistics);
    }
    @GetMapping("/years")
    public ResponseEntity<List<Integer>> getYears() {
        List<Integer> years =chongzhiDao.findDistinctYears();
        return ResponseEntity.ok(years);
    }
}
