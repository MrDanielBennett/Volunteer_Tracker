class Volunteer
  attr_reader :name, :project_id, :id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @project_id = attributes.fetch(:project_id)
    @id = attributes.fetch(:id)
  end

  def ==(another_volunteer)
    self.name().==(another_volunteer.name()).&self.project_id().==(another_volunteer.project_id)
  end

  def save
    result = DB.exec("INSERT INTO volunteers(name, project_id) VALUES ('#{@title}', '#{@project_id}') RETURNING id;")
    @name = result.first.fetch("name")
    @project_id = result.first.fetch("project_id")
    @id = result.first().fetch("id").to_i()
  end
end
