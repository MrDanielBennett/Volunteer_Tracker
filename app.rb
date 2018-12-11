require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/project")
require("./lib/volunteer")
require("pg")

DB = PG.connect({:dbname => "volunteer_tracker"})

get ('/') do
  @projects = Project.all
  @volunteers = Volunteer.all
  (erb :index)
end

post ('/new_project') do
  title = params.fetch('title')
  project = Project.new({:title => title, :id => nil})
  project.save
  @projects = Project.all
  @volunteers = Volunteer.all
  redirect '/'
end

post ('/new_volunteer') do
  name = params.fetch("name")
  project_id = params.fetch("project_id")
  volunteer = Volunteer.new({:name => name, :project_id => project_id, :id => nil})
  volunteer.save
  @projects = Project.all
  @volunteers = Volunteer.all
  erb(:index)
end

get ('/edit_volunteer/:id') do
  id = params[:id].to_i
  @volunteer = Volunteer.find(id)
  @projects = Project.all
  erb (:edit_volunteer)
end

patch ('/edit_volunteer/:id') do
name = params.fetch("name")
project_id = params.fetch("project_id").to_i
id = params[:id].to_i
@volunteer = Volunteer.find(id)
@volunteer.update({:name => name, :project_id => project_id, :id => nil})
@projects = Project.all
@volunteers = Volunteer.all
erb (:index)
end
get ('/projects/:id') do
  id = params[:id].to_i
  @project = Project.find(id)
  erb (:project_details)
end

get ('/project/:id/edit') do
  id = params[:id].to_i
  @project = Project.find(id)
  erb (:edit_project)
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

delete ('/project_details/:id') do
  id = params[:id].to_i
  @project = Project.find(id)
  @project.delete
  @projects = Project.all
  @volunteers = Volunteer.all
  erb (:index)
end
