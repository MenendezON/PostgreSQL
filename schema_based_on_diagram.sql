CREATE TABLE patients (
    id SERIAL,
    name varchar(200) NOT NULL,
    date_of_birth date,
    PRIMARY KEY(id)
);