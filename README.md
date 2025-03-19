一、这次分享的项目是我的毕业设计：基于SpringBoot的人脸识别健身房管理系统。
这是我在GitHub上开源的https://github.com/liujianview/gymxmjpa  项目进行二次全面开发和全面完善的项目 
加入了人脸识别等等功能 完善了全部的功能
基于Spring Boot+Spring Data JPA+MySQ+JSP+Bootstrap和Layui框架+Shiro安全框+集成虹软人脸识别SDK

二、系统模块设计
![image](https://github.com/user-attachments/assets/363d08a5-a57e-4e3e-a5fc-929f525e2588)

三、人脸识别模块（用于签到）

人员到场情况（签到）实现
页面如图5.9所示管理员通过访问前端页面进入系统。页面包含了开始识别和结束识别按钮，这些按钮通过JavaScript函数与后端服务进行交互。当用户点击开始识别按钮时，JavaScript函数startTracking()被触发，它首先创建了一个人脸跟踪器tracker，并设置了相关参数，如初始比例、步长和边缘密度。接着，它在视频流上启动人脸跟踪器，开始捕捉摄像头实时的视频流并检测其中的人脸。
同时，页面上的视频显示区域会实时显示摄像头捕捉到的视频流，而画布区域则用于绘制人脸识别结果。视频流中检测到人脸时，会触发跟踪事件，在此事件中，会对当前帧的人脸进行处理，并将处理结果发送给后端进行人脸识别。这个处理包括将视频流中当前帧的图像数据转换为base64格式，然后通过Ajax请求发送给后端的/faceSearch接口进行人脸识别。
后端接收到前端发送的base64图像数据后，首先解码并处理图像数据，然后调用人脸引擎服务faceEngineService提取图像中的人脸特征，并进行人脸比对，获取与指定分组ID匹配的人脸信息列表。如果匹配成功，后端会返回相关的人脸特征数据和欢迎信息给前端，否则会返回查无此人或其他错误信息。
前端根据后端返回的数据更新页面展示，如果匹配成功，则在画布上绘制人脸框，并显示欢迎信息和人脸特征，并且更新已到人员表和未到人员表，如图5.10所示；用户可以随时点击结束识别按钮触发JavaScript函数stopTracking()，停止人脸跟踪，关闭摄像头视频流，并清空画布上的人脸框和欢迎信息。整个流程通过前后端的交互实现了基于摄像头的人脸识别功能，包括了用户界面的展示与交互，以及后端的数据处理和返回，从而实现了一个基本的人脸识别的签到功能。


![image](https://github.com/user-attachments/assets/8845c2f6-739f-4a9f-b578-8fcb86724850)


图5.9 人脸识别签到页面


![image](https://github.com/user-attachments/assets/b59c49d0-c48a-48ba-af3d-85339b183ba5)

图5.10 人脸识别签到成功页面

四.其他功能展示

![image](https://github.com/user-attachments/assets/b30fa1f3-139b-40ef-8e09-2cdd3b0e2bb6)


![image](https://github.com/user-attachments/assets/27e9739c-6be8-468d-b74e-3547744ef580)


![image](https://github.com/user-attachments/assets/60154cb9-a573-4dca-aee9-7c6876f06e62)


![image](https://github.com/user-attachments/assets/ed119b8e-6486-4e10-aa2c-7fbd42711c10)


![image](https://github.com/user-attachments/assets/f6381dff-5793-4f8d-b29c-cd8ba6486869)


![image](https://github.com/user-attachments/assets/7807cd77-c7ee-45e2-806e-310ea18c6cf1)


![image](https://github.com/user-attachments/assets/56407e90-8fa8-4c02-bfd8-4b1c5d3036ee)


![image](https://github.com/user-attachments/assets/0658dc1d-8885-4986-acbb-00982634b532)


![image](https://github.com/user-attachments/assets/6c977532-8f16-48d9-95ba-d66fcf7b6207)







