package com.luguzhi.gymxmjpa.controller;


import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.codec.Base64;
import cn.hutool.core.collection.CollectionUtil;
import cn.hutool.core.util.RandomUtil;
import com.arcsoft.face.FaceInfo;
import com.arcsoft.face.toolkit.ImageFactory;
import com.arcsoft.face.toolkit.ImageInfo;

import com.luguzhi.gymxmjpa.base.Result;
import com.luguzhi.gymxmjpa.base.Results;
import com.luguzhi.gymxmjpa.dao.FaceEngineService;
import com.luguzhi.gymxmjpa.dao.SignInRecordDao;
import com.luguzhi.gymxmjpa.dao.UserFaceInfoService;
import com.luguzhi.gymxmjpa.dao.memberDao;
import com.luguzhi.gymxmjpa.dto.FaceSearchResDto;
import com.luguzhi.gymxmjpa.dto.FaceUserInfo;
import com.luguzhi.gymxmjpa.dto.ProcessInfo;
import com.luguzhi.gymxmjpa.entity.Member;
import com.luguzhi.gymxmjpa.entity.SignInRecord;
import com.luguzhi.gymxmjpa.entity.UserFaceInfo;
import com.luguzhi.gymxmjpa.enums.ErrorCodeEnum;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.Base64Utils;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.imageio.ImageIO;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.Optional;

import org.apache.shiro.crypto.hash.SimpleHash;

@Controller
public class FaceController {

    public final static Logger logger = LoggerFactory.getLogger(com.luguzhi.gymxmjpa.controller.FaceController.class);


    @Autowired
    SignInRecordDao signInRecordDao;

    @Autowired
    FaceEngineService faceEngineService;

     @Autowired
    memberDao  m;

    @Autowired
    UserFaceInfoService userFaceInfoService;

    @RequestMapping(value = "/demo")
    public String demo() {
        return "demo";
    }

    /*
    人脸添加
     */
    @RequestMapping(value = "/faceAdd", method = RequestMethod.POST)
    @ResponseBody
    public Result<Object> faceAdd(@RequestParam("file") String file,
                                  @RequestParam("groupId") Integer groupId,
                                  @RequestParam("name") String name,
                                  @RequestParam("memberPassword") String password, // 更新参数名以匹配前端
                                  @RequestParam("phone") String phone,
                                  @RequestParam("sex") Integer sex,
                                  @RequestParam("age") Integer age,
                                  @RequestParam("srdata") String srdata,
                                  @RequestParam("optype") Integer optype)
    {
        // 检查name是否已存在

        Member existingMember = m.findByName(name);
        if (existingMember != null) {
            return Results.newFailedResult("用户已经存在！");
        }
        try {
            if (file == null) {
                return Results.newFailedResult("file is null");
            }
            if (groupId == null) {
                return Results.newFailedResult("groupId is null");
            }
            if (name == null) {
                return Results.newFailedResult("name is null");
            }

            byte[] decode = Base64.decode(base64Process(file));
            ImageInfo imageInfo = ImageFactory.getRGBData(decode);

            //人脸特征获取
            byte[] bytes = faceEngineService.extractFaceFeature(imageInfo);
            if (bytes == null) {
                return Results.newFailedResult(ErrorCodeEnum.NO_FACE_DETECTED);
            }
            // 使用Shiro进行密码加密
            String algorithmName = "MD5";
            Object encryptedPassword =  new SimpleHash(algorithmName, password, null, 1).toHex();
            UserFaceInfo userFaceInfo = new UserFaceInfo();
            Member member = new Member();




            userFaceInfo.setName(name);
            userFaceInfo.setGroupId(groupId);
            userFaceInfo.setFaceFeature(bytes);
            userFaceInfo.setFaceId(RandomUtil.randomString(10));
            userFaceInfo.setMemberPassword(encryptedPassword.toString()); // 保存加密后的密码
            userFaceInfo.setPhoneNumber(phone); // 处理新添加的字段
            userFaceInfo.setGender(sex);
            userFaceInfo.setAge(age);
            userFaceInfo.setBirthday(srdata);
            userFaceInfo.setMemberTypes(optype);
            userFaceInfo.setMemberStatic(2);

            //人脸特征插入到数据库
            userFaceInfoService.save(userFaceInfo);

            logger.info("faceAdd:" + name);
            return Results.newSuccessResult("");
        } catch (Exception e) {
            logger.error("", e);
        }
        return Results.newFailedResult(ErrorCodeEnum.UNKNOWN);
    }

