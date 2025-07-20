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

INSERT INTO questions (quiz_id, question_text, option_a, option_b, option_c, option_d, correct_option) VALUES
(1, 'Which planet has the most moons?', 'Mars', 'Saturn', 'Jupiter', 'Venus', 'C'),
(1, 'Who discovered gravity?', 'Albert Einstein', 'Isaac Newton', 'Galileo Galilei', 'Stephen Hawking', 'B'),
(1, 'What is the currency of Japan?', 'Yen', 'Won', 'Rupee', 'Dollar', 'A'),
(1, 'Which metal is liquid at room temperature?', 'Mercury', 'Gold', 'Copper', 'Aluminum', 'A'),
(1, 'Who is known as the Father of Computers?', 'Charles Babbage', 'Alan Turing', 'Tim Berners-Lee', 'Bill Gates', 'A'),
(1, 'How many bones are there in the adult human body?', '206', '201', '210', '199', 'A'),
(1, 'Which country is famous for the Great Pyramid of Giza?', 'India', 'Mexico', 'Egypt', 'Iraq', 'C'),
(1, 'What is the freezing point of water?', '0°C', '32°C', '100°C', '-10°C', 'A'),
(1, 'What is the main gas found in the air we breathe?', 'Oxygen', 'Hydrogen', 'Carbon Dioxide', 'Nitrogen', 'D'),
(1, 'Which famous scientist developed the theory of relativity?', 'Einstein', 'Bohr', 'Tesla', 'Faraday', 'A'),
(1, 'Which is the longest river in the world?', 'Amazon', 'Nile', 'Yangtze', 'Mississippi', 'B'),
(1, 'How many sides does a hexagon have?', '5', '6', '7', '8', 'B'),
(1, 'What is the tallest mountain in the world?', 'K2', 'Kangchenjunga', 'Everest', 'Makalu', 'C'),
(1, 'Which vitamin is produced when a person is exposed to sunlight?', 'Vitamin A', 'Vitamin B', 'Vitamin C', 'Vitamin D', 'D'),
(1, 'What is the main language spoken in Brazil?', 'Spanish', 'English', 'Portuguese', 'French', 'C'),
(1, 'Which blood group is known as the universal donor?', 'A', 'B', 'AB', 'O', 'D'),
(1, 'What is the process by which plants make food?', 'Digestion', 'Respiration', 'Photosynthesis', 'Transpiration', 'C'),
(1, 'Which is the largest planet in our solar system?', 'Earth', 'Mars', 'Jupiter', 'Venus', 'C'),
(1, 'What do bees collect and use to make honey?', 'Pollen', 'Nectar', 'Water', 'Sap', 'B'),
(1, 'Which instrument is used to measure temperature?', 'Thermometer', 'Barometer', 'Speedometer', 'Altimeter', 'A');

