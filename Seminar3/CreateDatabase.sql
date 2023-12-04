CREATE TABLE email (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 email VARCHAR(200)
);

ALTER TABLE email ADD CONSTRAINT PK_email PRIMARY KEY (id);


CREATE TABLE instrument (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 brand VARCHAR(200) NOT NULL,
 availability BOOLEAN NOT NULL,
 name_of_instrument VARCHAR(200) NOT NULL,
 rental_price INT NOT NULL
);

ALTER TABLE instrument ADD CONSTRAINT PK_instrument PRIMARY KEY (id);


CREATE TABLE person (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 person_number VARCHAR(13) NOT NULL,
 first_name VARCHAR(200) NOT NULL,
 last_name VARCHAR(200) NOT NULL,
 zip VARCHAR(5) NOT NULL,
 street VARCHAR(200) NOT NULL,
 city VARCHAR(200) NOT NULL
);

ALTER TABLE person ADD CONSTRAINT PK_person PRIMARY KEY (id);


CREATE TABLE person_email (
 email_id INT NOT NULL,
 person_id INT NOT NULL
);

ALTER TABLE person_email ADD CONSTRAINT PK_person_email PRIMARY KEY (email_id,person_id);


CREATE TABLE phone (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 phone_number VARCHAR(200) NOT NULL
);

ALTER TABLE phone ADD CONSTRAINT PK_phone PRIMARY KEY (id);


CREATE TABLE rental (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 return_date TIMESTAMP(10) NOT NULL,
 instrument_id INT NOT NULL
);

ALTER TABLE rental ADD CONSTRAINT PK_rental PRIMARY KEY (id);


CREATE TABLE skill (
 skill_id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 skill_level VARCHAR(200)
);

ALTER TABLE skill ADD CONSTRAINT PK_skill PRIMARY KEY (skill_id);


CREATE TABLE student (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 person_id INT NOT NULL
);

ALTER TABLE student ADD CONSTRAINT PK_student PRIMARY KEY (id);


CREATE TABLE category (
 instrument_id INT NOT NULL,
 category VARCHAR(200) NOT NULL
);

ALTER TABLE category ADD CONSTRAINT PK_category PRIMARY KEY (instrument_id);


CREATE TABLE contact_person (
 student_id INT NOT NULL,
 email VARCHAR(200),
 phone_number VARCHAR(200) NOT NULL
);

ALTER TABLE contact_person ADD CONSTRAINT PK_contact_person PRIMARY KEY (student_id);


CREATE TABLE instructor (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 teaches_ensemble BOOLEAN NOT NULL,
 person_id INT NOT NULL
);

ALTER TABLE instructor ADD CONSTRAINT PK_instructor PRIMARY KEY (id);


CREATE TABLE instruments_played (
 instructor_id INT NOT NULL,
 instrument VARCHAR(200) NOT NULL
);

ALTER TABLE instruments_played ADD CONSTRAINT PK_instruments_played PRIMARY KEY (instructor_id);


CREATE TABLE lesson (
 id INT GENERATED ALWAYS AS IDENTITY NOT NULL,
 location VARCHAR(200) NOT NULL,
 time_slot TIMESTAMP(10) NOT NULL,
 minimum_enrollment INT NOT NULL,
 price INT NOT NULL,
 payment INT NOT NULL,
 instructor_id INT NOT NULL
);

ALTER TABLE lesson ADD CONSTRAINT PK_lesson PRIMARY KEY (id);


CREATE TABLE person_phone (
 phone_id INT NOT NULL,
 person_id INT NOT NULL
);

ALTER TABLE person_phone ADD CONSTRAINT PK_person_phone PRIMARY KEY (phone_id,person_id);


CREATE TABLE sibling (
 student_id INT NOT NULL,
 sibling INT NOT NULL
);

ALTER TABLE sibling ADD CONSTRAINT PK_sibling PRIMARY KEY (student_id,sibling);


CREATE TABLE student_lesson (
 lesson_id INT NOT NULL,
 student_id INT NOT NULL
);

ALTER TABLE student_lesson ADD CONSTRAINT PK_student_lesson PRIMARY KEY (lesson_id,student_id);


CREATE TABLE date_availability (
 instructor_id INT NOT NULL,
 start_time TIMESTAMP(10),
 end_time TIMESTAMP(10)
);

