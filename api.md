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

## update student password 更改用户名密码
    
    curl -H "Accept:application/json" -X PUT -d 'student[email]=test5@gmail.com&student[password]=11111111&student[password_confirmation]=11111112' http://127.0.0.1:3000/api/v1/students/3

    - action: PUT
    - params:
        - id  #students/3 这里的id 就是3
        - student[password]= string
        - student[password_confirmation]=string
    - reponse
        正常
        {"student":{"id":3,"nickname":"test2","phone":null,"created_at":"2015-02-20T14:43:13.000Z","updated_at":"2015-02-20T16:37:52.041Z","email":"test5@gmail.com","authentication_token":"yyLyks2giDifPxxuxsVw","school_class_id":null}}% 

        错误
        {"error":{"password_confirmation":["doesn't match Password"]}}%  

## update students profile 更新用户资料
    curl -H "Accept:application/json" -X PUT -d 'profile[address]=adsfad&profile[birthday]=2014-11-1' http://114.215.125.31/api/v1/students/3/profile

    - action: put
    - params:
        - profile[address]= string
        - profile[postalcode]= string
        - profile[birthday]= yyyy-mm-dd
        - profile[gender]= female|male
        - profile[avatar]= base64 file  #TODO，need test
    - response
        #


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

## get work_papers 获取我的作业list（学生）,list 不包括作业详细的多媒体资源路径

    curl -H "Accept:application/json" "http://127.0.0.1:3000/api/v1/students/3/work_papers?page=2" 
    
    - action: get
    - params:
        student_id # students/3
        page= integer
    - response:
        {"work_papers":[{"id":1,"title":"放学后第一课","description":"描述哦说明","paper_type":"sound","created_at":"2015-02-21T01:23:50.000Z","updated_at":"2015-02-21T01:30:02.000Z","teacher_id":4}]}%                                                    

## get work_paper 作业详细
    curl -H "Accept:application/json" "http://127.0.0.1:3000/api/v1/work_papers/1"

    - action: get
    - params:
        work_paper_id # work_papers/1
    -response:
        {"work_paper":{"id":1,"title":"放学后第一课","type":"sound","description":"描述哦说明","teacher":"teacher1","medias":[{"media_resource_id":1,"avatar":"/uploads/media_resource/avatar/1/GTD.jpg"},{"media_resource_id":2,"avatar":null}]}}%
