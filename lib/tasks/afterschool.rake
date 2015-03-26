namespace :afterschool do

  task 'csv-import': :environment do
    email = 300

    CSV.foreach('db/students.csv') do |row|
      u = Student.new
      u.nickname = row[2]
      u.email = '20150503' + email.to_s + '@qq.com'
      u.role = 'student'
      u.school_class_id = 4
      u.password = '11111111'
      u.save!

      email = email + 1
      puts u.nickname
    end

  end

end