ALTER TABLE date_availability ADD CONSTRAINT PK_date_availability PRIMARY KEY (instructor_id);


CREATE TABLE ensemble (
 lesson_id INT NOT NULL,
 target_genre VARCHAR(200) NOT NULL,
 maximum_enrollment INT NOT NULL
);

ALTER TABLE ensemble ADD CONSTRAINT PK_ensemble PRIMARY KEY (lesson_id);


CREATE TABLE group_lesson (
 lesson_id INT NOT NULL,
 skill_id INT NOT NULL
);

ALTER TABLE group_lesson ADD CONSTRAINT PK_group_lesson PRIMARY KEY (lesson_id);


CREATE TABLE group_lesson_instrument (
 lesson_id INT NOT NULL,
 instrument VARCHAR(200) NOT NULL
);

ALTER TABLE group_lesson_instrument ADD CONSTRAINT PK_group_lesson_instrument PRIMARY KEY (lesson_id);


CREATE TABLE individual_lesson (
 lesson_id INT NOT NULL,
 instrument VARCHAR(200) NOT NULL,
 skill_id INT NOT NULL
);

ALTER TABLE individual_lesson ADD CONSTRAINT PK_individual_lesson PRIMARY KEY (lesson_id);


ALTER TABLE person_email ADD CONSTRAINT FK_person_email_0 FOREIGN KEY (email_id) REFERENCES email (id);
ALTER TABLE person_email ADD CONSTRAINT FK_person_email_1 FOREIGN KEY (person_id) REFERENCES person (id);


ALTER TABLE rental ADD CONSTRAINT FK_rental_0 FOREIGN KEY (instrument_id) REFERENCES instrument (id);


ALTER TABLE student ADD CONSTRAINT FK_student_0 FOREIGN KEY (person_id) REFERENCES person (id);


ALTER TABLE category ADD CONSTRAINT FK_category_0 FOREIGN KEY (instrument_id) REFERENCES instrument (id);


ALTER TABLE contact_person ADD CONSTRAINT FK_contact_person_0 FOREIGN KEY (student_id) REFERENCES student (id);


ALTER TABLE instructor ADD CONSTRAINT FK_instructor_0 FOREIGN KEY (person_id) REFERENCES person (id);


ALTER TABLE instruments_played ADD CONSTRAINT FK_instruments_played_0 FOREIGN KEY (instructor_id) REFERENCES instructor (id);


ALTER TABLE lesson ADD CONSTRAINT FK_lesson_0 FOREIGN KEY (instructor_id) REFERENCES instructor (id);


ALTER TABLE person_phone ADD CONSTRAINT FK_person_phone_0 FOREIGN KEY (phone_id) REFERENCES phone (id);
ALTER TABLE person_phone ADD CONSTRAINT FK_person_phone_1 FOREIGN KEY (person_id) REFERENCES person (id);


ALTER TABLE sibling ADD CONSTRAINT FK_sibling_0 FOREIGN KEY (student_id) REFERENCES student (id);
ALTER TABLE sibling ADD CONSTRAINT FK_sibling_1 FOREIGN KEY (sibling) REFERENCES student (id);


ALTER TABLE student_lesson ADD CONSTRAINT FK_student_lesson_0 FOREIGN KEY (lesson_id) REFERENCES lesson (id);
ALTER TABLE student_lesson ADD CONSTRAINT FK_student_lesson_1 FOREIGN KEY (student_id) REFERENCES student (id);


ALTER TABLE date_availability ADD CONSTRAINT FK_date_availability_0 FOREIGN KEY (instructor_id) REFERENCES instructor (id);


ALTER TABLE ensemble ADD CONSTRAINT FK_ensemble_0 FOREIGN KEY (lesson_id) REFERENCES lesson (id);


ALTER TABLE group_lesson ADD CONSTRAINT FK_group_lesson_0 FOREIGN KEY (lesson_id) REFERENCES lesson (id);
ALTER TABLE group_lesson ADD CONSTRAINT FK_group_lesson_1 FOREIGN KEY (skill_id) REFERENCES skill (skill_id);


ALTER TABLE group_lesson_instrument ADD CONSTRAINT FK_group_lesson_instrument_0 FOREIGN KEY (lesson_id) REFERENCES group_lesson (lesson_id);


