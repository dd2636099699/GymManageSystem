package com.luguzhi.gymxmjpa;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * @Description: 启动类
 */

@SpringBootApplication
public class GymxmjpaApplication {

    public static void main(String[] args) {
        SpringApplication.run(GymxmjpaApplication.class, args);

        try {


            Runtime.getRuntime().exec("cmd   /c   start   http://"+"localhost"+":8085/index.jsp");//可以指定自己的路径
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }
//    @RequestMapping("/")
//    public String home() {
//        return "index";
//    }
}
