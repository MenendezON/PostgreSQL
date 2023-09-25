/* Database schema to keep the structure of entire database. */

/* Animals table */
CREATE TABLE animals (
    id INT PRIMARY KEY NOT NULL,
    name varchar(100) NOT NULL,
    date_of_birth date NOT NULL,
    escape_attempts integer NOT NULL,
    neutered boolean NOT NULL,
    weight_kg decimal
);

ALTER TABLE animals ADD species varchar(255);

/* Owners table */
CREATE TABLE owners (
    id SERIAL,
    full_name varchar(100) NOT NULL,
    age int,
    PRIMARY KEY(id)
);

/* Species table */
CREATE TABLE species (
    id SERIAL,
    name varchar(100) NOT NULL,
    PRIMARY KEY(id)
);

ALTER TABLE animals DROP CONSTRAINT animals_pkey;

ALTER TABLE animals DROP COLUMN species;

ALTER TABLE animals ADD COLUMN species_id INTEGER;
ALTER TABLE animals ADD CONSTRAINT fk_species FOREIGN KEY (species_id) REFERENCES species(id);

ALTER TABLE animals ADD COLUMN owner_id INTEGER;
ALTER TABLE animals ADD CONSTRAINT fk_owners FOREIGN KEY (owner_id) REFERENCES owners(id);

ALTER TABLE animals ALTER COLUMN id SET DEFAULT nextval('animals_id_seq'::regclass);
ALTER TABLE animals ADD PRIMARY KEY (id);

/* Species table */
CREATE TABLE vets (
    id SERIAL,
    name varchar(100) NOT NULL,
    age int NOT NULL,
    date_of_graduation date,
    PRIMARY KEY(id)
);

CREATE TABLE specializations (
    vet_id INTEGER,
    species_id INTEGER,
    PRIMARY KEY (vet_id, species_id),
    FOREIGN KEY (vet_id) REFERENCES vets(id),
    FOREIGN KEY (species_id) REFERENCES species(id)
);

CREATE TABLE visits (
    vet_id INTEGER,
    animal_id INTEGER,
    visit_date DATE,
    PRIMARY KEY (vet_id, animal_id, visit_date),
    FOREIGN KEY (vet_id) REFERENCES vets(id),
    FOREIGN KEY (animal_id) REFERENCES animals(id)
);

CREATE INDEX idx_animal_id ON visits(animal_id);
CREATE INDEX idx_vet_id ON visits(vet_id);
CREATE INDEX idx_email ON owners(email);
