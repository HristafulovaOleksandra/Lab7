CREATE TABLE student (
                         id SERIAL PRIMARY KEY,
                         name VARCHAR(100) NOT NULL,
                         email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE grade (
                       id SERIAL PRIMARY KEY,
                       subject VARCHAR(100) NOT NULL,
                       score INTEGER CHECK (score BETWEEN 0 AND 100),
                       student_id INTEGER NOT NULL,
                       CONSTRAINT fk_student
                           FOREIGN KEY (student_id)
                               REFERENCES student (id)
                               ON DELETE CASCADE
);