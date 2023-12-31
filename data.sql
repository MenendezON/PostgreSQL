/* Populate database with sample data. */

INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES 
    (1, 'Agumon', '2020-02-03', 0, true, 19.23), 
    (2, 'Gabumon', '2018-10-15', 2, true, 8),
    (3, 'Pikachu', '2021-01-07', 1, false, 15.04), 
    (4, 'Devimon', '2017-05-12', 5, true, 11);



INSERT INTO animals (id, name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES 
(5, 'Charmander', '2020-02-08', 0, false, -11),
(6, 'Plantmon', '2021-11-15', 2, true, -5.7),
(7, 'Squirtle', '1993-04-02', 3, false, -12.13),
(8, 'Angemon', '2005-06-12', 1, true, -45),
(9, 'Boarmon', '2005-06-07', 7, true, 20.4),
(10, 'Blossom', '1998-10-13', 3, true, 17),
(11, 'Ditto', '2022-05-14', 4, true, 22);


INSERT INTO owners (full_name, age) VALUES ('Sam Smith', 34), ('Jennifer Orwell', 19), ('Bob', 45), ('Melody Pond', 77), ('Dean Winchester', 14), ('Jodie Whittaker', 38);

INSERT INTO species (name) VALUES ('Pokemon'), ('Digimon');

UPDATE animals SET species_id = (
    CASE
        WHEN name ILIKE '%mon' THEN (SELECT id FROM species WHERE name = 'Digimon')
        ELSE (SELECT id FROM species WHERE name = 'Pokemon')
    END
);

UPDATE animals SET owner_id = (
    CASE
        WHEN name IN ('Agumon') THEN (SELECT id FROM owners WHERE full_name = 'Sam Smith')
        WHEN name IN ('Gabumon', 'Pikachu') THEN (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
        WHEN name IN ('Devimon', 'Plantmon') THEN (SELECT id FROM owners WHERE full_name = 'Bob')
        WHEN name IN ('Charmander', 'Squirtle', 'Blossom') THEN (SELECT id FROM owners WHERE full_name = 'Melody Pond')
        WHEN name IN ('Angemon', 'Boarmon') THEN (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
    END
);

INSERT INTO vets (name, age, date_of_graduation) VALUES 
('Vet William Tatcher', 45, '2000-04-23'), ('Vet Maisy Smith', 26, '2019-01-17'), ('Vet Stephanie Mendez', 64, '1981-05-04'), ('Vet Jack Harkness', 38, '2008-06-08');

INSERT INTO specializations (vet_id, species_id) VALUES (1, 1), (3, 2), (3, 1), (4, 2);

INSERT INTO visits (vet_id, animal_id, visit_date)
VALUES
    (1, 1, '2020-05-24'), (3, 1, '2020-07-22'),
    (4, 2, '2021-02-02'), (2, 3, '2020-01-05'),
    (2, 3, '2020-03-08'), (2, 3, '2020-05-14'),
    (3, 4, '2021-05-04'), (4, 5, '2021-02-24'),
    (2, 6, '2019-12-21'), (1, 6, '2020-08-10'),
    (2, 6, '2021-04-07'), (3, 7, '2019-09-29'),
    (4, 8, '2020-10-03'), (4, 8, '2020-11-04'),
    (2, 9, '2019-01-24'), (2, 9, '2019-05-15'),
    (2, 9, '2020-02-27'), (2, 9, '2020-08-03'),
    (3, 10, '2020-05-24'), (1, 10, '2021-01-11');
