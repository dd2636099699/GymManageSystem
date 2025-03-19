package com.luguzhi.gymxmjpa.dao;

import com.luguzhi.gymxmjpa.entity.CourseSchedule;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;

public interface CourseScheduleDao extends JpaRepository<CourseSchedule, Integer>, JpaSpecificationExecutor<CourseSchedule> {

}
