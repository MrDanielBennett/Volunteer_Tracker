class Volunteer
  attr_reader :name, :project_id, :id

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @project_id = attributes.fetch(:project_id)
    @id = attributes.fetch(:id)
  end

  def self.all
    volunteers = []
    results = DB.exec('SELECT * FROM volunteers;')
    results.each do |result|
      name = result.fetch('name')
      project_id = result.fetch('project_id').to_i
      id = result.fetch('id').to_i
      volunteers.push(Volunteer.new({:name => name, :project_id => project_id, :id => id}))
    end
    volunteers
  end

  def save
    result = DB.exec("INSERT INTO volunteers(name, project_id) VALUES ('#{@name}', '#{@project_id}') RETURNING id;")
    @id = result.first.fetch("id").to_i()
  end

  def self.find(id)
    results = DB.exec("SELECT * FROM volunteers WHERE id = #{id}")
    if results.first
      name = results.first.fetch('name')
      project_id = results.first.fetch('project_id').to_i
      Volunteer.new({:name => name, :project_id => project_id, :id => id})
    end
  end

  def ==(another_volunteer)
    self.name().==(another_volunteer.name()).&self.project_id().==(another_volunteer.project_id)
  end
end
