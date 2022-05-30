require('sinatra')
require('sinatra/reloader')
require('./lib/project')
require('./lib/volunteer')
require('pry')
require('pg')
also_reload('lib/**/*.rb')

DB = PG.connect({:dbname => "volunteer_tracker"})

# As a non-profit employee, I want to view, add, update and delete projects.
# As a non-profit employee, I want to view and add volunteers.
# As a non-profit employee, I want to add volunteers to a project.

# home page 
get('/') do
  @projects = Project.all
  erb(:projects)
end

get('/projects') do
  @projects = Project.all
  erb(:projects)
end

post('/projects') do
  title = params[:title]
  id = params[:id]
  project = Project.new({:title => title, :id => id})
  project.save
  @projects = Project.all
  erb(:projects)
end

get('/projects/:id') do
  @project = Project.find(params[:id].to_i)
  # @vol = Volunteer.all
  erb(:project)
end

patch('/projects/:id') do
  project = Project.find(params[:id].to_i)
  title = params[:title]
  project.update({:title => title, :id =>project.id})
  @projects = Project.all
  erb(:projects)
end

# specify which params to pull out of update submission
delete('/projects/:id') do
  @project = Project.find(params[:id].to_i)
  @project.delete()
  @projects = Project.all
  erb(:projects)
end

get('/projects/:id/edit') do
  @project = Project.find(params[:id].to_i)
  erb(:edit_project)
end


get('/projects/:id/volunteers/:vol_id') do
  @vol = Volunteer.find(params[:vol_id].to_i)
  erb(:volunteer)
end

post('/projects/:id/volunteers') do
  @project = Project.find(params[:id].to_i)
  volunteer = Volunteer.new({:name => params[:name], :project_id => @project.id, :id => nil})
  volunteer.save
  erb(:project)
end