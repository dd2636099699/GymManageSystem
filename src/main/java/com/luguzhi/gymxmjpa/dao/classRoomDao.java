package com.luguzhi.gymxmjpa.dao;

import com.luguzhi.gymxmjpa.entity.Classroom;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;

import javax.transaction.Transactional;

/**
 * 教室管理
 */
public interface classRoomDao extends JpaRepository<Classroom, Integer>, JpaSpecificationExecutor<Classroom> {
    boolean existsByClassroomName(String classroomName);


    @Modifying
    @Transactional
    @Query("update Classroom c set c.classroomName = ?1, c.capacity = ?2, c.location = ?3 where c.classroomId = ?4")
    void updateClassroom(String name, Integer capacity, String location, Integer id);

}
