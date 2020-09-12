#### 目前的Api只有用户的登录和注册

#### 模型这边
* profile
* role (Rolify) ability(Cancancan)
* user  STI
	* teacher （role(:techer, :school)）
	* student  (role(:default, :parent)) 

具体看代码 也没有写多少东西在里面 以后说明扔这里？  