package com.luguzhi.gymxmjpa.controller;

import com.luguzhi.gymxmjpa.dao.classRoomDao;
import com.luguzhi.gymxmjpa.entity.Classroom;
import com.luguzhi.gymxmjpa.service.ClassRoomImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/classRoom")
public class classRoomConntroller {
    @Autowired
    private classRoomDao classRoomDao1;
    @Autowired
    private ClassRoomImpl c;
    @RequestMapping("/query9")
    @ResponseBody
    public ResponseEntity<List<Classroom>> getClassrooms() {
        List<Classroom> classrooms = classRoomDao1.findAll(); // 假设有一个Service方法返回所有教室
        return ResponseEntity.ok(classrooms);
    }

    /**
     * 教室列表
     * @return
     */
    @RequestMapping("/jin1")
    public String jin1(){
        return "WEB-INF/jsp/classRoom";
    }
    @RequestMapping("/query")
    @ResponseBody
    public Map<String,Object> query(String subname, int pageSize, int pageNumber){
        //subname为教室名称
        Map<String,Object>  map1=new HashMap<String,Object>();
        map1.put("subname",subname);
        map1.put("qi",(pageNumber-1)*pageSize);
        map1.put("shi",pageSize);
        Map<String, Object> query = c.query(map1);
        return query;
    }
    /**
     * 检查教室名称是否存在
     * @param classroomName 教室名称
     * @return ResponseEntity
     */
    @RequestMapping("/checkName")
    @ResponseBody
    public ResponseEntity<?> checkClassroomName(String classroomName) {
        boolean exists = classRoomDao1.existsByClassroomName(classroomName);
        Map<String, Boolean> response = new HashMap<>();
        response.put("available", !exists);
        return ResponseEntity.ok(response);
    }

    /**
     * 添加新教室
     * @param classroom 教室信息
     * @return ResponseEntity
     */
    @PostMapping("/add")
    @ResponseBody
    public ResponseEntity<?> addClassroom( Classroom classroom) {
        if(classRoomDao1.existsByClassroomName(classroom.getClassroomName())) {
            return ResponseEntity.badRequest().body("Classroom name already exists.");
        }
        Classroom savedClassroom = classRoomDao1.save(classroom);
        return ResponseEntity.ok(savedClassroom);
    }
    @PostMapping("/update")
    public ResponseEntity<?> updateClassroom(String classroomName, Integer capacity, String location,Integer id) {
        // 调用服务层的方法来更新教室信息
        classRoomDao1.updateClassroom(classroomName,capacity,location,id);

        // 创建并返回一个包含成功消息的ResponseEntity对象
        Map<String, Object> responseBody = new HashMap<>();
        responseBody.put("message", "教室信息更新成功");
        return ResponseEntity.ok(responseBody); // 使用ok()构建状态码为200的响应，并设置响应体

    }
    @PostMapping("/delete") // 处理删除请求的URL
    public ResponseEntity<?> deleteClassroom(@RequestParam("classroomId") Integer classroomId) {
        // 创建并返回一个包含成功消息的ResponseEntity对象
        Map<String, Object> response = new HashMap<>();
        try {
            classRoomDao1.deleteById(classroomId); // 使用Spring Data JPA提供的deleteById方法删除教室
            response.put("message", "教室信息更新成功");
            response.put("success", true);
        } catch (Exception e) {
            response.put("message", "教室删除失败: " );
            response.put("success", false);
        }
        return ResponseEntity.ok(response); // 使用ok()构建状态码为200的响应，并设置响应体
    }
}
