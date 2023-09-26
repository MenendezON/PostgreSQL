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

CREATE TABLE medical_histories (
    id SERIAL,
    admitted_at TIMESTAMP,
    patient_id int,
    status varchar(255),
    PRIMARY KEY(id),
    FOREIGN KEY (patient_id) REFERENCES patients(id)
);