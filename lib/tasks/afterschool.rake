namespace :afterschool do
  
  task import_student: :environment do
    
    email = 1
    filename = "db/#{ENV['foo']}.csv"
    
    CSV.foreach(filename) do |row|
      u = Student.new
      u.nickname = row[1] + ' ' + row[2]
      u.email = '0302' + email.to_s + '@email.com'
      u.role = 'student'
      u.school_class_id = 3
      u.password = '12345678'
      u.save!

      email = email + 1
      puts u.nickname

    end
  end

end
