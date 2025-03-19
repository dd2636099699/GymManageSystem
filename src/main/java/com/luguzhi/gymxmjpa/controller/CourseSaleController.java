package com.luguzhi.gymxmjpa.controller;

import com.luguzhi.gymxmjpa.dao.CourseSaleDao;
import com.luguzhi.gymxmjpa.dto.CourseSaleDto;
import com.luguzhi.gymxmjpa.entity.CourseSale;
import com.luguzhi.gymxmjpa.service.CourseSaleDaoImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/CourseSale")
public class CourseSaleController {
    @Autowired
    private CourseSaleDao courseSaleDao;
    private CourseSaleDaoImpl courseSaleDaoImpl;

    @RequestMapping("/jin")
    public String jin() {
        return "WEB-INF/jsp/CourseSale";
    }
    @RequestMapping("/MyCoursejin")
    public String MyCoursejin() {
        return "WEB-INF/jsp/MyCourse";
    }
    @RequestMapping("/query")
    public ResponseEntity<?> query(
            @RequestParam(value = "pageNumber", defaultValue = "1") int pageNumber,
            @RequestParam(value = "pageSize", defaultValue = "10") int pageSize) {

        PageRequest pageRequest = PageRequest.of(pageNumber - 1, pageSize);
        Page<CourseSaleDto> courseSaleDtoPage = courseSaleDao.findCourseSaleInfo(pageRequest);

        Map<String, Object> response = new HashMap<>();
        response.put("total", courseSaleDtoPage.getTotalElements()); // 总记录数
        response.put("rows", courseSaleDtoPage.getContent()); // 当前页数据列表

        return ResponseEntity.ok(response);
    }
    @GetMapping("/findById")
    public ResponseEntity<?> findById(@RequestParam("memberId") Long memberId) {
        // 这将返回一个列表，而不是Optional
        List<CourseSale> courseSales = courseSaleDao.find(memberId);

        if (!courseSales.isEmpty()) {
            // 如果找到了实体，返回200 OK和实体数据
            // 注意：如果期望返回多个实体，请确保您的响应体结构能够正确处理列表
            return ResponseEntity.ok(courseSales);
        } else {
            // 如果没有找到实体，返回404 Not Found
            return ResponseEntity.notFound().build();
        }
    }



}