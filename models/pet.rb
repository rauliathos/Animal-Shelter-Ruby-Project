require_relative('../db/sql_runner.rb')
require_relative('./owner')


class Pet

  attr_reader :id
  attr_accessor :pet_name, :pet_type, :adoptable, :admision_date, :owner_id


  def initialize(options)
    @id = options['id'].to_i if options['id']
    @pet_name = options['pet_name']
    @pet_type = options['pet_type']
    @admision_date = options['admision_date']
    @adoptable = options['adoptable']
    @owner_id = options['owner_id'].to_i if options['owner_id']
  end

  def owners()
    sql = "SELECT * FROM owners
    WHERE id = $1"
    values = [@owner_id]
    results = SqlRunner.run(sql, values)
    owner_hash = results[0]
    owner = Owner.new(owner_hash)
    return owner
  end

  def save
    sql = "INSERT INTO pets(
    pet_name, pet_type, admision_date, adoptable, owner_id)
    VALUES ($1, $2, $3, $4, $5)
    RETURNING id"
    values = [@pet_name, @pet_type, @admision_date, @adoptable, @owner_id]
    @id = SqlRunner.run(sql,values).first['id'].to_i

  end


  def update()
    sql = "UPDATE pets SET(
    pet_name, pet_type, admision_date, adoptable, owner_id
    ) = ($1, $2, $3, $4, $5)
    WHERE id = $6"
    values = [@pet_name, @pet_type, @admision_date, @adoptable, @owner_id, @id]
    SqlRunner.run(sql, values)
  end

  def delete()
    sql = "DELETE FROM pets
    WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM pets"
    pet_hashes = SqlRunner.run(sql)
    pets = pet_hashes.map { |pet| Pet.new( pet) }
    return pets
  end

  def self.find(id)
    sql = "SELECT *
    FROM pets
    WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    pet_hash = results.first
    pet = Pet.new(pet_hash)
    return pet
  end

  def self.delete_all()
    sql = "DELETE FROM pets"
    SqlRunner.run(sql)
  end


end
