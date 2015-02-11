#### 说明

* Api均采用restful的设计模式 

#### 服务器地址 http://114.215.125.31

#### Api List
* 所有 Api参数 请参考 https://gitcafe.com/Hey-DouB/AfterSchool/blob/master/db/schema.rb 因为有可能改变
* Api 返回值如需要定制请联系
* 用户
    * 老师 控制器 __api/v1/teachers__    
    列出单个老师  get 
    {
        id: 1
    }
    输出 : http://114.215.125.31/api/v1/teachers

    创建（post） :  http://114.215.125.31/api/v1/teachers
    {
        email: xxxx
        password: xxxxx
        password_confirmation: xxxxx
        nickname: xxxx
        phone: xxxx
    }

    * 学生 控制器 __api/v1/students__
    * 学生查看自己的作业
     get : students/:id/homeworks
     {
        token
     }
* 登录
    * 所有用户统一 控制器 __api/v1/user_tokens__

* 资源
    * 资源由前端解析为Base64串传
    * 控制器 __api/v1/media_resources__
* 作业
    * 控制器 __api/v1/work_papers__

