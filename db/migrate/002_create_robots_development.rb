require 'sequel'

database = Sequel.sqlite('db/robot_manager_development.sqlite')
database.create_table :robots do
  primary_key :id
  STRING      :name
  STRING      :city
  STRING      :state
  STRING      :avatar
  DATE        :birthdate
  DATE        :date_hired
  STRING      :department
end
