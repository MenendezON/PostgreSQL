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

CREATE TABLE invoice_items (
    id SERIAL,
    unit_price decimal,
    quantity int,
    total_price decimal,
    invoice_id int,
    treatment_id int,
    PRIMARY KEY(id),
    FOREIGN KEY (invoice_id) REFERENCES invoices(id),
    FOREIGN KEY (treatment_id) REFERENCES treatments(id)
);

CREATE TABLE medical_histories_has_treatments (
    medical_history_id int refrences medical_histories(id),
    treatment_id int refrences treatments(id)
    );

CREATE INDEX ON medical_histories (patient_id);
CREATE INDEX ON invoices (medical_history);
CREATE INDEX ON invoice_items (invoice_id);
CREATE INDEX ON invoice_items (treatment_id);
CREATE INDEX ON medical_histories_has_treatments (medical_history_id);
CREATE INDEX ON medical_histories_has_treatments (treatment_id);