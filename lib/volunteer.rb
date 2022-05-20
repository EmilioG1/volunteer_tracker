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

  def ==(vol_to_compare)
    (self.name == vol_to_compare.name) && (self.project_id == vol_to_compare.project_id) && (self.id == vol_to_compare.id)
  end

  def self.all
    returned_vols = DB.exec("SELECT * FROM volunteers;")
    vols = []
    returned_vols.each() do |vol|
      name = vol.fetch("name")
      id = vol.fetch("id").to_i
      project_id = vol.fetch("project_id").to_i
      vols.push(Volunteer.new({:name => name, :id => id, :project_id => project_id}))
    end
    vols
  end


  def save 
    result = DB.exec("INSERT INTO volunteers (name, project_id) VALUES ('#{name}', #{project_id}) RETURNING id;")
    @id = result.first().fetch("id").to_i
  end
  
end