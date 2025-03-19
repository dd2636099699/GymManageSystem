package com.luguzhi.gymxmjpa.controller;
import java.sql.Date; // 正确的导入语句
import com.luguzhi.gymxmjpa.dao.EquipmentDao;
import com.luguzhi.gymxmjpa.dao.ReservationDao;
import com.luguzhi.gymxmjpa.dto.ReservationDTO;
import com.luguzhi.gymxmjpa.entity.Equipment;
import com.luguzhi.gymxmjpa.entity.Member;
import com.luguzhi.gymxmjpa.entity.Reservation;
import com.luguzhi.gymxmjpa.service.reservationDaoImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Sort;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.*;

@RestController
@RequestMapping("/reserve")
public class reserveController {
    @Autowired
    private ReservationDao reservationDao;
    @Autowired
    private com.luguzhi.gymxmjpa.dao.memberDao memberDao;
    @Autowired
    private EquipmentDao equipmentDao;
    @Autowired
    private reservationDaoImpl r;

    @RequestMapping("/query")
    public Map<String, Object> queryReservations(@RequestParam Optional<Long> memberId) {
        Sort sort = Sort.by(Sort.Direction.DESC, "reservationId");
        List<Reservation> reservations;

        if (memberId.isPresent()) {
            // 如果提供了会员ID，则只查询该会员的预约信息
            reservations = reservationDao.findByMemberMemberId(memberId.get(), sort);
        } else {
            // 如果没有提供会员ID，则查询所有预约信息
            reservations = reservationDao.findAll(sort);
        }

        Map<String, Object> response = new HashMap<>();
        response.put("total", reservations.size());
        response.put("rows", reservations);
        return response;
    }
    @PostMapping("/cancel/{reservationId}")
    public Map<String, Object> cancelReservation(@PathVariable Long reservationId) {
        Map<String, Object> response = new HashMap<>();
        try {
            reservationDao.deleteById(reservationId); // 假设这里是通过ID删除预约
            response.put("success", true);
            response.put("message", "预约已取消");
        } catch (Exception e) {
            response.put("success", false);
            response.put("message", "取消预约失败：" + e.getMessage());
        }
        return response;
    }
    @RequestMapping("/memberquery")
    public ResponseEntity<?> getAllMembers() {
        List<Member> members = memberDao.findAll();
        return ResponseEntity.ok().body(members);
    }

    @GetMapping("/eqquery")
    public ResponseEntity<?> getAllEquipments() {
        List<Equipment> equipments = equipmentDao.findAll();
        return ResponseEntity.ok().body(equipments);
    }
    @GetMapping("/equipmentAvailability")
    public Map<String, Object> getEquipmentAvailability(@RequestParam Long memberId, @RequestParam Integer equipmentId) {
        Map<String, Object> equipmentAvailability = r.getEquipmentAvailability(memberId, equipmentId);
        return equipmentAvailability;
    }
    @PostMapping("/save")
    public ResponseEntity<?> saveReservation(@RequestBody ReservationDTO reservationDTO) {
        try {
            Member member = memberDao.findById(reservationDTO.getMemberId())
                    .orElseThrow(() -> new Exception("会员未找到"));
            Equipment equipment = equipmentDao.findById(reservationDTO.getEqId())
                    .orElseThrow(() -> new Exception("设备未找到"));

            Reservation reservation = new Reservation();
            reservation.setMember(member);
            reservation.setEquipment(equipment);
            reservation.setDate(reservationDTO.getDate());
            reservation.setSession(reservationDTO.getSession());

            reservationDao.save(reservation);

            return ResponseEntity.ok().body("预约成功");
        } catch (Exception e) {
            return ResponseEntity.badRequest().body("预约失败：" + e.getMessage());
        }
    }




}
