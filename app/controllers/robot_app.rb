require 'models/robot_manager'

class RobotApp < Sinatra::Base
  set :root, File.expand_path("..", __dir__)
  set :method_override, true

  get '/' do
    erb :dashboard
  end

  get '/robots/new' do
    erb :new
  end


  get '/robots/:id' do |id|
    @robot = robot_manager.find(id.to_i)
    erb :show
  end


  post '/robots' do
    robot_manager.create(params[:robot])
    redirect '/robots'
  end

  get '/robots/:id/edit' do |id|
    @robot = robot_manager.find(id.to_i)
    erb :edit
  end

  put '/robots/:id' do |id|
    robot_manager.update(id.to_i, params[:robot])
    redirect "/robots/#{id}"
  end

  delete '/robots/:id' do |id|
    robot_manager.delete(id.to_i)
    redirect '/robots'
  end

  get '/robots' do
    @robots = robot_manager.all
    erb :index
  end

  def robot_manager
    database = YAML::Store.new('db/robot_manager')
    @robot_manager ||= RobotManager.new(database)
  end

end
