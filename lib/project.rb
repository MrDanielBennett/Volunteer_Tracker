class Project
  attr_reader :title, :id

  def initialize(attributes)
    @title = attributes.fetch(:title)
    @id = attributes.fetch(:id) rescue nil
  end

  def save
    result = DB.exec("INSERT INTO projects(title) VALUES ('#{@title}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  def ==(another_project)
    self.title().==(another_project.title())
  end

  def self.find(id)
    returned_projects = DB.exec("SELECT * FROM projects WHERE id = #{id};")
    return_projects = nil
    returned_projectas.each() do |movie|
      title = project.fetch("title")
      end
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
