#As a non-profit employee, I want to view, add, update and delete projects.
#As a non-profit employee, I want to add volunteers to a project.

class Project
  attr_reader :id
  attr_accessor :title

  def initialize(attributes)
    @title = attributes.fetch(:title)
    @id = attributes.fetch(:id)
  end

  def self.all 
    returned_projects = DB.exec("SELECT * FROM projects;")
    projects = []
    returned_projects.each() do |proj|
      title = proj.fetch("title")
      id = proj.fetch("id").to_i
      projects.push(Project.new({:title => title, :id => id}))
    end
    projects
  end

  def ==(project_to_compare)
    self.title == project_to_compare.title && self.id == project_to_compare.id
  end

  def save 
    result = DB.exec("INSERT INTO projects (title) VALUES ('#{title}') RETURNING id;")
    @id = result.first().fetch("id").to_i
  end

  def self.find(id)
    project = DB.exec("SELECT * FROM projects WHERE id = #{id};").first
    id = project.fetch("id").to_i
    title = project.fetch("title")
    Project.new({:title => title, :id => id})
  end

  def volunteers
    vols = []
    results = DB.exec("SELECT * FROM volunteers WHERE project_id = #{self.id};")
    results.each do |result|
      vol_id = result.fetch("id").to_i
      name = result.fetch("name")
      vols.push(Volunteer.new({:name => name, :project_id => self.id, :id => vol_id}))
    end
    vols
  end

  def update(attributes)
    @title = attributes.fetch(:title)
    DB.exec("UPDATE projects SET title = '#{@title}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM volunteers WHERE project_id = #{@id};")
    DB.exec("DELETE FROM projects WHERE id = #{@id};")
  end

end