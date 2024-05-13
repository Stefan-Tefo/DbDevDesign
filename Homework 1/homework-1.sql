CREATE TABLE IF NOT EXISTS student(
	id SERIAL PRIMARY KEY,
	first_name VARCHAR(20) NULL,
	last_name VARCHAR(30) NULL,
	date_of_birth TIMESTAMPTZ NOT NULL,
	enrolled_date TIMESTAMPTZ NOT NULL,
	gender ENUM("M","F") NOT NULL,
	national_id_number SMALLINT NOT NULL,
	student_card_number SMALLINT NOT NULL
);

CREATE TABLE IF NOT EXISTS teacher(
	id SERIAL PRIMARY KEY,
	first_name VARCHAR(20) NULL,
	last_name VARCHAR(30) NULL,
	date_of_birth TIMESTAMPTZ NOT NULL,
	academic_rank ENUM("student","teacher") NOT NULL,
	hire_date TIMESTAMPTZ NOT NULL
);

CREATE TABLE IF NOT EXISTS grade_details(
	id SERIAL PRIMARY KEY,
	grade_id SMALLINT NOT NULL,
	achivement_type_id SMALLINT NOT NULL,
	achivment_points FLOAT NULL,
	achivment_max_points SMALLINT NULL,
	achivment_date TIMESTAMPTZ NOT NULL	
);

CREATE TABLE IF NOT EXISTS course(
	id SERIAL PRIMARY KEY,
	name VARCHAR(20) NULL,
	credit SMALLINT  NULL,
	academic_year TIMESTAMPTZ NULL,
	semester TIMESTAMPTZ NULL
);

CREATE TABLE IF NOT EXISTS grade(
	id SERIAL PRIMARY KEY,
	student_id SMALLINT NOT NULL,
	course_id SMALLINT NOT NULL,
	teacher_id SMALLINT NOT NULL,
	grade ENUM("A","B","C","D","F") NOT NULL,
	comment VARCHAR(100) NULL,
	create_date TIMESTAMPTZ NOT NULL
);

CREATE TABLE IF NOT EXISTS achivment_type(
	id SERIAL PRIMARY KEY,
	name VARCHAR(20) NOT NULL,
	description VARCHAR(100) NULL,
	participation_rate FLOAT NOT NULL
);