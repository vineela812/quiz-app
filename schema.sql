create database quiz;
show tables;
use quiz;
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL
);
CREATE TABLE IF NOT EXISTS quizzes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS questions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    quiz_id INT,
    question_text TEXT NOT NULL,
    option_a VARCHAR(255),
    option_b VARCHAR(255),
    option_c VARCHAR(255),
    option_d VARCHAR(255),
    correct_option CHAR(1),
    FOREIGN KEY (quiz_id) REFERENCES quizzes(id)
);

CREATE TABLE IF NOT EXISTS results (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    quiz_id INT,
    score INT,
    taken_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (quiz_id) REFERENCES quizzes(id)
);

-- Sample data (optional)

INSERT INTO users (username, password) VALUES ('vineela', 'vineela123'),
											  ('nani','nani123');
INSERT INTO quizzes (title) VALUES ('General Knowledge');

INSERT INTO questions (quiz_id, question_text, option_a, option_b, option_c, option_d, correct_option) VALUES
(1, 'What is the capital of France?', 'Berlin', 'Madrid', 'Paris', 'Lisbon', 'C'),
(1, 'Which planet is known as the Red Planet?', 'Earth', 'Mars', 'Jupiter', 'Saturn', 'B'),
(1, 'What is the largest mammal?', 'Elephant', 'Blue Whale', 'Giraffe', 'Hippopotamus', 'B'),
(1, 'Which element has the chemical symbol O?', 'Oxygen', 'Gold', 'Silver', 'Iron', 'A'),
(1, 'Who wrote Hamlet?', 'Charles Dickens', 'William Shakespeare', 'Leo Tolstoy', 'Mark Twain', 'B'),
(1, 'What is the boiling point of water?', '90°C', '80°C', '100°C', '70°C', 'C'),
(1, 'Which country hosted the 2016 Summer Olympics?', 'China', 'Brazil', 'UK', 'USA', 'B'),
(1, 'What is the smallest prime number?', '1', '2', '3', '0', 'B'),
(1, 'Which continent is Egypt located in?', 'Asia', 'Europe', 'Africa', 'Australia', 'C'),
(1, 'Which ocean is the largest?', 'Atlantic', 'Arctic', 'Indian', 'Pacific', 'D'),
(1, 'Who painted the Mona Lisa?', 'Picasso', 'Van Gogh', 'Leonardo da Vinci', 'Michelangelo', 'C'),
(1, 'Which gas do plants absorb from the atmosphere?', 'Oxygen', 'Carbon Dioxide', 'Nitrogen', 'Helium', 'B'),
(1, 'What is the hardest natural substance?', 'Gold', 'Iron', 'Diamond', 'Platinum', 'C'),
(1, 'Which organ purifies blood in the human body?', 'Liver', 'Kidney', 'Lungs', 'Heart', 'B'),
(1, 'What is the largest desert in the world?', 'Sahara', 'Gobi', 'Thar', 'Arctic', 'A'),
(1, 'Who invented the telephone?', 'Edison', 'Bell', 'Newton', 'Tesla', 'B'),
(1, 'What is the square root of 64?', '6', '7', '8', '9', 'C'),
(1, 'What is the chemical formula of water?', 'H2O', 'CO2', 'O2', 'NaCl', 'A'),
(1, 'Which bird is known for its colorful tail?', 'Sparrow', 'Peacock', 'Crow', 'Pigeon', 'B'),
(1, 'How many continents are there on Earth?', '5', '6', '7', '8', 'C');