INSERT INTO publishers (name, country, founded_year, website) VALUES
    ('Penguin Random House', 'United States', 2013, 'https://www.penguinrandomhouse.com'),
    ('HarperCollins', 'United States', 1989, 'https://www.harpercollins.com'),
    ('Simon & Schuster', 'United States', 1924, 'https://www.simonandschuster.com'),
    ('Hachette Book Group', 'United States', 2006, 'https://www.hachettebookgroup.com'),
    ('Macmillan Publishers', 'United Kingdom', 1843, 'https://www.macmillan.com')
ON CONFLICT DO NOTHING;
