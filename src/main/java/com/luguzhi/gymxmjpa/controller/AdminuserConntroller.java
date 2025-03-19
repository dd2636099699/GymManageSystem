package com.luguzhi.gymxmjpa.controller;



import com.luguzhi.gymxmjpa.dao.AdminuserRepository;
import com.luguzhi.gymxmjpa.dao.memberDao;
import com.luguzhi.gymxmjpa.entity.Adminuser;
import com.luguzhi.gymxmjpa.entity.Coach;
import com.luguzhi.gymxmjpa.entity.Member;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 管理员登录Controller控制层

 */
@Controller
@RequestMapping("/")
public class AdminuserConntroller {
    @Autowired
    private AdminuserRepository adminuserDao;
    @Autowired
    private memberDao memberDao1;

    /**
     输入端口号直接跳转登录界面

     */
    @RequestMapping("/")
    public String beforeLogin(){
        return "login";
    }

    /**
            管理员登录验证方法

     */
    @RequestMapping("/dl/yz")
    public String login(String username, String password, String role, HttpSession httpSession, Model model) {

        Subject subject = SecurityUtils.getSubject();
        UsernamePasswordToken userToken = new UsernamePasswordToken(username, password, role);

        try {
            subject.login(userToken); // 尝试登录，Shiro会进行相应的认证

            if (subject.hasRole("admin")) {
                // 管理员登录逻辑
                Adminuser adminuser = (Adminuser) subject.getPrincipal();
                httpSession.setAttribute("user", adminuser);
                return "WEB-INF/jsp/index"; // 管理员登录成功，跳转到管理员首页
            } else if (subject.hasRole("member")) {
                // 会员登录逻辑
                Member member = (Member) subject.getPrincipal();
                httpSession.setAttribute("user", member);
                return "WEB-INF/jsp/index2"; // 会员登录成功，跳转到会员首页
            } else if (subject.hasRole("coach")) {
                // 教练登录逻辑
                Coach coach = (Coach) subject.getPrincipal();
                httpSession.setAttribute("user", coach);
                return "WEB-INF/jsp/index3"; // 教练登录成功，跳转到教练首页
            } else {
                // 未知角色类型
                model.addAttribute("msg", "未知的角色类型，请选择正确的角色登录");
                return "login";
            }
        } catch (UnknownAccountException e) {
            model.addAttribute("msg", "用户名或密码错误,请重新输入");
            return "login";
        }
    }

    /**
     * 退出登录后清楚session

     */
    @RequestMapping("/logout")
    public String logout(){
        Subject subject = SecurityUtils.getSubject();
        subject.logout();
        return "redirect:/login";

    }

    /**
     * 跳转到修改密码界面

     */
    @RequestMapping("/updPassword")
    public String updPassword(){
        return "WEB-INF/jsp/updPassword";
    }


    /**
     *  修改密码

     */
    @RequestMapping("/upd/updPassword")
    public String updPasswordConfirm(String oldPassword, String newPassword, String newPasswordAgain, HttpSession httpSession, Model model) throws UnsupportedEncodingException {
        Pattern p = Pattern.compile("^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!.%*#?&])[A-Za-z\\d$@$!.%*#?&]{8,}$");
        Matcher m = p.matcher(newPassword);
        if (!m.matches()) {
            model.addAttribute("msg", "新密码最少为8位并为字母+数字+特殊字符");
            return "WEB-INF/jsp/updPassword";
        }
        if (!newPassword.equals(newPasswordAgain)) {
            model.addAttribute("msg", "两次输入新密码不一致，请重新输入");
            return "WEB-INF/jsp/updPassword";
        }

        Subject subject = SecurityUtils.getSubject();
        Object user = subject.getPrincipal();

        if (user != null) {
            if (user instanceof Adminuser) {
                Adminuser adminuser = (Adminuser) user;
                if (!adminuser.getAdminPassword().equals(DigestUtils.md5Hex(oldPassword))) {
                    model.addAttribute("msg", "原密码不正确，请重新输入");
                    return "WEB-INF/jsp/updPassword";
                }
                // 更新管理员密码
                adminuserDao.updPassword(adminuser.getAdminId(), DigestUtils.md5Hex(newPassword));
            } else if (user instanceof Member) {
                Member member = (Member) user;
                if (!member.getMemberPassword().equals(DigestUtils.md5Hex(oldPassword))) {
                    model.addAttribute("msg", "原密码不正确，请重新输入");
                    return "WEB-INF/jsp/updPassword";
                }
                // 更新会员密码
                memberDao1.updPassword(member.getMemberId(), DigestUtils.md5Hex(newPassword));
//                model.addAttribute("successMsg", "密码修改成功，请重新登录");

            }
//            else if (user instanceof Coach) {
//                Coach coach = (Coach) user;
//                if (!coach.getCoachPassword().equals(DigestUtils.md5Hex(oldPassword))) {
//                    model.addAttribute("msg", "原密码不正确，请重新输入");
//                    return "WEB-INF/jsp/updPassword";
//                }
//                // 更新教练密码
//                coachDao.updPassword(coach.getCoachId(), DigestUtils.md5Hex(newPassword));
//            }
            // 退出登录
            subject.logout();
            // 使用 URLEncoder 编码中文消息
            String encodedMessage = URLEncoder.encode("密码修改成功，请重新登录", String.valueOf(StandardCharsets.UTF_8));
// 构建重定向 URL
            String redirectUrl = "redirect:/login.jsp?successMsg=" + encodedMessage;
            return redirectUrl;
        } else {
            model.addAttribute("msg", "登录用户信息错误，请重新登录");
            return "WEB-INF/jsp/updPassword";
        }
    }

}
