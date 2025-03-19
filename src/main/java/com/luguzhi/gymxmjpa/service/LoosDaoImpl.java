package com.luguzhi.gymxmjpa.service;

import com.luguzhi.gymxmjpa.dao.LoosDao;
import com.luguzhi.gymxmjpa.entity.Loos;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.util.HashMap;
import java.util.Map;

/**
 * @Description: 遗失物品管理service实现层
 * @Author: luguzhi
 * @Date: 2024/4/14
 */
@Service
public class LoosDaoImpl {
    @Autowired
    private LoosDao loosDao;
    @PersistenceContext
    private EntityManager entityManager;

    /**
     * @Description: 遗失物品管理service实现层-分页查询
     * @Author: luguzhi
     * @Date: 2024/4/14
     */
    public Map<String,Object> query(Map<String,Object> map1){
        // 分页
        String jpal = "from Loos where 1=1";
        if(map1.get("loosName") != null && !map1.get("loosName").equals("")){
            jpal = jpal + " and loosName like '%" + map1.get("loosName") + "%'";
        }
        // 添加 ORDER BY 子句进行降序排序
        jpal += " order by loosId desc"; // 注意: 确保这里使用的字段名是实体类中的属性名

        Query qu = entityManager.createQuery(jpal);
        // 起始页数
        qu.setFirstResult((int)map1.get("qi"));
        // 结束页数
        qu.setMaxResults((int)map1.get("shi"));

        // 查询多少条数据
        String jpa = "select count(l) from Loos l where 1=1";
        if(map1.get("loosName") != null && !map1.get("loosName").equals("")){
            jpa = jpa + " and loosName like '%" + map1.get("loosName") + "%'";
        }
        // 不需要在计算总数的查询中添加排序
        Long count = (Long) entityManager.createQuery(jpa).getSingleResult();

        Map<String,Object> map = new HashMap<String,Object>();
        map.put("total", count);
        map.put("rows", qu.getResultList());
        return map;
    }


    /**
     * @Description: 遗失物品管理service实现层-修改信息
     * @Author: luguzhi
     * @Date: 2024/4/14
     */
    public int update(Loos loos){
        Loos loos1=loosDao.findById(loos.getLoosId()).get();
       loos1.setLoosStatus(loos.getLoosStatus());
       loos1.setReceiveName(loos.getReceiveName());
       loos1.setReceivePhone(loos.getReceivePhone());
       loos1.setLoosldate(loos.getLoosldate());
       loosDao.save(loos1);
        return 1;
    }
}
