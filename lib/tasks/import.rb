email = 200

CSV.foreach('db/13.csv') do |row|
	u = Student.new
	u.nickname = row[2]
	u.email = '20150906'+email.to_s+'@qq.com'
   u.role = 'student'
   u.school_class_id = 9
   u.password = '11111111'
   
   u.save
   email = email +1

   u.profile.gender = row[3]
   u.profile.class_number = row[1]
   u.save
end