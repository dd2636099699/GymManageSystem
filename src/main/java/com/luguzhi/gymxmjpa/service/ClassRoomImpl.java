package com.luguzhi.gymxmjpa.service;

import org.springframework.stereotype.Service;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.util.HashMap;
import java.util.Map;
@Service
public class ClassRoomImpl {
    @PersistenceContext
    private EntityManager entityManager;

    public Map<String, Object> query(Map<String, Object> map1) {
        String jpql = "from Classroom where 1=1";

        // 根据subname进行条件过滤
        if (map1.get("subname") != null && !map1.get("subname").equals("")) {
            jpql += " and classroomName like '%" + map1.get("subname") + "%'";
        }

        jpql += " order by classroomId desc";

        Query query = entityManager.createQuery(jpql);
        query.setFirstResult((int) map1.get("qi"));
        query.setMaxResults((int) map1.get("shi"));

        String countJpql = "select count(c) from Classroom c where 1=1";
        if (map1.get("subname") != null && !map1.get("subname").equals("")) {
            countJpql += " and c.classroomName like '%" + map1.get("subname") + "%'";
        }

        Long count = (Long) entityManager.createQuery(countJpql).getSingleResult();

        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("total", count);
        resultMap.put("rows", query.getResultList());

        return resultMap;
    }


}
