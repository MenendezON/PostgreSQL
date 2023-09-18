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

update animals set species = 'unspecified';

SELECT * FROM animals;

ROLLBACK;

SELECT * FROM animals;

BEGIN;

UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';

UPDATE animals SET species = 'pokemon' WHERE species = '';

SELECT * FROM animals;

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

select count(*) from animals;

select count(*) from animals where escape_attempts = 0;

select avg(weight_kg) from animals;

select max(weight_kg), min(weight_kg)

SELECT neutered, COUNT(*) AS escape_count FROM animals WHERE escape_attempts = 1 GROUP BY neutered ORDER BY escape_count DESC;

SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight FROM animals GROUP BY species;

SELECT species, AVG(escape_attempts) AS avg_escape_attempts FROM (SELECT species, COUNT(*) AS escape_attempts FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species) AS subquery GROUP BY species;


