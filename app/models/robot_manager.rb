require 'yaml/store'
require_relative 'robot'
require 'pry'

class RobotManager
    attr_reader :database

    def initialize(database)
      @database = database
    end

    def create(robot)
      database.transaction do
        database['robots'] ||= []
        database['total'] ||= 0
        database['total'] += 1
        database['robots'] << { "id" => database['total'],
                                "name" => robot[:name],
                                "city" => robot[:city],
                                "state" => robot[:state],
                                "avatar" => robot[:avatar],
                                "birthdate" => robot[:birthdate],
                                "date_hired" => robot[:date_hired],
                                "department" => robot[:department]
                              }
      end
  end

  def raw_robots
    database.transaction do
      database['robots'] || []
    end
  end

  def all
    raw_robots.map { |data| Robot.new(data) }
  end

  def raw_robot(id)
    raw_robots.find { |robot| robot["id"] == id }
  end

  def find(id)
    Robot.new(raw_robot(id))
  end

  def update(id, robot)
    database.transaction do
      target = database["robots"].find { |data| data["id"] == id }
      target["name"] = robot[:name]
      target["city"] = robot[:city]
      target["state"] = robot[:state]
      target["avatar"] = robot[:avatar]
      target["birthdate"] = robot[:birthdate]
      target["date_hired"] = robot[:date_hired]
      target["department"] = robot[:department]
    end
  end

  def delete(id)
    database.transaction do
      database['robots'].delete_if { |robot| robot["id"] == id }
    end
  end

end
