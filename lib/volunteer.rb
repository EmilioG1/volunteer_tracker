#As a non-profit employee, I want to view and add volunteers.
#As a non-profit employee, I want to add volunteers to a project.

class Volunteer

  attr_reader :id, :project_id
  attr_accessor :name

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
    @project_id = attributes.fetch(:project_id)
  end


  def save 
    result = DB.exec("INSERT INTO volunteers (name, project_id) VALUES ('#{name}', #{project_id}) RETURNING id;")
    @id = result.first().fetch("id").to_i
  end
  
end