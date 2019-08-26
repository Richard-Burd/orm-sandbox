/*
1.) Delete the existing database (.db) file in this directory

2.) In bash, type:
    a.) user:~/Desktop/dev/sql-sandbox$ sqlite3 lib_database.db
    b.) user:~/Desktop/dev/sql-sandbox$ sqlite3 lib_database.db < 01_schema_and_data.sql
*/

/* The following tables create the schema needed for the ORM workspace */
CREATE TABLE author (
    id INTEGER PRIMARY KEY,
    name TEXT
);

CREATE TABLE genre (
    id INTEGER PRIMARY KEY,
    name TEXT
);

CREATE TABLE book (
    id INTEGER PRIMARY KEY,
    title TEXT,
    copies_sold INTEGER,
    author_id INTEGER,
    genre_id TEXT
);

CREATE TABLE topic (
    id INTEGER PRIMARY KEY,
    name TEXT,
    book_id INTEGER
);

/* This is a join table that allows you to search topics covered by authors */
CREATE TABLE topic_book_jointable (
    book_id INTEGER,
    topic_id INTEGER
);


/* This is a join table that allows you to search genres covered by authors */
CREATE TABLE topic_book_jointable (
    book_id INTEGER,
    genre_id INTEGER
);

/* These are the values to be entered into the tables above */
INSERT INTO author (name) VALUES ("Alan Watts");
INSERT INTO author (name) VALUES ("Robin Hanson");
INSERT INTO author (name) VALUES ("OttoGhelli");

INSERT INTO genre (name) VALUES ("Humanities");
INSERT INTO genre (name) VALUES ("Cooking");

INSERT INTO book (title, copies_sold, author_id, genre_id) VALUES ("Way of Zen", 3400600, 1, 1);
INSERT INTO book (title, copies_sold, author_id, genre_id) VALUES ("Watercourse Way", 1200400, 1, 1);
INSERT INTO book (title, copies_sold, author_id, genre_id) VALUES ("The Elephant in the Brain", 450200, 2, 1);
INSERT INTO book (title, copies_sold, author_id, genre_id) VALUES ("Age of Id", 200, 2, 1);
INSERT INTO book (title, copies_sold, author_id, genre_id) VALUES ("Jerusalem", 1500200, 3, 2);
INSERT INTO book (title, copies_sold, author_id, genre_id) VALUES ("Palestinian Deserts", 12, 3, 2);

INSERT INTO topic (name) VALUES ("Ego");
INSERT INTO topic (name) VALUES ("Self");
INSERT INTO topic (name) VALUES ("Bias");
INSERT INTO topic (name) VALUES ("Intuition");
INSERT INTO topic (name) VALUES ("Hummus");
INSERT INTO topic (name) VALUES ("Falafel");
INSERT INTO topic (name) VALUES ("Za'atar");
INSERT INTO topic (name) VALUES ("Bak-lawah");

INSERT INTO topic_book_jointable (book_id, topic_id) VALUES (1, 1);
INSERT INTO topic_book_jointable (book_id, topic_id) VALUES (1, 2);

INSERT INTO topic_book_jointable (book_id, topic_id) VALUES (2, 1);
INSERT INTO topic_book_jointable (book_id, topic_id) VALUES (2, 2);

INSERT INTO topic_book_jointable (book_id, topic_id) VALUES (3, 1);
INSERT INTO topic_book_jointable (book_id, topic_id) VALUES (3, 2);
INSERT INTO topic_book_jointable (book_id, topic_id) VALUES (3, 3);
INSERT INTO topic_book_jointable (book_id, topic_id) VALUES (3, 4);

INSERT INTO topic_book_jointable (book_id, topic_id) VALUES (4, 2);
INSERT INTO topic_book_jointable (book_id, topic_id) VALUES (4, 3);
INSERT INTO topic_book_jointable (book_id, topic_id) VALUES (4, 4);

INSERT INTO topic_book_jointable (book_id, topic_id) VALUES (5, 5);
INSERT INTO topic_book_jointable (book_id, topic_id) VALUES (5, 6);
INSERT INTO topic_book_jointable (book_id, topic_id) VALUES (5, 7);

INSERT INTO topic_book_jointable (book_id, topic_id) VALUES (6, 8);

/* This will better display the data */
.mode column 
.headers on

/* Shows what authors wrote what books */
SELECT book.id, book.title AS "Book Title", author.name AS "Author's Name"
FROM book
INNER JOIN author
ON book.author_id = author.id
GROUP BY book.title;

/* Shows what authors write books about each topic */
SELECT topic.id, topic.name AS "Topic", author.name AS "Author's Name"
FROM topic
INNER JOIN topic_book_jointable
ON topic_book_jointable.topic_id = topic.id
INNER JOIN book
ON topic_book_jointable.book_id = book.id
INNER JOIN author
ON book.author_id = author.id
GROUP BY topic.id;

/* Shows how many books each author sold ordered by books sold */
SELECT author.name AS "Author's Name", SUM(book.copies_sold) AS "Total Books Sold"
FROM author
INNER JOIN book 
ON book.author_id = author.id 
GROUP BY author.name HAVING SUM(book.copies_sold);