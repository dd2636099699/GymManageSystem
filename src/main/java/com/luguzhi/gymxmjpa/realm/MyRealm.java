package com.luguzhi.gymxmjpa.realm;

import com.luguzhi.gymxmjpa.dao.AdminuserRepository;
import com.luguzhi.gymxmjpa.dao.CoachDao;
import com.luguzhi.gymxmjpa.dao.memberDao;
import com.luguzhi.gymxmjpa.entity.Adminuser;
import com.luguzhi.gymxmjpa.entity.Coach;
import com.luguzhi.gymxmjpa.entity.Member;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;

public class MyRealm extends AuthorizingRealm {

    @Autowired
    private AdminuserRepository adminuserDao;

    @Autowired
    private memberDao memberDao1;
    @Autowired
    private CoachDao coachDao;

    // 用户认证
    @Override
    protected SimpleAuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        UsernamePasswordToken upToken = (UsernamePasswordToken) token;
        String username = upToken.getUsername();
        String password = new String(upToken.getPassword());

        if ("admin".equals(upToken.getHost())) {
            // 管理员登录认证
            Adminuser adminuser = adminuserDao.findByAdminNameAndAdminPassword(username, DigestUtils.md5Hex(password));
            if (adminuser != null) {
                return new SimpleAuthenticationInfo(adminuser, adminuser.getAdminPassword(), getName());
            }
        } else if ("member".equals(upToken.getHost())) {
            // 会员登录认证
            Member member = memberDao1.findByMemberNameAndMemberPassword(username, DigestUtils.md5Hex(password));
            if (member != null) {
                return new SimpleAuthenticationInfo(member, member.getMemberPassword(), getName());
            }
        }else if ("coach".equals(upToken.getHost())) {
            // 教练登录认证
            Coach coach = coachDao.findByCoachNameAndCoachPassword(username, DigestUtils.md5Hex(password));
            if (coach != null) {
                return new SimpleAuthenticationInfo(coach, coach.getCoachPassword(), getName());
            }
        }

        return null;
    }

    // 用户授权角色
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        SimpleAuthorizationInfo authorizationInfo = new SimpleAuthorizationInfo();
        Object primaryPrincipal = principals.getPrimaryPrincipal();

        if (primaryPrincipal instanceof Adminuser) {
            // 管理员角色授权
            authorizationInfo.addRole("admin");
            System.out.println("是管理员！");
        } else if (primaryPrincipal instanceof Member) {
            // 会员角色授权
            authorizationInfo.addRole("member");
            System.out.println("是会员！");
        } else if (primaryPrincipal instanceof Coach) {
            // 会员角色授权
            authorizationInfo.addRole("coach");
            System.out.println("是会教练！");}

        return authorizationInfo;
    }
}