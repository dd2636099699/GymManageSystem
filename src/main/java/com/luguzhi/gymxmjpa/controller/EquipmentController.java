package com.luguzhi.gymxmjpa.controller;


import com.luguzhi.gymxmjpa.dao.EquipmentDao;
import com.luguzhi.gymxmjpa.service.EquipmentDaoImpl;
import com.luguzhi.gymxmjpa.entity.Equipment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;
import java.util.Optional;

/**
 * @Description: 器材管理Controller控制层
 * @Author: luguzhi
 * @Date: 2024/4/12
 */
@Controller
@RequestMapping("/qc")
public class EquipmentController {
    @Autowired
    private EquipmentDaoImpl equipmentDao;
    @Autowired
    private EquipmentDao e;

    /**
     * @Description: 器材管理-进入器材信息界面

     */
    @RequestMapping("/yemian")
    public String yemian(){

        return "WEB-INF/jsp/CEquipment";
    }

    /**
     * 器材预约管理
     * @return
     */
    @RequestMapping("/reservejin")
    public String reservejin(){

        return "WEB-INF/jsp/reserve";
    }
    /**
     * 个人器材预约
     * @return
     */
    @RequestMapping("/reservejin2")
    public String reservejin2(){

        return "WEB-INF/jsp/personalreserve";
    }

    /**
     * @Description: 器材管理-根据器材名称分页查询

     */
    @RequestMapping("/query")
    @ResponseBody
    public Map<String,Object> query(String hyname, int pageSize, int pageNumber){
        Map<String,Object>  map1=new HashMap<String,Object>();
        map1.put("hyname",hyname);
        map1.put("qi",(pageNumber-1)*pageSize);
        map1.put("shi",pageSize);
        return equipmentDao.query(map1);
    }

    /**
     * @Description: 器材管理-添加器材

     */
    @RequestMapping("/insert")
    @ResponseBody
    public Map<String,Object> insert(Equipment equipment){
        equipmentDao.insert(equipment);
        return query("",5,1);
    }

    /**
     * @Description: 器材管理-根据器材id删除
     */
    @RequestMapping("/delete")
    @ResponseBody
    public Map<String,Object> del(int eqId){
        equipmentDao.del(eqId);
        return query("",5,1);
    }

    @PostMapping("/edit")
    public ResponseEntity<?> editEquipment(@RequestBody Equipment equipmentRequest) {
        // 根据请求中的ID查找器材
        Optional<Equipment> equipmentOptional = e.findById(equipmentRequest.getEqId());
        if (!equipmentOptional.isPresent()) {
            // 如果未找到器材，返回错误信息
            return ResponseEntity.badRequest().body("未找到ID为: " + equipmentRequest.getEqId() + "的器材信息");
        }

        // 获取要更新的器材对象
        Equipment equipmentToUpdate = equipmentOptional.get();
        // 更新器材名称和数量
        equipmentToUpdate.setEqName(equipmentRequest.getEqName());
        equipmentToUpdate.setCount(equipmentRequest.getCount()); // 假设你的实体中的字段是count
        // 保存更新
        e.save(equipmentToUpdate);

        // 返回成功信息
        return ResponseEntity.ok().body("器材信息更新成功");
    }

}
