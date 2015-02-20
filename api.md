#### 服务器地址 http://114.215.125.31



# curl 使用说明

    在linux或者osx 下，在命令行窗口直接 copy 下面内容到窗口执行即可

#### change log
    
    2015-2-23 replace user to student

## user login 登录
    curl -H "Accept:application/json" -d 'user[nickname]=dreamlinx&user[password]=11111111' http://114.215.125.31/api/v1/user_tokens

    - action: post
    - params: 
        - user[nickname]=dreamlinx
        - user[password]=11111111 
        - (或者 user[email])
    - response:
            #
            {"token":"CUw2vD4UbbrLmrdR6wFw","user_id":1,"user":{"id":1,"nickname":"dreamlinx","phone":null,"created_at":"2015-02-19T04:56:12.000Z","updated_at":"2015-02-19T05:46:29.708Z","email":"dreamlinx@gmail.com","authentication_token":"CUw2vD4UbbrLmrdR6wFw","school_class_id":null,"avatar":{"url":null}}}

## user logout 登出
    curl -H "Accept:application/json" -X DELETE http://114.215.125.31/api/v1/user_tokens/1
    
    - action: delete
    - params: id # 注意url用法，restful中记录id是直接以 /:id存在的 user_tokens/1
    - response:
        #
        {"success":true}%                 

## get student info 获取用户基本信息

    curl -H "Accept:application/json" -X GET http://114.215.125.31/api/v1/students/1
    
    - action: get
    - params: id # 注意url用法，restful中记录id是直接以 /:id存在的 students/1
    - response:
        # 
        {"student":{"id":3,"nickname":"test2","phone":null,"created_at":"2015-02-20T14:43:13.000Z","updated_at":"2015-02-20T14:51:27.000Z","email":"test3@gmail.com","authentication_token":"yyLyks2giDifPxxuxsVw","school_class_id":null},"profile":{"user_id":3,"avatar":{"url":null},"id":2,"address":null,"birthday":null,"gender":null,"student_number":null,"created_at":"2015-02-20T14:51:27.000Z","updated_at":"2015-02-20T14:51:27.000Z"},"school_class":{"id":4,"class_no":"22222","created_at":"2015-02-20T16:24:40.000Z","updated_at":"2015-02-20T16:24:40.000Z"}}%        

## update students profile 更新用户资料
    curl -H "Accept:application/json" -X PUT -d 'profile[address]=adsfad&profile[birthday]=2014-11-1' http://114.215.125.31/api/v1/students/3/profile

    - action: put
    - params:
        - profile[address]= string
        - profile[postalcode]= string
        - profile[birthday]= yyyy-mm-dd
        - profile[gender]= female|male
        - profile[avatar]= base64 file  #TODO，need test

## get classes 获取班级list 
    curl -H "Accept:application/json" http://127.0.0.1:3000/api/v1/school_classes

    - action: get
    - response:
        #
        {"school_classes":[{"id":1,"class_no":"2015","created_at":"2015-02-20T02:38:59.000Z","updated_at":"2015-02-20T02:38:59.000Z"}]}

## get class 获取班级基本信息：老师，学生，作业(TODO)
    curl -H "Accept:application/json" http://127.0.0.1:3000/api/v1/school_classes/1

    - action: get
    - params: id

## get work_papers 获取我的作业（老师看自己发布的，学生看自己要做的）


======下面的说明都要替换掉=====================

#### Api List

* 作业 
    * 学生 查看自己所有的作业
        * `url` http://114.215.125.31/api/v1/students/:id/homeworks
        * `action` get
        * `response`
        
        ```
        work_paper: 
        {
            id: 2,
            title: "aaa",
            type: "aaaa",
            description: "aaa",
            teacher: "李老师",
            medias:  [
            {
                media_resource_id: 1,
                avatar: "/uploads/media_resource/avatar/1/IMG_0309.JPG"
            }
            ]
         }
         }
         ```