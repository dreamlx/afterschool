email = 200

CSV.foreach('db/12.csv') do |row|
	u = Student.new
	u.nickname = row[2]
	u.email = '20150503'+email.to_s+'@qq.com'
   u.role = 'student'
   u.school_class_id = 4
   u.password = '11111111'
   
   u.save
   email = email +1
end