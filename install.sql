DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS category;
DROP TABLE IF EXISTS content;
DROP TABLE IF EXISTS access;

CREATE TABLE users
(
    id TEXT,
    pseudo TEXT,
    email TEXT,
    password CHAR(256),
    type TEXT
    CONSTRAINT pk_users PRIMARY KEY (id),
    CONSTRAINT uq_users_pseudo UNIQUE (pseudo),
    CONSTRAINT uq_users_email UNIQUE (email),
    CONSTRAINT check_is_mail CHECK (email LIKE '%@%.%')
);

CREATE TABLE category
(
    id SERIAL,
    name TEXT,
    CONSTRAINT pk_category PRIMARY KEY (id),
    CONSTRAINT uq_category_name UNIQUE (name)
);

CREATE TABLE content
(
    id TEXT,
    title TEXT,
    poster_url TEXT,
    vote_avg NUMERIC,
    langage TEXT,
    original_langage TEXT,
    category_id INT,
    CONSTRAINT pk_content PRIMARY KEY (id),
    CONSTRAINT fk_content_category FOREIGN KEY (category_id) REFERENCES category(id),
    CONSTRAINT check_vote_avg CHECK (vote_avg >= 0 AND vote_avg <= 10)
);

CREATE TABLE access
(
    user_id TEXT,
    content_id TEXT,
    CONSTRAINT pk_access PRIMARY KEY (user_id, content_id),
    CONSTRAINT fk_access_user FOREIGN KEY (user_id) REFERENCES users(id),
    CONSTRAINT fk_access_content FOREIGN KEY (content_id) REFERENCES content(id)
);