#### 服务器地址 http://114.215.125.31

# curl 使用说明

    在linux或者osx 下，在命令行窗口直接 copy 下面内容到窗口执行即可

## user login
    curl -H "Accept:application/json" -d 'user[nickname]=dreamlinx&user[password]=11111111' http://114.215.125.31/api/v1/user_tokens

    - action: post
    - params: user[nickname]=dreamlinx&user[password]=11111111 (或者 user[email])
    - response:
            {"token":"CUw2vD4UbbrLmrdR6wFw","user_id":1,"user":{"id":1,"nickname":"dreamlinx","phone":null,"created_at":"2015-02-19T04:56:12.000Z","updated_at":"2015-02-19T05:46:29.708Z","email":"dreamlinx@gmail.com","authentication_token":"CUw2vD4UbbrLmrdR6wFw","school_class_id":null,"avatar":{"url":null}}}

## user logout
    curl -H "Accept:application/json" -X DELETE http://114.215.125.31/api/v1/user_tokens/1
    
    - action: delete
    - params: id # 注意url用法，restful中记录id是直接以 /:id存在的 user_tokens/1
    - response:
        {"success":true}%                 


======下面的说明都要替换掉=====================

#### Api List
* student 
	- 获取某个学生的信息
		* `url` http://114.215.125.31/api/v1/students/:id
        * `action` get
        * `response`
        
         ```
            {
                id: 3,
                nickname: xxxxx,
                email: xxxxxx,
                phone: xxxxxx,
                avatar {
                    url: xxxxxx
                }
            }
         ```

* 登录 (这个已经同马同学沟通过了 有问题可以问他)
    * 教师 同学都可以在此登录
        * `url` http://114.215.125.31/api/v1/user_tokens
        * `action` post
        * `response`
        ```
            {
                id: xxx, 
                user_token: xxxxx
            }
        ```

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