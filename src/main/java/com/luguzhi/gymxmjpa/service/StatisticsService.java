package com.luguzhi.gymxmjpa.service;

import com.luguzhi.gymxmjpa.dao.RenewalRecordDao;
import com.luguzhi.gymxmjpa.dao.CoachDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class StatisticsService {

    @Autowired
    private RenewalRecordDao renewalRecordDao;

    @Autowired
    private CoachDao coachDao;

    public Map<String, Object> getMonthlyNetIncomeByYear(int year) {
        int[] monthlyIncome = new int[12];
        int[] monthlyNetIncome = new int[12];

        // 查询全年教练的工资总和
        Double totalWages = coachDao.findTotalWages();
        int monthlyExpenditure = totalWages != null ? totalWages.intValue() / 12 : 0;

        // 查询每个月充值收入并计算净收入
        for (int i = 1; i <= 12; i++) {
            Double income = renewalRecordDao.findTotalIncomeByMonthAndYear(i,year);
            monthlyIncome[i - 1] = income != null ? income.intValue() : 0;
            monthlyNetIncome[i - 1] = monthlyIncome[i - 1] - monthlyExpenditure;
        }

        Map<String, Object> results = new HashMap<>();
//        results.put("monthlyIncome", monthlyIncome);
//        results.put("monthlyExpenditure", monthlyExpenditure); // 注意这里改为单一值
        results.put("monthlyNetIncome", monthlyNetIncome);
        return results;
    }
}