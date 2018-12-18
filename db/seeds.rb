require('pry-byebug')
require_relative('../models/owner')
require_relative('../models/pet')

Owner.delete_all
Pet.delete_all

owner1 = Owner.new({'name' => 'Andrea'})
owner1.save

owner2 = Owner.new({'name' => 'Georgia'})
owner2.save

pet1 = Pet.new({
  'pet_name' => 'Teea',
  'pet_type' => 'cat',
  'admision_date' => '1 May 2018',
  'adoptable' => true,
  'owner_id' => owner1.id
  })

  pet1.save
  #binding.pry
  # nil
  pet2 = Pet.new({
  'pet_name' => 'Rex',
  'pet_type' => 'dog',
  'admision_date'=> '1 November 2018',
  'adoptable' => true,
  'owner_id' => owner2.id
  })
  pet2.save


  pet3 = Pet.new({
  'pet_name' => 'Pisi',
  'pet_type' => 'cat',
  'admision_date'=> '28 July 2017',
  'adoptable' => false,
   'owner_id' => nil
  })
  pet3.save
