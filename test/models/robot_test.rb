require_relative '../test_helper'

class RobotTest < Minitest::Test
  def test_assigns_attributes_correctly
    robot = Robot.new({ :name       => "John",
                        :city       => "Denver",
                        :state      => "CO",
                        :avatar     => "http://www.robohash.org/John",
                        :birthdate  => Date.strptime("12/06/1981", "%m/%d/%Y"),
                        :date_hired => Date.strptime("02/01/2016", "%m/%d/%Y"),
                        :department => "HR"
                        })

    assert_equal "John", robot.name
    assert_equal "Denver", robot.city
    assert_equal "CO", robot.state
    assert_equal "http://www.robohash.org/John", robot.avatar
    assert_equal "12/06/1981", robot.birthdate.strftime("%m/%d/%Y")
    assert_equal "02/01/2016", robot.date_hired.strftime("%m/%d/%Y")
    assert_equal "HR", robot.department

    assert_equal Float, robot.age.class
  end

end
