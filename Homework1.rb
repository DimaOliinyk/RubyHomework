require 'date' 

class Student
  @@all = []
  attr_reader :surname
  attr_reader :name
  attr_reader :dateOfBirth

  def initialize(name, surname, dateOfBirth)
    @dateOfBirth = Date.parse(dateOfBirth)

    if calculate_age() < 0 then
      raise ArgumentError, "Invalid date of birth"
    end
    
    @surname = surname
    @name = name
  end

  def calculate_age()
    leapYearDays = ((Date.today.year - self.dateOfBirth.year) / 4).to_i
    years = (Date.today - self.dateOfBirth) / (365 + leapYearDays) 
    years.to_i
  end
  
  def add_student()
    @@all.each{ |x| 
      if x.surname.downcase == self.surname.downcase &&
         x.name.downcase == self.name.downcase && 
         x.dateOfBirth == self.dateOfBirth
      then 
        raise ArgumentError, "Student #{x.to_string()} already exists" 
      end
    }
    @@all << self
    self
  end

  def remove_student()
    @@all.delete(self)
  end

  def get_student_by_age(age)
    students = []

    @@all.each{ |x|
      if x.calculate_age() == age then
        students << x
      end
      }
    students
  end

  def get_student_by_name(name)
    students = []
    
    @@all.each{ |x| 
      if x.name.downcase == name.downcase then 
        students << x
      end
    }
    students
  end

  def to_string() 
    "#{@name} #{@surname} #{calculate_age()}"
  end

  def print()
    puts self.to_string()
  end

  def print_all()
    @@all.each{|x| puts x.to_string()}
  end
end

# ------------ Main ------------- #

student = Student.new("Dima", "Oliinyk", "2005-11-21").add_student()
student2 = Student.new("NotDima", "Oliinyk", "2005-11-21").add_student()
Student.new("Dima", "NotOliinyk", "2005-11-21").add_student()

begin
  Student.new("dIma", "oLIINYK", "2005-11-21").add_student()
rescue Exception => e
  puts e.message
end

student.print_all()
puts()

puts("Removing students")
student2.remove_student()
student.print_all()
puts()

student.get_student_by_name("Dima").each{|x| x.print()}
p student.calculate_age()

begin
  Student.new("Dima", "Oly", "2025-11-21").add_student()
rescue Exception => e
  puts e.message
end
puts()

student.get_student_by_age(18).each{|x| x.print()}
student.get_student_by_age(9).each{|x| x.print()}