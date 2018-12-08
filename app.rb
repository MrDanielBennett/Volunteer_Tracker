require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/project")
require("./lib/volunteer")
require("pg")

DB = PG.connect({:dbname => "volunteer_tracker"})

get ('/') do
  @projects = Project.all
  @volunteer = Volunteer.all
  (erb :index)
end

post ('/new_project') do
  title = params.fetch('title')
  project = Project.new({:title => title, :id => nil})
  project.save
  @project = Project.all
  @volunteer = Volunteer.all
  redirect '/'
end

get ('/projects/:id') do
  id = params[:id].to_i
  @project = Project.find(id)
  erb (:project_details)
end

patch ('/project_details/:id') do
  title = params.fetch("title")
  id = params[:id].to_i
  @project = Project.find(id)
  @project.update({:title => title, :id => nil})
  @projects = Project.all
  @volunteers = Volunteer.all
  erb (:index)
end
