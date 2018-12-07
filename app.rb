require("sinatra")
require("sinatra/reloader")
also_reload("lib/**/*.rb")
require("./lib/project")
require("./lib/volunteer")
require("pg")

DB = PG.connect({:dbname => "volunteer_tracker"})

get ('/') do
  @projects = Project.all
  erb :index
end

post ('/') do
  title = params.fetch('title')
  project = Project.new({:title => title, :id => nil})
  project.save

  redirect "/"
end
