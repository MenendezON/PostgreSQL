CREATE TABLE patients (
    id SERIAL,
    name varchar(200) NOT NULL,
    date_of_birth date,
    PRIMARY KEY(id)
);

CREATE TABLE treatments (
    id SERIAL,
    type varchar(100) NOT NULL,
    name varchar(200) NOT NULL,
    PRIMARY KEY(id)
);