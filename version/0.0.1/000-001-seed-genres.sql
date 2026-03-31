INSERT INTO genres (name, description) VALUES
    ('Fiction', 'Novels and stories created from the imagination'),
    ('Non-Fiction', 'Factual works based on real events and information'),
    ('Science Fiction', 'Speculative fiction dealing with futuristic concepts'),
    ('Fantasy', 'Fiction involving magical or supernatural elements'),
    ('Mystery', 'Fiction dealing with the solution of a crime or puzzle'),
    ('Biography', 'Detailed account of a person''s life'),
    ('History', 'Works about past events'),
    ('Self-Help', 'Books aimed at personal improvement'),
    ('Horror', 'Fiction intended to frighten or unsettle'),
    ('Romance', 'Fiction centered around romantic relationships')
ON CONFLICT (name) DO NOTHING;
