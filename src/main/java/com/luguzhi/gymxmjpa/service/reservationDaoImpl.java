package com.luguzhi.gymxmjpa.service;

import com.luguzhi.gymxmjpa.dao.ReservationDao;
import com.luguzhi.gymxmjpa.entity.Reservation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.TemporalType;
import javax.persistence.TypedQuery;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class reservationDaoImpl {
    @PersistenceContext
    private EntityManager entityManager;
    @Autowired
    private ReservationDao reservationDao;
    /**
     * 获取指定设备的总数
     * @param equipmentId 设备ID
     * @return 设备的总数
     */
    public int getEquipmentTotalCount(Integer equipmentId) {
        Integer count = reservationDao.findCountByEqId(equipmentId);
        return count != null ? count : 0;
    }

    public Map<String, Object> getEquipmentAvailability(Long memberId, Integer equipmentId) {
        Map<String, Object> response = new HashMap<>();
        LocalDate today = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
        String[] sessions = {"9:00-11:40", "14:30-17:00", "19:00-23:00"};

        int equipmentTotalCount = getEquipmentTotalCount(equipmentId);

        Map<String, Map<String, Object>> dailyReservationsCount = new HashMap<>();

        for (int day = 1; day <= 2; day++) {
            LocalDate targetDate = today.plusDays(day);
            String formattedDate = targetDate.format(formatter);

            Map<String, Object> reservationsCount = new HashMap<>();
            for (String session : sessions) {
                Map<String, Object> sessionInfo = new HashMap<>();
                sessionInfo.put("count", 0);
                sessionInfo.put("reserved", false); // 初始化为未预约
                sessionInfo.put("available", true); // 默认可预约
                reservationsCount.put(session, sessionInfo);
            }

            Date date = java.sql.Date.valueOf(targetDate);

            List<Reservation> reservationsForDate = entityManager.createQuery(
                    "SELECT r FROM Reservation r WHERE r.equipment.eqId = :equipmentId AND r.date = :date", Reservation.class)
                    .setParameter("equipmentId", equipmentId)
                    .setParameter("date", date, TemporalType.DATE)
                    .getResultList();

            // 查询该会员在该日期的预约情况
            List<Reservation> memberReservationsForDate = entityManager.createQuery(
                    "SELECT r FROM Reservation r WHERE r.member.memberId = :memberId AND r.equipment.eqId = :equipmentId AND r.date = :date", Reservation.class)
                    .setParameter("memberId", memberId)
                    .setParameter("equipmentId", equipmentId)
                    .setParameter("date", date, TemporalType.DATE)
                    .getResultList();

            for (Reservation reservation : reservationsForDate) {
                String session = reservation.getSession();
                Map<String, Object> sessionInfo = (Map<String, Object>) reservationsCount.get(session);
                sessionInfo.put("count", (Integer) sessionInfo.get("count") + 1);

                if ((Integer) sessionInfo.get("count") >= equipmentTotalCount) {
                    sessionInfo.put("available", false); // 更新为不可预约
                }
            }

            // 更新已预约的时间段
            for (Reservation memberReservation : memberReservationsForDate) {
                String session = memberReservation.getSession();
                Map<String, Object> sessionInfo = (Map<String, Object>) reservationsCount.get(session);
                sessionInfo.put("reserved", true); // 更新为已预约
            }

            dailyReservationsCount.put(formattedDate, reservationsCount);
        }

        response.put("dailyReservationsCount", dailyReservationsCount);
        return response;
    }
}
