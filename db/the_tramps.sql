DROP TABLE if exists pets;
DROP TABLE  if exists owners;

CREATE TABLE owners (
  id SERIAL4 PRIMARY KEY,
  name VARCHAR(255)
);

CREATE TABLE pets (
  id SERIAL4 PRIMARY KEY,
  pet_name  VARCHAR(255),
  pet_type VARCHAR(255),
  admision_date VARCHAR(255),
  adoptable BOOLEAN,
  owner_id INT REFERENCES owners(id) ON DELETE CASCADE
);
