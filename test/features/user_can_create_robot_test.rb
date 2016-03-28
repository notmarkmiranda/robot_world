require_relative '../test_helper'

class UserCanCreateRobot < Minitest::Test
  include TestHelpers
  include Capybara::DSL

  def test_user_can_create_robot
    visit '/'
    
    first(:link, "Create Robot").click
    fill_in("robot[name]", with: "Mark")
    fill_in("robot[city]", with: "Denver")
    fill_in("robot[state]", with: "CO")
    fill_in("robot[avatar]", with: "http://www.robohash.org/Mark")
    fill_in("robot[birthdate]", with: "12/06/1981")
    fill_in("robot[date_hired]", with: "02/01/2016")
    fill_in("robot[department]", with: "Finance")
    click_button("submit!")

    assert_equal "/robots", current_path
    within ("h3 a") do
      assert page.has_content?("Mark")
    end
  end
end
