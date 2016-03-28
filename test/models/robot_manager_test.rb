require_relative '../test_helper'

class RobotManagerTest < Minitest::Test
  include TestHelpers

  def test_it_creates_a_robot
    robot_manager.create({
      :name       => "John",
      :city       => "Denver",
      :state      => "CO",
      :avatar     => "http://www.robohash.org/John",
      :birthdate  => "12/06/1981",
      :date_hired => "02/01/2016",
      :department => "HR"
      })
      id = robot_manager.database.from(:robots).max(:id)
      created_robot = robot_manager.find(id)
      assert_equal "John", created_robot.name
  end

  def test_it_reads_all_robots
    robot_manager.create({
      :name       => "John",
      :city       => "Denver",
      :state      => "CO",
      :avatar     => "http://www.robohash.org/John",
      :birthdate  => "12/06/1981",
      :date_hired => "02/01/2016",
      :department => "HR"
      })
    robot_manager.create({
      :name       => "John2",
      :city       => "Denver2",
      :state      => "CO2",
      :avatar     => "http://www.robohash.org/John2",
      :birthdate  => "12/06/1982",
      :date_hired => "02/01/2017",
      :department => "HR2"
      })
    all_robots = robot_manager.all
    assert_equal 2, all_robots.size
  end

  def test_it_uptdates_a_robot
    robot_manager.create({
      :name       => "John",
      :city       => "Denver",
      :state      => "CO",
      :avatar     => "http://www.robohash.org/John",
      :birthdate  => "12/06/1981",
      :date_hired => "02/01/2016",
      :department => "HR"
      })
    id = robot_manager.database.from(:robots).max(:id)
    og_robot = robot_manager.find(id)
    assert_equal "John", og_robot.name
    robot_manager.update(id, {:name => "Johnny"})
    edited_robot = robot_manager.find(id)
    assert_equal "Johnny", edited_robot.name
  end

  def test_it_deletes_a_robot
    robot_manager.create({
      :name       => "John",
      :city       => "Denver",
      :state      => "CO",
      :avatar     => "http://www.robohash.org/John",
      :birthdate  => "12/06/1981",
      :date_hired => "02/01/2016",
      :department => "HR"
      })
    robot_manager.create({
      :name       => "John2",
      :city       => "Denver2",
      :state      => "CO2",
      :avatar     => "http://www.robohash.org/John2",
      :birthdate  => "12/06/1982",
      :date_hired => "02/01/2017",
      :department => "HR2"
      })
    all_robots_d = robot_manager.all
    assert_equal 2, all_robots_d.size
    id = robot_manager.database.from(:robots).max(:id)
    robot_manager.delete(id)
    all_robots_d = robot_manager.all
    assert_equal 1, all_robots_d.size
  end

  def test_it_can_calculate_average_age
    robot_manager.create({
      :name       => "John",
      :city       => "Denver",
      :state      => "CO",
      :avatar     => "http://www.robohash.org/John",
      :birthdate  => "12/06/1981",
      :date_hired => "02/01/2016",
      :department => "HR",
      })
    robot_manager.create({
      :name       => "John2",
      :city       => "Denver2",
      :state      => "CO2",
      :avatar     => "http://www.robohash.org/John2",
      :birthdate  => "12/06/1982",
      :date_hired => "02/01/2017",
      :department => "HR2",
      })
    robot_manager.average_age
    assert_operator 34.29, :>=, robot_manager.average_age
  end

  def test_it_can_count_hired_per_year
    create_robots(2)
    robot_manager.create({
      :name       => "John2",
      :city       => "Denver2",
      :state      => "CO2",
      :avatar     => "http://www.robohash.org/John2",
      :birthdate  => "12/06/1982",
      :date_hired => "02/01/2015",
      :department => "HR2",
      })

      assert_equal Hash, robot_manager.hired_per_year.class
      assert_equal 2, robot_manager.hired_per_year[2016]
      assert_equal 1, robot_manager.hired_per_year[2015]
  end

  def test_can_separate_robots_by_department
    create_robots(4)

    assert_equal Hash, robot_manager.by_department.class
    assert_equal 1, robot_manager.by_department["HR0"]
    assert_equal 1, robot_manager.by_department["HR1"]
    assert_equal 1, robot_manager.by_department["HR2"]
    assert_equal 1, robot_manager.by_department["HR3"]
    refute_equal 2, robot_manager.by_department["HR0"]
  end

  def test_can_separate_robots_by_city
    create_robots(4)

    assert_equal Hash, robot_manager.by_city.class
    assert_equal 1, robot_manager.by_city["Denver 0"]
    assert_equal 1, robot_manager.by_city["Denver 1"]
    assert_equal 1, robot_manager.by_city["Denver 2"]
    assert_equal 1, robot_manager.by_city["Denver 3"]
    refute_equal 2, robot_manager.by_city["Denver 0"]
  end

end