    /*
    人脸识别
     */
    @RequestMapping(value = "/faceSearch", method = RequestMethod.POST)
    @ResponseBody
    public Result<FaceSearchResDto> faceSearch(String file, Integer groupId) throws Exception {

        if (groupId == null) {
            return Results.newFailedResult("groupId is null");
        }
        byte[] decode = Base64.decode(base64Process(file));
        BufferedImage bufImage = ImageIO.read(new ByteArrayInputStream(decode));
        ImageInfo imageInfo = ImageFactory.bufferedImage2ImageInfo(bufImage);


        //人脸特征获取
        byte[] bytes = faceEngineService.extractFaceFeature(imageInfo);
        if (bytes == null) {
            return Results.newFailedResult(ErrorCodeEnum.NO_FACE_DETECTED);
        }
        //人脸比对，获取比对结果
        List<FaceUserInfo> userFaceInfoList = faceEngineService.compareFaceFeature(bytes, groupId);

        if (CollectionUtil.isNotEmpty(userFaceInfoList)) {

            FaceUserInfo faceUserInfo = userFaceInfoList.get(0);
            String name = faceUserInfo.getName();
            //查找5分钟内存在返回过去5分钟内某成员的签到次数 大于1为已经签到过了 不再存储
            int count = signInRecordDao.countRecentSignInsByMemberName(name);
            if(count<1){    //查找5分钟内存在返回过去5分钟内某成员的签到次数 大于1为已经签到过了 不再存储
                SignInRecord signInRecord = new SignInRecord(name);
                signInRecordDao.save(signInRecord);
            }
            FaceSearchResDto faceSearchResDto = new FaceSearchResDto();
            BeanUtil.copyProperties(faceUserInfo, faceSearchResDto);
            List<ProcessInfo> processInfoList = faceEngineService.process(imageInfo);
            if (CollectionUtil.isNotEmpty(processInfoList)) {
                //人脸检测
                List<FaceInfo> faceInfoList = faceEngineService.detectFaces(imageInfo);
                int left = faceInfoList.get(0).getRect().getLeft();
                int top = faceInfoList.get(0).getRect().getTop();
                int width = faceInfoList.get(0).getRect().getRight() - left;
                int height = faceInfoList.get(0).getRect().getBottom() - top;

                Graphics2D graphics2D = bufImage.createGraphics();
                graphics2D.setColor(Color.RED);//红色
                BasicStroke stroke = new BasicStroke(5f);
                graphics2D.setStroke(stroke);
                graphics2D.drawRect(left, top, width, height);
                ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
                ImageIO.write(bufImage, "jpg", outputStream);
                byte[] bytes1 = outputStream.toByteArray();
                faceSearchResDto.setImage("data:image/jpeg;base64," + Base64Utils.encodeToString(bytes1));
                faceSearchResDto.setAge(processInfoList.get(0).getAge());
                faceSearchResDto.setGender(processInfoList.get(0).getGender().equals(1) ? "女" : "男");
//                new SignInRecord()
//                signInRecordDao.save();
            }

            return Results.newSuccessResult(faceSearchResDto);
        }
        return Results.newFailedResult(ErrorCodeEnum.FACE_DOES_NOT_MATCH);
    }


    @RequestMapping(value = "/detectFaces", method = RequestMethod.POST)
    @ResponseBody
    public List<FaceInfo> detectFaces(String image) throws IOException {
        byte[] decode = Base64.decode(image);
        InputStream inputStream = new ByteArrayInputStream(decode);
        ImageInfo imageInfo = ImageFactory.getRGBData(inputStream);

        if (inputStream != null) {
            inputStream.close();
        }
        List<FaceInfo> faceInfoList = faceEngineService.detectFaces(imageInfo);

        return faceInfoList;
    }


    private String base64Process(String base64Str) {
        if (!StringUtils.isEmpty(base64Str)) {
            String photoBase64 = base64Str.substring(0, 30).toLowerCase();
            int indexOf = photoBase64.indexOf("base64,");
            if (indexOf > 0) {
                base64Str = base64Str.substring(indexOf + 7);
            }

            return base64Str;
        } else {
            return "";
        }
    }
}
