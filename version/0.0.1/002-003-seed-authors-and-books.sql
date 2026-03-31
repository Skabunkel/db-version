INSERT INTO authors (name, bio, born_date, country) VALUES
    ('George Orwell', 'English novelist and essayist known for his sharp criticism of political oppression.', '1903-06-25', 'United Kingdom'),
    ('Harper Lee', 'American novelist best known for To Kill a Mockingbird.', '1926-04-28', 'United States'),
    ('Frank Herbert', 'American science fiction author best known for the Dune saga.', '1920-10-08', 'United States'),
    ('Agatha Christie', 'English writer known for her detective novels and short story collections.', '1890-09-15', 'United Kingdom'),
    ('Isaac Asimov', 'American writer and professor of biochemistry, prolific science fiction author.', '1920-01-02', 'United States')
ON CONFLICT DO NOTHING;

INSERT INTO books (title, author_id, publisher_id, genre_id, price, stock, published_date, isbn, page_count) VALUES
    ('1984', 1, 1, 1, 9.99, 120, '1949-06-08', '978-0451524935', 328),
    ('Animal Farm', 1, 1, 1, 7.99, 85, '1945-08-17', '978-0451526342', 112),
    ('To Kill a Mockingbird', 2, 2, 1, 12.99, 200, '1960-07-11', '978-0061120084', 281),
    ('Dune', 3, 3, 3, 14.99, 150, '1965-08-01', '978-0441172719', 688),
    ('Murder on the Orient Express', 4, 2, 5, 10.99, 95, '1934-01-01', '978-0062693662', 274),
    ('And Then There Were None', 4, 2, 5, 10.99, 80, '1939-11-06', '978-0062073488', 272),
    ('Foundation', 5, 1, 3, 11.99, 110, '1951-06-01', '978-0553293357', 244),
    ('I, Robot', 5, 1, 3, 9.99, 70, '1950-12-02', '978-0553294385', 224)
ON CONFLICT DO NOTHING;
