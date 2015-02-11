#### 服务器地址 http://114.215.125.31

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