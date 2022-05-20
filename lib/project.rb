#As a non-profit employee, I want to view, add, update and delete projects.
#As a non-profit employee, I want to add volunteers to a project.

class Project
  attr_reader :id
  attr_accessor :title

  def initialize(attributes)
    @title = attributes.fetch(:title)
    @id = attributes.fetch(:id)
  end

  

end