ALTER TABLE individual_lesson ADD CONSTRAINT FK_individual_lesson_0 FOREIGN KEY (lesson_id) REFERENCES lesson (id);
ALTER TABLE individual_lesson ADD CONSTRAINT FK_individual_lesson_1 FOREIGN KEY (skill_id) REFERENCES skill (skill_id);

ALTER TABLE person_email ADD CONSTRAINT FK_person_email_email_id FOREIGN KEY (email_id) REFERENCES email (id) ON DELETE CASCADE;
ALTER TABLE person_email ADD CONSTRAINT FK_person_email_person_id FOREIGN KEY (person_id) REFERENCES person (id) ON DELETE CASCADE;

ALTER TABLE rental ADD CONSTRAINT FK_rental_instrument_id FOREIGN KEY (instrument_id) REFERENCES instrument (id);

ALTER TABLE student ADD CONSTRAINT FK_student_person_id FOREIGN KEY (person_id) REFERENCES person (id);

ALTER TABLE category ADD CONSTRAINT FK_category_instrument_id FOREIGN KEY (instrument_id) REFERENCES instrument (id) ON DELETE CASCADE;

ALTER TABLE contact_person ADD CONSTRAINT FK_contact_person_student_id FOREIGN KEY (student_id) REFERENCES student (id);

ALTER TABLE instructor ADD CONSTRAINT FK_instructor_person_id FOREIGN KEY (person_id) REFERENCES person (id);

ALTER TABLE instruments_played ADD CONSTRAINT FK_instruments_played_instructor_id FOREIGN KEY (instructor_id) REFERENCES instructor (id) ON DELETE CASCADE;

ALTER TABLE lesson ADD CONSTRAINT FK_lesson_instructor_id FOREIGN KEY (instructor_id) REFERENCES instructor (id);

ALTER TABLE person_phone ADD CONSTRAINT FK_person_phone_phone_id FOREIGN KEY (phone_id) REFERENCES phone (id) ON DELETE CASCADE;
ALTER TABLE person_phone ADD CONSTRAINT FK_person_phone_person_id FOREIGN KEY (person_id) REFERENCES person (id) ON DELETE CASCADE;

ALTER TABLE sibling ADD CONSTRAINT FK_sibling_student_id FOREIGN KEY (student_id) REFERENCES student (id) ON DELETE CASCADE;
ALTER TABLE sibling ADD CONSTRAINT FK_sibling_sibling FOREIGN KEY (sibling) REFERENCES student (id) ON DELETE CASCADE;

ALTER TABLE student_lesson ADD CONSTRAINT FK_student_lesson_lesson_id FOREIGN KEY (lesson_id) REFERENCES lesson (id) ON DELETE CASCADE;
ALTER TABLE student_lesson ADD CONSTRAINT FK_student_lesson_student_id FOREIGN KEY (student_id) REFERENCES student (id) ON DELETE CASCADE;

ALTER TABLE date_availability ADD CONSTRAINT FK_date_availability_instructor_id FOREIGN KEY (instructor_id) REFERENCES instructor (id) ON DELETE CASCADE;

ALTER TABLE ensemble ADD CONSTRAINT FK_ensemble_lesson_id FOREIGN KEY (lesson_id) REFERENCES lesson (id) ON DELETE CASCADE;

ALTER TABLE group_lesson ADD CONSTRAINT FK_group_lesson_lesson_id FOREIGN KEY (lesson_id) REFERENCES lesson (id) ON DELETE CASCADE;
ALTER TABLE group_lesson ADD CONSTRAINT FK_group_lesson_skill_id FOREIGN KEY (skill_id) REFERENCES skill (skill_id);

ALTER TABLE group_lesson_instrument ADD CONSTRAINT FK_group_lesson_instrument_lesson_id FOREIGN KEY (lesson_id) REFERENCES group_lesson (lesson_id)  ON DELETE CASCADE;

ALTER TABLE individual_lesson ADD CONSTRAINT FK_individual_lesson_lesson_id FOREIGN KEY (lesson_id) REFERENCES lesson (id) ON DELETE CASCADE;
ALTER TABLE individual_lesson ADD CONSTRAINT FK_individual_lesson_skill_id FOREIGN KEY (skill_id) REFERENCES skill (skill_id);

