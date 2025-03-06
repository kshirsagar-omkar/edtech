CREATE TABLE Student (
                         rno SERIAL PRIMARY KEY,
                         name VARCHAR(255) NOT NULL,
                         per FLOAT,
                         username VARCHAR(255) UNIQUE NOT NULL,
                         password VARCHAR(255) NOT NULL
);

INSERT INTO Student (name, per, username, password) VALUES
                                                        ('AAA', 85.6, 'AAA', '123'),
                                                        ('BBB', 92.4, 'BBB', '123'),
                                                        ('CCC', 78.2, 'CCC', '123'),
                                                        ('DDD', 88.9, 'DDD', '123'),
                                                        ('EEE', 74.5, 'EEE', '123');
