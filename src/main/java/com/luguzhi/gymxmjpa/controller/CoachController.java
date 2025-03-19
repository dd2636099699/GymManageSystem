package com.luguzhi.gymxmjpa.controller;
import com.luguzhi.gymxmjpa.dao.CoachDao;
import com.luguzhi.gymxmjpa.dao.PrivateCoachInfoDao;
import com.luguzhi.gymxmjpa.service.CoachDaoImpl;
import com.luguzhi.gymxmjpa.entity.Coach;
import com.luguzhi.gymxmjpa.entity.PrivateCoachInfo;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.BeanWrapper;
import org.springframework.beans.BeanWrapperImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.beans.PropertyDescriptor;
import java.util.*;

/**
 * @Description: 教练管理Controller控制层
 */
@Controller
@RequestMapping("/coach")
public class CoachController {
   @Autowired
   private CoachDao coachDao;
   @Autowired
   private PrivateCoachInfoDao privateCoachInfoDao;
   @Autowired
   private CoachDaoImpl coachDaoImpl;
    @RequestMapping("/query9")
    @ResponseBody
    public ResponseEntity<List<Coach>> getCoaches() {
        List<Coach> coaches = coachDao.findAll(); // 假设有一个Service方法返回所有教练
        return ResponseEntity.ok(coaches);
    }
    /**
     * @Description: 教练管理-进入教练列表界面
     * @Author: luguzhi
     * @Date: 2024/4/9
     */
    @RequestMapping("/jin3")
    public String jin3(){

        return "WEB-INF/jsp/coach";
    }
    @RequestMapping("/jin03")
    public String jin03(){

        return "WEB-INF/jsp/personalcoach";
    }

    /**
     * @Description: 教练管理-根据教练姓名分页查询
     * @Author: luguzhi
     * @Date: 2024/4/9
     */
    @RequestMapping("/query")
    @ResponseBody
    public Map<String,Object> query(String coachname, int pageSize, int pageNumber){
        Map<String,Object>  map1=new HashMap<String,Object>();
        map1.put("coachname",coachname);
        map1.put("qi",(pageNumber-1)*pageSize);
        map1.put("shi",pageSize);
        return coachDaoImpl.query(map1);
    }
    @RequestMapping("/personalQuery")
    @ResponseBody
    public Optional<Coach> personlCoachQuery(@RequestParam Long coachId) {
      return  coachDao.findById(coachId);
    }

    /**
     * @Description: 教练管理-根据教练id删除教练信息
     * @Author: luguzhi
     * @Date: 2024/4/9
     */
    @RequestMapping("/del")
    @ResponseBody
    public  Map<String,Object> del(long id,String coachname, int pageSize, int pageNumber){

        //先根据教练id在私教信息表里查询是否有其信息
        List<PrivateCoachInfo> privateCoachInfoList = privateCoachInfoDao.queryByCoachIdNative(id);
        if(privateCoachInfoList !=null && privateCoachInfoList.size() > 0){
            //如果有,先循环删除
            for(PrivateCoachInfo privateCoachInfo : privateCoachInfoList){
                if(id == privateCoachInfo.getCoach().getCoachId()){
                    privateCoachInfoDao.delete(privateCoachInfo);
                }
            }
        }
        coachDao.deleteById(id);
        Map<String,Object>  map1=new HashMap<String,Object>();
        map1.put("coachname",coachname);
        map1.put("qi",(pageNumber-1)*pageSize);
        map1.put("shi",pageSize);
        return coachDaoImpl.query(map1);
    }

    /**
     * @Description: 教练管理-根据教练姓名计算总数据数量
     * @Author: luguzhi
     * @Date: 2024/4/9
     */
    @RequestMapping("/count")
    @ResponseBody
    public Long count (String coachName){
        coachDaoImpl.count(coachName);
        return  coachDaoImpl.count(coachName);
    }

    /**
     * @Description: 教练管理-添加新教练
     * @Author: luguzhi
     * @Date: 2024/4/9
     */
    @RequestMapping("/add")
    @ResponseBody
    public  void save(Coach coach){
        coachDao.save(coach);
    }

    /**
     * @Description: 教练管理-根据教练id查询
     * @Author: luguzhi
     * @Date: 2024/4/9
     */
    @RequestMapping("/cha")
    @ResponseBody
    public Optional<Coach> one(long id){
        return coachDao.findById(id);
    }

    /**
     * @Description: 教练管理-修改教练信息
     * @Author: luguzhi
     * @Date: 2024/4/9
     */
    @RequestMapping("/upd")
    @ResponseBody
    public ResponseEntity<?> upd(Coach updatedCoach) {

        Optional<Coach> existingCoachOptional = coachDao.findById(updatedCoach.getCoachId());
        if(!existingCoachOptional.isPresent()) {
            return ResponseEntity.notFound().build();
        }
        Coach existingCoach = existingCoachOptional.get();

        // 复制非空属性
        copyNonNullProperties(updatedCoach, existingCoach);
        coachDao.save(existingCoach);

        return ResponseEntity.ok("Coach updated successfully");
    }

    private void copyNonNullProperties(Object src, Object target) {
        BeanUtils.copyProperties(src, target, getNullPropertyNames(src));
    }

    private String[] getNullPropertyNames(Object source) {
        final BeanWrapper src = new BeanWrapperImpl(source);
        PropertyDescriptor[] pds = src.getPropertyDescriptors();

        Set<String> emptyNames = new HashSet<String>();
        for(PropertyDescriptor pd : pds) {
            Object srcValue = src.getPropertyValue(pd.getName());
            if (srcValue == null) emptyNames.add(pd.getName());
        }
        String[] result = new String[emptyNames.size()];
        return emptyNames.toArray(result);
    }


}
