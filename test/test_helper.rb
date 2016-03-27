ENV['RACK_ENV'] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)

require 'minitest/autorun'
require 'minitest/pride'
require 'capybara/dsl'
require 'tilt/erb'
require 'launchy'
require 'pry'

Capybara.app = RobotApp

module TestHelpers

  def teardown
    robot_manager.delete_all
    super
  end

  def robot_manager
    database = Sequel.sqlite('db/robot_manager_test.sqlite')
    @robot_manager ||= RobotManager.new(database)
  end

  def create_robots(number)
    number.times do |num|
      robot_manager.create({
        :name       => "Robot #{num}",
        :city       => "Denver #{num}",
        :state      => "CO #{num}",
        :avatar     => "http://www.robohash.org/Robot#{num}",
        :birthdate  => "12/06/1981",
        :date_hired => "02/01/2016",
        :department => "HR#{num}"})
    end
  end

end
