DROP TABLE IF EXISTS members CASCADE;
CREATE TABLE members (
	member_id SERIAL PRIMARY KEY,
	first_name VARCHAR(100) NOT NULL,
	middle_initial VARCHAR(100) NOT NULL DEFAULT '',
	last_name VARCHAR(100) NOT NULL,
	email_address VARCHAR(200) NOT NULL UNIQUE,
	status VARCHAR(8) NOT NULL DEFAULT 'Active' CHECK(status IN ('Active', 'Inactive', 'Pending')),
	times_logged_in INTEGER NOT NULL DEFAULT 0,
	date_created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	birthday DATE,
	time_of_last_login TIME,
	is_validated BOOLEAN NOT NULL DEFAULT FALSE,
	hashed_password VARCHAR(100) NOT NULL
);

DROP TABLE IF EXISTS chatsettings CASCADE;
CREATE TABLE chatsettings (


);
