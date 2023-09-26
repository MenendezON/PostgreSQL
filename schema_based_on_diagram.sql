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

CREATE TABLE invoices (
    id SERIAL,
    total_amount decimal,
    generated_at TIMESTAMP,
    payed_at TIMESTAMP,
    medical_histories int,
    PRIMARY KEY(id),
    FOREIGN KEY (medical_histories) REFERENCES medical_histories(id)
);
