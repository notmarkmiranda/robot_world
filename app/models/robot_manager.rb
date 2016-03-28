require 'yaml/store'

class RobotManager
    attr_reader :database

    def initialize(database)
      @database = database
    end

    def create(robot)
      database.from(:robots).insert(robot)
    end

  def all
    database.from(:robots).to_a.map { |robot| Robot.new(robot) }
  end

  def find(id)
    raw_robot = database.from(:robots).where(:id => id).to_a.first
    Robot.new(raw_robot)
  end

  def update(id, robot)
    database.from(:robots).where(:id => id).update(robot)
  end

  def delete(id)
    database.from(:robots).where(:id => id).delete
  end

  def delete_all
    database.from(:robots).delete
  end

  def average_age
    if all.size == 0
      0
    else
      all.reduce(0) do |sum, robot|
        sum += robot.age
      end / all.size
    end
  end

  def hired_per_year
    hired_per_year = Hash.new(0)
    all.each do |robot|
      hired_per_year[robot.date_hired.year] += 1
    end
    hired_per_year
  end

  def by_department
    by_department = Hash.new(0)
    all.each do |robot|
      by_department[robot.department] += 1
    end
    by_department
  end

  def by_city
    by_city = Hash.new(0)
    all.each do |robot|
      by_city[robot.city] += 1
    end
    by_city
  end

  def by_state
    by_state = Hash.new(0)
    all.each do |robot|
      by_state[robot.state] += 1
    end
    by_state
  end

end
