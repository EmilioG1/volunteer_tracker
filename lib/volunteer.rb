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

  # def self.all
  #   returned_trains = DB.exec("SELECT * FROM trains;")
  #   trains = []
  #   returned_trains.each() do |train|
  #     name = train.fetch("name")
  #     id = train.fetch("id").to_i
  #     time_id = train.fetch("time_id").to_i
  #     trains.push(Train.new({:name => name, :id => id, :time_id => time_id}))
  #   end
  #   trains
  # end


  def save 
    result = DB.exec("INSERT INTO volunteers (name, project_id) VALUES ('#{name}', #{project_id}) RETURNING id;")
    @id = result.first().fetch("id").to_i
  end
  
end