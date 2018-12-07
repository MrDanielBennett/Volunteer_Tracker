class Project
  attr_reader :title, :id

  def initialize(attributes)
    @title = attributes.fetch(:title)
    @id = attributes.fetch(:id)
  end

  def save
    result = DB.exec("INSERT INTO projects(title) VALUES ('#{@title}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  def ==(another_project)
    self.title().==(another_project.title())
  end

  def update(attributes)
    @title = attributes.fetch(:title)
    DB.exec("UPDATE projects SET title = '#{@title}' WHERE id = #{@id};")
  end

  def delete
    DB.exec("DELETE FROM projects WHERE id = #{self.id()};")
  end

  def self.find(id)
    results = DB.exec("SELECT * FROM projects WHERE id = #{id}")
    title = results.first.fetch("title")
    id = results.first.fetch("id").to_i
    Project.new({:title => title, :id => id})
  end

  def self.all
    returned_projects = DB.exec("SELECT * FROM projects;")
    projects = []
    returned_projects.each() do |project|
      title = project.fetch("title")
      id = project.fetch("id").to_i()
      projects.push(Project.new({:title => title, :id => id}))
    end
    projects
  end
end
