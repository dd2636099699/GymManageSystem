package com.luguzhi.gymxmjpa.controller;

import com.luguzhi.gymxmjpa.dao.CoachDao;
import com.luguzhi.gymxmjpa.dao.CourseScheduleDao;
import com.luguzhi.gymxmjpa.dao.SubjectDao;
import com.luguzhi.gymxmjpa.entity.Classroom;
import com.luguzhi.gymxmjpa.entity.Coach;
import com.luguzhi.gymxmjpa.entity.CourseSchedule;
import com.luguzhi.gymxmjpa.entity.Subject;
import com.luguzhi.gymxmjpa.service.CourseScheduleDaoImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.persistence.EntityNotFoundException;
import javax.transaction.Transactional;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Controller
@RequestMapping("/courseSchedule")

public class CourseScheduleController {
    @Autowired
    private CourseScheduleDaoImpl courseScheduleDaoImpl;
    @Autowired
    private  CourseScheduleDao courseScheduleDao;
    @Autowired
    private CoachDao coachDao;
    @Autowired
    private com.luguzhi.gymxmjpa.dao.classRoomDao classRoomDao;
    @Autowired
    private SubjectDao subjectDao;
    @RequestMapping("/jin1")
    public String jin1(){
        return "WEB-INF/jsp/course_schedule";
    }
    @RequestMapping("/jin01")
    public String jin01(){
        return "WEB-INF/jsp/CoachCourse_schedule";
    }
    @RequestMapping("/personalpurchaseCoursejin")
    public String personalpurchaseCoursejin(){
        return "WEB-INF/jsp/personalpurchaseCourse";
    }

    /**
     * 教练管理员课程安排
     * @param pageNumber
     * @param pageSize
     * @param coachId
     * @return
     */
    @RequestMapping("/query")
    public ResponseEntity<?> queryCourseSchedules(Integer pageNumber, Integer pageSize, Long coachId) {
        Map<String,Object> map1 = new HashMap<String,Object>();
        map1.put("qi", (pageNumber-1) * pageSize);
        map1.put("shi", pageSize);
        // 将教练ID加入到查询参数中
        map1.put("coachId", coachId);

        Map<String, Object> query = courseScheduleDaoImpl.query(map1);
        return ResponseEntity.ok(query);
    }

    /**
     * 会员课程购买
     * @param pageNumber
     * @param pageSize
     * @return
     */
    @RequestMapping("/query7")
    public ResponseEntity<?> queryCourseSchedules7(Integer pageNumber, Integer pageSize) {
        Map<String,Object>  map1=new HashMap<String,Object>();
        map1.put("qi",(pageNumber-1)*pageSize);
        map1.put("shi",pageSize);
        Map<String, Object> query = courseScheduleDaoImpl.query7(map1);
        return ResponseEntity.ok(query);
    }
    @PostMapping("/update")
    public ResponseEntity<Map<String, Object>> updateCourseSchedule(
            @RequestParam Integer scheduleId,
            @RequestParam Long coachId,
            @RequestParam Long subjectId,
            @RequestParam Integer classroomId,
            @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss") Date startTime,
            @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss") Date endTime,
            @RequestParam Integer courseStatus) {

        Map<String, Object> response = new HashMap<>();

        // 创建或获取CourseSchedule实例
        CourseSchedule schedule = courseScheduleDao.findById(scheduleId)
                .orElse(new CourseSchedule()); // 或处理找不到实例的情况

        // 设置实体关联
        schedule.setCoach(coachDao.findById(coachId).orElseThrow(() -> new RuntimeException("Coach not found")));
        schedule.setSubject(subjectDao.findById(subjectId).orElseThrow(() -> new RuntimeException("Subject not found")));
        schedule.setClassroom(classRoomDao.findById(classroomId).orElseThrow(() -> new RuntimeException("Classroom not found")));

        // 设置其他属性
        schedule.setStartTime(startTime);
        schedule.setEndTime(endTime);
        schedule.setCourseStatus(courseStatus);

        // 检查时间段是否存在
        boolean exists = courseScheduleDaoImpl.checkScheduleExists(startTime, endTime, scheduleId,classroomId);
        if (exists) {
            response.put("success", false);
            response.put("message", "编辑的时间段已存在，请选择其他时间段。");
            return ResponseEntity.badRequest().body(response);
        }

        // 更新课程安排
        boolean updateSuccess = courseScheduleDaoImpl.updateSchedule(schedule);
        if (updateSuccess) {
            response.put("success", true);
            response.put("message", "课程安排更新成功！");
            return ResponseEntity.ok(response);
        } else {
            response.put("success", false);
            response.put("message", "更新课程安排失败，请稍后再试。");
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
        }
    }
    @PostMapping("/delete")
    public ResponseEntity<?> deleteCourseSchedule(@RequestParam("classroomId") Integer classroomId) {
        try {
            courseScheduleDao.deleteById(classroomId);
            Map<String, Object> response = new HashMap<>();
            response.put("success", true);
            response.put("message", "删除成功");
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            Map<String, Object> response = new HashMap<>();
            response.put("success", false);
            response.put("message", "删除失败: " + e.getMessage());
            return ResponseEntity.badRequest().body(response);
        }
    }
    @PostMapping("/add")
    @Transactional
    public ResponseEntity<?> saveCourseSchedule(@RequestBody Map<String, String> formData) {
        Map<String, Object> response = new HashMap<>();
        try {
            CourseSchedule courseSchedule = new CourseSchedule();

            // 转换 startTime 和 endTime 为 Date 对象
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            Date startTime = dateFormat.parse(formData.get("startTime"));
            Date endTime = dateFormat.parse(formData.get("endTime"));

            // 查找对应的实体对象
            Coach coach = coachDao.findById(Long.parseLong(formData.get("coachId"))).orElseThrow(() -> new EntityNotFoundException("Coach not found with id: " + formData.get("coachId")));
            Subject subject = subjectDao.findById(Long.parseLong(formData.get("subjectId"))).orElseThrow(() -> new EntityNotFoundException("Subject not found with id: " + formData.get("subjectId")));;
            Classroom classroom = classRoomDao.findById(Integer.parseInt(formData.get("classroomId"))).orElseThrow(() -> new EntityNotFoundException("Classroom not found with id: " + formData.get("classroomId")));
            // 设置到 courseSchedule 实体
            courseSchedule.setCoach(coach);
            courseSchedule.setSubject(subject);
            courseSchedule.setClassroom(classroom);
            courseSchedule.setStartTime(startTime);
            courseSchedule.setEndTime(endTime);
            courseSchedule.setCourseStatus(1);
            courseSchedule.setPurchaseCount(0);

            // 检查时间段是否已经存在
            boolean exists = courseScheduleDaoImpl.existsByTimeOverlap(startTime, endTime,classroom);
            if (exists) {

                response.put("success", false);
                response.put("message", "该教室在该时间段已经有课程安排，请重新选择！");
                return ResponseEntity.badRequest().body(response);
            }
            // 保存 courseSchedule 实体
            courseScheduleDao.save(courseSchedule);


            response.put("success", true);
            response.put("message", "添加成功");
            return ResponseEntity.ok(response);
        } catch (Exception e) {

            response.put("success", false);
            response.put("message", "添加失败: " + e.getMessage());
            return ResponseEntity.badRequest().body(response);
        }
    }


}
