package com.luguzhi.gymxmjpa.service;

import com.luguzhi.gymxmjpa.entity.Classroom;
import com.luguzhi.gymxmjpa.entity.CourseSchedule;
import org.springframework.stereotype.Service;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.transaction.Transactional;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class CourseScheduleDaoImpl {
    @PersistenceContext
    private EntityManager entityManager;
    @Transactional
    public Map<String, Object> query(Map<String, Object> params) {
        // 更新课程状态
        updateCourseStatus();
        int qi = (int) params.get("qi");
        int shi = (int) params.get("shi");
        Long coachId = (Long) params.get("coachId"); // 修正为Long类型，以匹配控制层传入的类型

        // 构建基础查询语句
        String baseJpql = "SELECT cs FROM CourseSchedule cs";
        String countBaseJpql = "SELECT COUNT(cs) FROM CourseSchedule cs";

        // 如果coachId不为null，添加教练ID的过滤条件
        if (coachId != null) {
            baseJpql += " WHERE cs.coach.coachId = :coachId";
            countBaseJpql += " WHERE cs.coach.coachId = :coachId";
        }

        // 添加排序
        baseJpql += " ORDER BY cs.scheduleId DESC";

        // 创建查询
        Query query = entityManager.createQuery(baseJpql);
        Query countQuery = entityManager.createQuery(countBaseJpql);

        // 如果coachId不为null，为查询设置coachId参数
        if (coachId != null) {
            query.setParameter("coachId", coachId);
            countQuery.setParameter("coachId", coachId);
        }

        // 设置分页参数
        query.setFirstResult(qi);
        query.setMaxResults(shi);

        // 执行查询获取结果列表
        List<?> resultList = query.getResultList();

        // 执行计数查询获取总数
        long total = (long) countQuery.getSingleResult();

        // 构造返回结果
        Map<String, Object> result = new HashMap<>();
        result.put("rows", resultList);
        result.put("total", total);

        return result;
    }
    @Transactional
    public Map<String, Object> query7(Map<String, Object> params) {
        // 更新课程状态
        updateCourseStatus();
        int qi = (int) params.get("qi");
        int shi = (int) params.get("shi");
        Long coachId = (Long) params.get("coachId"); // 修正为Long类型，以匹配控制层传入的类型

        // 构建基础查询语句
        String baseJpql = "SELECT cs FROM CourseSchedule cs WHERE cs.courseStatus NOT IN (2, 3)";
        String countBaseJpql = "SELECT COUNT(cs) FROM CourseSchedule cs WHERE cs.courseStatus NOT IN (2, 3)";

        // 如果coachId不为null，添加教练ID的过滤条件
        if (coachId != null) {
            baseJpql += " AND cs.coach.coachId = :coachId";
            countBaseJpql += " AND cs.coach.coachId = :coachId";
        }

        // 添加排序
        baseJpql += " ORDER BY cs.scheduleId DESC";

        // 创建查询
        Query query = entityManager.createQuery(baseJpql);
        Query countQuery = entityManager.createQuery(countBaseJpql);

        // 如果coachId不为null，为查询设置coachId参数
        if (coachId != null) {
            query.setParameter("coachId", coachId);
            countQuery.setParameter("coachId", coachId);
        }

        // 设置分页参数
        query.setFirstResult(qi);
        query.setMaxResults(shi);

        // 执行查询获取结果列表
        List<?> resultList = query.getResultList();

        // 执行计数查询获取总数
        long total = (long) countQuery.getSingleResult();

        // 构造返回结果
        Map<String, Object> result = new HashMap<>();
        result.put("rows", resultList);
        result.put("total", total);

        return result;
    }




    private void updateCourseStatus() {
        Date now = new Date();

        // 查找状态为1（待进行）或2（进行中）的课程
        String jpql = "SELECT cs FROM CourseSchedule cs WHERE cs.courseStatus IN (1, 2)";
        List<CourseSchedule> courses = entityManager.createQuery(jpql, CourseSchedule.class).getResultList();

        for (CourseSchedule cs : courses) {
            if (cs.getEndTime().before(now)) {
                // 如果结束时间小于现在时间，设置状态为3（已完成）
                cs.setCourseStatus(3);
            } else if (cs.getStartTime().before(now) || cs.getStartTime().equals(now)) {
                // 如果开始时间小于等于现在时间，设置状态为2（进行中）
                cs.setCourseStatus(2);
            }
            entityManager.merge(cs);
        }

        // 为了确保所有状态更新都被保存，可以在此处调用flush()
        entityManager.flush();
    }

    /**
     * 修改时候检查时间段
     * @param startTime
     * @param endTime
     * @param scheduleId
     * @return
     */
    public boolean checkScheduleExists(Date startTime, Date endTime, Integer scheduleId, Integer classroomId) {
        String jpql = "SELECT COUNT(cs) FROM CourseSchedule cs WHERE " +
                "cs.classroom.id = :classroomId " + // 确保检查的是相同教室的课程安排
                "AND (cs.startTime < :endTime AND cs.endTime > :startTime) " +
                (scheduleId != null ? "AND cs.scheduleId != :scheduleId" : "");

        Query query = entityManager.createQuery(jpql)
                .setParameter("startTime", startTime)
                .setParameter("endTime", endTime)
                .setParameter("classroomId", classroomId); // 设置教室ID参数

        if (scheduleId != null) {
            query.setParameter("scheduleId", scheduleId);
        }

        long count = (long) query.getSingleResult();
        return count > 0;
    }


    @Transactional
    public boolean updateSchedule(CourseSchedule schedule) {
        if (schedule == null || schedule.getScheduleId() == null) {
            // 如果课程安排实体或其ID为空，则更新操作失败
            return false;
        }

        try {
            entityManager.merge(schedule);
            // 更新成功
            return true;
        } catch (Exception e) {
            // 捕获任何异常，更新失败
            return false;
        }
    }

    /**
     * 添加是检查时间段是否已经存在
     * @param startTime
     * @param endTime
     * @param classroom
     * @return
     */
    public boolean existsByTimeOverlap(Date startTime, Date endTime, Classroom classroom) {
        String jpql = "SELECT COUNT(cs) FROM CourseSchedule cs WHERE " +
                "cs.classroom = :classroom " + // 检查特定教室的课程安排
                "AND ((cs.startTime < :endTime AND cs.endTime > :startTime) " +
                "OR (cs.endTime > :startTime AND cs.startTime < :endTime))";

        Query query = entityManager.createQuery(jpql)
                .setParameter("startTime", startTime)
                .setParameter("endTime", endTime)
                .setParameter("classroom", classroom); // 设置教室参数

        long count = (long) query.getSingleResult(); // 获取查询结果并转换为long类型
        return count > 0; // 检查计数是否大于0
    }



}
