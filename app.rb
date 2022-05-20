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

get('/projects/:id/edit') do
  @projects = Project.find(params[:id].to_i)
  erb(:edit_project)
end


get('/projects/:id') do
  @projects = Project.find(params[:id].to_i)
  erb(:project)
end

post('/projects') do
  title = params[:title]
  id = params[:id]
  project = Project.new({:title => title, :id => id})
  project.save
  @projects = Project.all
  erb(:projects)
end


patch('/projects/:id') do
  @project = Project.find(params[:id].to_i())
  @project.update(params[:title])
  @projects = Project.all
  erb(:project)
end

delete('/projects/:id') do
  @project = Project.find(params[:id])
  @project.delete()
  @projects = Project.all
  erb(:projects)
end
