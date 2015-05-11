# API

#### 服务器地址 http://114.215.125.31

对API编号，便于测试跟踪。

# curl 使用说明

    在linux或者osx 下，在命令行窗口直接 copy 下面内容到窗口执行即可

action参数说明：

    列表、详情： get
    新建create：post
    更新update：put

分页统一处理为
    page
    per_page #default 12

# dir

[review](#work_review-老师批阅)

[teacher](#Teacher-老师)

[student](#Student-学生)

[work and paper](#WorkPaper-HomeWork)


## 老师音像资料库

### 列表

    /media

### 搜索

    /media/search

    post
    参数：description

## 导入学生

目前的规则，只支持新建班级，一次导入。
少量学生就手工输入了，老师考虑到较少也暂不支持导入。

入口：

    http://114.215.125.31/tools/import_students
    控制板入口
    http://114.215.125.31/admin/dashboard




## 留言板 posts

### index列表

http://localhost:3000/api/v1/posts?school_class_id=1
返回：
    { media_resources: [ { post_id, urls: [] } ] }

### show详情

http://localhost:3000/api/v1/posts/1

返回：
    { comment_profiles: [ { id, nickname, avatar } ] }

### create发帖

    http://localhost:3000/api/v1/posts

    参数：
    post[title]
    post[body]
    post[user_id]
    post[school_class_id]
    media_resource[avatar][] #多图

### 回帖comment创建
    http://localhost:3000/api/v1/posts/1/comments

    comment[title]
    comment[body]
    comment[user_id]
    comment[post_id]


## get un_review home_works

### all params for un_review

    curl http://127.0.0.1:3000/api/v1/home_works/un_review?student_id=1

    - action: get
    - params:
        student_id
        teacher_id
        school_class_id
        work_paper_id
    - 注释： 如果 teacher_id 和 school_class_id 同时存在则直接输出"老师的某个班级的没有批阅作业"


## work_review 老师批阅


### batch review 批量批阅
     curl -d 'work_review[rate]=5' http://127.0.0.1:3000/api/v1/teachers/2/work_reviews/batch_review?work_paper_id=1

    - action: post
    - params:
        - work_review[rate]=5 # 5-1，代表ABCDE 5个等级（a：5， 1：e）
        - work_review[teacher_id]=2
        - work_review[remark]=string

### update work_review

review默认会创建一个空白的，所以不再提供create接口。

    curl -d 'work_review[rate]=5' http://127.0.0.1:3000/api/v1/home_works/2/work_review

    action见前面curl说明，以后不再说明。

    - params:
        - work_review[rate]=5 # 5-1，代表ABCDE 5个等级（a：5， 1：e）
        - work_review[teacher_id]=1
        - work_review[home_work_id]=2 #home_works/2
        - work_review[remark]=string
        - media_resource[avatar]=file
    - reponse:
        {"work_review":{"home_work_id":2,"id":3,"teacher_id":null,"rate":5,"remark":null,"created_at":"2015-03-05T09:19:27.000Z","updated_at":"2015-03-05T09:19:27.000Z"}}%

### show homework' review
    curl http://127.0.0.1:3000/api/v1/home_works/2/work_review  

    - action: get
    - reponse:
        {"work_review":{"home_work_id":2,"id":3,"teacher_id":null,"rate":5,"remark":null,"created_at":"2015-03-05T09:19:27.000Z","updated_at":"2015-03-05T09:19:27.000Z"},
          "review_medias": [...]}%


### show teacher's reviews
    curl http://127.0.0.1:3000/api/v1/teachers/4/work_reviews

    - action: get
    - params:
        page=1
    - reponse:
        {"work_reviews":[]}%

### delete reviews
    curl -X DELETE http://127.0.0.1:3000/api/v1/home_works/2/work_review  

    -action: delete

## user login/ logout
### user login 登录
    curl -H "Accept:application/json" -d 'user[nickname]=dreamlinx&user[password]=11111111' http://114.215.125.31/api/v1/user_tokens

    - action: post
    - params:
        - user[nickname]=dreamlinx
        - user[password]=11111111
        - (或者 user[email])
    - response:
            #
            {"token":"CUw2vD4UbbrLmrdR6wFw","user_id":1,"user":{"id":1,"nickname":"dreamlinx","phone":null,"created_at":"2015-02-19T04:56:12.000Z","updated_at":"2015-02-19T05:46:29.708Z","email":"dreamlinx@gmail.com","authentication_token":"CUw2vD4UbbrLmrdR6wFw","school_class_id":null,"avatar":{"url":null}}}

### user logout 登出
    curl -H "Accept:application/json" -X DELETE http://114.215.125.31/api/v1/user_tokens/1

    - action: delete
    - params: id # 注意url用法，restful中记录id是直接以 /:id存在的 user_tokens/1
    - response:
        #
        {"success":true}%

## User profile

## Teacher 老师
### get classes of teacher

    curl -H "Accept:application/json" -X GET "http://127.0.0.1:3000/api/v1/teachers/2/school_classes?page=1"

### get all teachers

    curl -H "Accept:application/json" -X GET "http://127.0.0.1:3000/api/v1/teachers?page=1"

    - action: get
    - params:
        page=:id

    - response:
        {"teachers":[{"id":4,"nickname":"teacher1","phone":null,"created_at":"2015-02-21T01:29:48.000Z","updated_at":"2015-03-19T02:55:26.000Z","email":"t1@test.com","authentication_token":"XC5yni3VKeyzersrFQte","school_class_id":null,"role":"teacher"},{"id":7,"nickname":"t2@test.com","phone":null,"created_at":"2015-03-19T02:55:11.000Z","updated_at":"2015-03-20T01:35:50.000Z","email":"t2@test.com","authentication_token":"oRwRb1w_hPc9Dnk7Vqxu","school_class_id":null,"role":"teacher"}],"current_page":1,"per_page":12,"total_entries":2}


### Teacher get info 获取老师基本信息

    curl -H "Accept:application/json" -X GET http://114.215.125.31/api/v1/teachers/1

    - action: get
    - params: id # 注意url用法，restful中记录id是直接以 /:id存在的 teachers/1

### update teacher password 更改老师名密码

    curl -H "Accept:application/json" -X PUT  http://127.0.0.1:3000/api/v1/teachers/3?teacher[email]=test5@gmail.com&teacher[password]=11111111&teacher[password_confirmation]=11111112

    - action: PUT
    - params:
        - id  #students/3 这里的id 就是3
        - teacher[password]= string
        - teacher[password_confirmation]=string
    - reponse

### update teacher profile 更新用户资料
    curl -H "Accept:application/json" -X PUT  'http://114.215.125.31/api/v1/teachers/3/profile?profile[address]=adsfad&profile[birthday]=2014-11-1'

    - action: put
    - params:
        - profile[address]= string
        - profile[postalcode]= string
        - profile[birthday]= yyyy-mm-dd
        - profile[gender]= female|male


### update avatar 更新老师头像
    curl -F 'filename=@uploads/media_resource/avatar/1/IMG_0309.JPG' 'http://127.0.0.1:3000/api/v1/teachers/1/profile/replace_avatar'
    # 如果使用了-F参数，curl就会以 multipart/form-data 的方式发送POST请求。-F参数以name=value的方式来指定参数内容，如果值是一个文件，则需要以name=@file的方式来指定。

    - action: post
    - params:
        - user_id # teachers/1
        - filename= image data # multipart/form-data
    - response

## Student 学生

### 新建学生 create

    /students

    student[nickname]
    student[email]
    student[password]
    student[password_confirmation]
    student[school_class_id]

### get student info 获取学生基本信息

    curl -H "Accept:application/json" -X GET http://114.215.125.31/api/v1/students/1

    - action: get
    - params: id # 注意url用法，restful中记录id是直接以 /:id存在的 students/1
    - response:
        #
        {"student":{"id":3,"nickname":"test2","phone":null,"created_at":"2015-02-20T14:43:13.000Z","updated_at":"2015-02-20T14:51:27.000Z","email":"test3@gmail.com","authentication_token":"yyLyks2giDifPxxuxsVw","school_class_id":null},"profile":{"user_id":3,"avatar":{"url":null},"id":2,"address":null,"birthday":null,"gender":null,"student_number":null,"created_at":"2015-02-20T14:51:27.000Z","updated_at":"2015-02-20T14:51:27.000Z"},"school_class":{"id":4,"class_no":"22222","created_at":"2015-02-20T16:24:40.000Z","updated_at":"2015-02-20T16:24:40.000Z"}}%

### update student password 更改学生名密码

    curl -H "Accept:application/json" -X PUT  http://127.0.0.1:3000/api/v1/students/3?student[email]=test5@gmail.com&student[password]=11111111&student[password_confirmation]=11111112

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

### update students profile 更新用户资料
    curl -H "Accept:application/json" -X PUT  'http://114.215.125.31/api/v1/students/3/profile?profile[address]=adsfad&profile[birthday]=2014-11-1'

    - action: put
    - params:
        - profile[address]= string
        - profile[postalcode]= string
        - profile[birthday]= yyyy-mm-dd
        - profile[gender]= female|male
        - profile[nickname]=
        - profile[email]=
        - profile[school_class_id]=
    - response
        #

### update avatar 更新头像
    curl -F 'profile[avatar]=@uploads/media_resource/avatar/1/IMG_0309.JPG' 'http://127.0.0.1:3000/api/v1/users/1/profile/replace_avatar'
    # 如果使用了-F参数，curl就会以 multipart/form-data 的方式发送POST请求。-F参数以name=value的方式来指定参数内容，如果值是一个文件，则需要以name=@file的方式来指定。

    - action: post
    - params:
        - user_id # users/1
        - profile[avatar]= image data # multipart/form-data
    - response
        #
        {"profile":{"user_id":1,"id":1,"avatar":{"url":"http://7vzqhr.com1.z0.glb.clouddn.com/uploads%2Fprofile%2Favatar%2F1%2FIMG_0309.JPG"},"address":"adsfad","birthday":"2014-11-01T00:00:00.000Z","gender":"","student_number":"","created_at":"2015-02-20T02:54:41.000Z","updated_at":"2015-02-21T16:02:16.957Z","postalcode":null}}%

## get classes 获取班级list
    curl -H "Accept:application/json" http://127.0.0.1:3000/api/v1/school_classes

    - action: get
    - response:
        #
        {"school_classes":[{"id":1,"class_no":"2015","created_at":"2015-02-20T02:38:59.000Z","updated_at":"2015-02-20T02:38:59.000Z"}]}

### get class 获取班级基本信息：老师，学生，作业(TODO)
    curl -H "Accept:application/json" http://127.0.0.1:3000/api/v1/school_classes/1

    - action: get
    - params: id

### get teachers of class

    curl -H "Accept:application/json" http://127.0.0.1:3000/api/v1/school_classes/1/teachers?page=1

    - action: get
    - params:
        page

### get students of class
    curl -H "Accept:application/json" http://127.0.0.1:3000/api/v1/school_classes/1/students

## WorkPaper HomeWork
老师发布的作业， 学生的作业

### get wps of a teacher and a class

http://localhost:3000/api/v1/teachers/2/work_papers?school_class_id=1

### get work_papers 获取我的作业list（学生）,list 不包括作业详细的多媒体资源路径

    curl -H "Accept:application/json" "http://127.0.0.1:3000/api/v1/students/3/work_papers?page=2"

    - action: get
    - params:
        student_id # students/3
        page= integer
    - response:
        {"work_papers":[{"id":1,"title":"放学后第一课","description":"描述哦说明","paper_type":"sound","created_at":"2015-02-21T01:23:50.000Z","updated_at":"2015-02-21T01:30:02.000Z","teacher_id":4}]}%

### get work_paper 作业详细
    curl -H "Accept:application/json" "http://127.0.0.1:3000/api/v1/work_papers/1"

    - action: get
    - params:
        work_paper_id # work_papers/1
    -response:
        {"work_paper":{"id":1,"title":"放学后第一课","type":"sound","description":"描述哦说明","teacher":"teacher1","medias":[{"media_resource_id":1,"avatar":"/uploads/media_resource/avatar/1/GTD.jpg"},{"media_resource_id":2,"avatar":null}]}}%

### get homework of work_paper and student
    curl http://127.0.0.1:3000/api/v1/work_papers/1/home_works?student_id=1

    - action:get
    - params
        page=1

### create work_paper 创建作业  
    curl -X POST -d 'work_paper[title]=test&work_paper[description]=111111&work_paper[paper_type]=' http://127.0.0.1:3000/api/v1/teachers/3/work_papers

    action: POST
    params:
        - teacher_id: #teachers/3
        - work_paper[title]
        - work_paper[description]
        - work_paper[paper_type]
        - school_class_ids=1,2,3

### create workpaper media
    curl -F 'media_resource[avatar]=@public/uploads/media_resource/avatar/1/IMG_0309.JPG' -F 'media_resource[work_paper_id]=2'  'http://127.0.0.1:3000/api/v1/work_papers/1/media_resources'

    - action: POST
    - params: work_paper_id # home_works/1
    - media_resource[avatar]=file
    - media_resource[description]

### get student's homeworks

    curl http://127.0.0.1:3000/api/v1/students/3/home_works
    get

### get homeworks of WorkPaper

    /api/v1/work_papers/:id/home_works
    action: get
    params:
        page=1

### get homework detail(include comments)

    curl http://127.0.0.1:3000/api/v1/home_works/1
    get

### create homework

    curl -X POST -d 'home_work[title]=test&home_work[work_paper_id]=&home_work[description]' http://127.0.0.1:3000/api/v1/students/3/home_works

    - action: post
    - params:
        title
        description
        work_paper_id

    - response:
    {"home_work":{"id":3,"title":"test","description":null,"student_id":3,"work_paper_id":null,"created_at":"2015-03-02T11:23:40.272Z","updated_at":"2015-03-02T11:23:40.272Z","state":null}}%

### create homework media
    curl -F 'media_resource[avatar]=@public/uploads/media_resource/avatar/1/IMG_0309.JPG' -F 'media_resource[home_work_id]=2'  'http://127.0.0.1:3000/api/v1/home_works/1/media_resources'

    - action: POST
    - params: home_work_id # home_works/1
    - media_resource[avatar]=file
    - media_resource[description]
    - response
        {"media_resource":{"id":11,"created_at":"2015-03-02T11:12:21.480Z","updated_at":"2015-03-02T11:12:21.480Z","avatar":{"url":"http://7vzqhr.com1.z0.glb.clouddn.com/uploads%2Fmedia_resource%2Favatar%2F11%2FIMG_0309.JPG"},"work_paper_id":2,"description":null,"media_resourceable_id":1,"media_resourceable_type":"HomeWork"}}%

### DELETE homework

    curl -X DELETE http://127.0.0.1:3000/api/v1/home_works/1
    - action: DELETE

## Message 消息

消息类型message_type：
- 置顶 TOP
- 无置顶：NOTOP


### MSG1 获取用户消息详情

    curl http://127.0.0.1:3000/api/v1/user_messages/3

### MSG2 获取用户消息
    teacher
    curl http://127.0.0.1:3000/api/v1/tachers/3/user_messages?page=1&message_type=any

    student
    curl http://127.0.0.1:3000/api/v1/students/4/user_messages?page=1

    action: get



    字段解释： received_messagable_id 收到消息的user id（老师或者学生都是user的继承类）
    send_messagable_id 发出消息的user id

### MSG3 发消息给个人

    curl -X POST -d 'message_type=any&received_user_id=1&topic=hi&body=teststestsest' http://127.0.0.1:3000/api/v1/teachers/3/send_message_to_person

    action: post
    params:
        received_user_id
        topic
        body

### MSG4 发消息到班级
    curl -X POST -d 'message_type=any&school_class_id=1&topic=hi&body=teststestsest' http://127.0.0.1:3000/api/v1/teachers/3/send_message_to_class

    action: post
    params:
        school_class_id
        topic
        body

#### change log
-2015-03-25
    update message api
-2015-03-21
    update teacher api
    support page
- 2015-03-17
    work pager
- 2015-03-05
    rate
- 2015-2-23
    - replace user to student
    - update avatar
