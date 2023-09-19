/*Queries that provide answers to the questions FROM all projects.*/

/*Find all animals whose name ends in "mon".*/
SELECT * FROM animals WHERE name LIKE '%mon';

/*List the name of all animals born BETWEEN 2016 AND 2019.*/
SELECT * FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

/*List the name of all animals that are neutered and have less than 3 escape attempts.*/
SELECT * FROM animals WHERE neutered = true AND escape_attempts < 3;

/*List the date of birth of all animals named either "Agumon" or "Pikachu".*/
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';

/*List name and escape attempts of animals that weigh more than 10.5kg*/
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

/*Find all animals that are neutered.*/
SELECT * FROM animals WHERE neutered = true;

/*Find all animals not named Gabumon.*/
SELECT * FROM animals WHERE name != 'Gabumon';

/*Find all animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)*/
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;

/*---------------------*/

BEGIN;

UPDATE animals SET species = 'unspecified';

SELECT species FROM animals;

ROLLBACK;

SELECT species FROM animals;

BEGIN;

UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';

UPDATE animals SET species = 'pokemon' WHERE species IS NULL;

SELECT species FROM animals;

COMMIT;

/*---------------------*/

BEGIN;

SELECT * FROM animals;

DELETE FROM animals;

SELECT * FROM animals;

ROLLBACK;

SELECT * FROM animals;

/*---------------------*/

BEGIN;

DELETE FROM animals WHERE date_of_birth > '2022-01-01';

SAVEPOINT BORNAFTERJAN0122;

UPDATE animals SET weight_kg = weight_kg * -1;

ROLLBACK TO BORNAFTERJAN0122;

UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;

COMMIT;

SELECT * FROM animals;

/*---------------------*/

SELECT count(*) from animals;

SELECT count(*) from animals where escape_attempts = 0;

SELECT avg(weight_kg) from animals;

SELECT max(weight_kg), min(weight_kg)

SELECT neutered, COUNT(*) AS escape_count FROM animals WHERE escape_attempts = 1 GROUP BY neutered ORDER BY escape_count DESC;

SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight FROM animals GROUP BY species;

SELECT species, AVG(escape_attempts) AS avg_escape_attempts FROM (SELECT species, COUNT(*) AS escape_attempts FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species) AS subquery GROUP BY species;

/*---------------------*/

SELECT a.name FROM animals a JOIN owners o ON a.owner_id = o.id WHERE o.full_name = 'Melody Pond';

SELECT a.name FROM animals a JOIN species s ON a.species_id = s.id WHERE s.name = 'Pokemon';

SELECT o.full_name, COALESCE(array_agg(a.name), '{}'::text[]) AS animals_owned FROM owners o LEFT JOIN animals a ON o.id = a.owner_id GROUP BY o.full_name;

SELECT s.name AS species_name, COUNT(*) AS animal_count FROM animals a JOIN species s ON a.species_id = s.id GROUP BY s.name;

SELECT a.name FROM animals a JOIN species s ON a.species_id = s.id JOIN owners o ON a.owner_id = o.id WHERE o.full_name = 'Jennifer Orwell' AND s.name = 'Digimon';

SELECT a.name FROM animals a JOIN owners o ON a.owner_id = o.id WHERE o.full_name = 'Dean Winchester' AND a.escape_attempts = 0;

SELECT o.full_name, COUNT(a.id) AS animal_count FROM owners o LEFT JOIN animals a ON o.id = a.owner_id GROUP BY o.full_name ORDER BY animal_count DESC LIMIT 1;

/*---------------------*/
SELECT * FROM visits INNER JOIN vets ON visits.vet_id = vets.id INNER JOIN animals ON visits.animal_id = animals.id WHERE vets.name='Vet William Tatcher' ORDER BY visit_date DESC LIMIT 1;

SELECT count(distinct(a.name)) from visits vi inner join vets ve on vi.vet_id= ve.id inner join animals a on vi.animal_id=a.id where ve.name='Vet Stephanie Mendez';

SELECT v.name, s.name as specialization FROM vets v LEFT JOIN specializations vs ON v.id = vs.vet_id LEFT JOIN species s ON vs.species_id = s.id group by s.name, v.name;

SELECT a.name AS animal_name FROM visits v JOIN animals a ON v.animal_id = a.id join vets on v.vet_id=vets.id WHERE vets.name = 'Vet Stephanie Mendez' AND v.visit_date BETWEEN '2020-04-01' AND '2020-08-30';

SELECT a.name AS animal_name, COUNT(*) AS visit_count FROM visits v JOIN animals a ON v.animal_id = a.id GROUP BY a.name ORDER BY visit_count DESC LIMIT 1;

SELECT a.name AS animal_name, v.name AS vet_name, MIN(vt.visit_date) AS first_visit_date FROM visits vt JOIN vets v ON vt.vet_id = v.id JOIN animals a ON vt.animal_id = a.id WHERE v.name = 'Vet Maisy Smith' GROUP BY a.name, v.name ORDER BY first_visit_date LIMIT 1;

SELECT a.name AS animal_name, v.name AS vet_name, MAX(vt.visit_date) AS most_recent_visit_date FROM visits vt JOIN vets v ON vt.vet_id = v.id JOIN animals a ON vt.animal_id = a.id GROUP BY a.name, v.name ORDER BY most_recent_visit_date DESC LIMIT 1;

SELECT s.name, count(*) as species_count from vets v left join visits vi on v.id=vi.vet_id left join animals a on vi.animal_id=a.id left join species s on a.species_id=s.id where v.name='Vet Maisy Smith' group by s.name order by species_count desc limit 1;