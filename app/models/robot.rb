
class Robot
  attr_reader :name,
              :city,
              :state,
              :avatar,
              :birthdate,
              :date_hired,
              :department,
              :age,
              :id

  def initialize(data)
    @id         = data[:id]
    @name       = data[:name]
    @city       = data[:city]
    @state      = data[:state]
    @avatar     = data[:avatar]
    @birthdate  = data[:birthdate]
    @date_hired = data[:date_hired]
    @department = data[:department]
    @age        = age
  end

  def age
    difference = Date.today - @birthdate
    (difference.to_f/365.25).round(2)
  end

end
