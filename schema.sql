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
