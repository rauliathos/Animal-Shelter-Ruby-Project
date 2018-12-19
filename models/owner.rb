require_relative('../db/sql_runner.rb')
require_relative('./pet')


class Owner


  attr_accessor :name, :id


  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']


  end

  def pets
   sql = "SELECT * FROM pets WHERE owner_id = $1"
   values = [@id]
   pet_hashes = SqlRunner.run(sql, values)
   pet_objects = pet_hashes.map{|pet_hash| Pets.new(pet_hash)}
   return pet_objects

  end

  def save
    sql = "INSERT INTO owners(name) VALUES($1)
    RETURNING *"
    values = [@name]
    returned_array = SqlRunner.run(sql, values)
    owner_hash = returned_array[0]
    id_string = owner_hash['id']
    @id = id_string.to_i
  end

  def update()
    sql = "UPDATE owners
    SET name = $1
    WHERE id = $2"
    values = [@name, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM owners
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM owners"
    owner_hashes = SqlRunner.run(sql)
    owner_objects = owner_hashes.map{|person| Owner.new(person)}
    return owner_objects
  end

  def self.find(id)
    sql = "SELECT * FROM owners
    WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    owner_hash = results.first
    owner = Owner.new(owner_hash)
    return owner
  end

  def self.delete_all()
    sql = "DELETE FROM owners"
    SqlRunner.run(sql)
  end


end
