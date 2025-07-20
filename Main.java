import javax.swing.*;
import java.awt.*;
import java.sql.*;
import java.util.List;
import java.util.ArrayList;

public class Main {
    public static void main(String[] args) {
        new LoginFrame();
    }
}

// Helper class to manage DB connection
class DBHelper {
    static final String DB_URL = "jdbc:mysql://localhost:3306/quiz";
    static final String USER = "root";
    static final String PASS = "Vineela@123";

    public static Connection getConnection() {
        try {
            return DriverManager.getConnection(DB_URL, USER, PASS);
        } catch (SQLException e) {
            e.printStackTrace();
            return null;
        }
    }
}

// Login Frame
class LoginFrame extends JFrame {
    JTextField userField;
    JPasswordField passField;

    public LoginFrame() {
        setTitle("Login");
        setSize(300, 200);
        setDefaultCloseOperation(EXIT_ON_CLOSE);
        setLayout(new GridLayout(3, 2));

        add(new JLabel("Username:"));
        userField = new JTextField();
        add(userField);

        add(new JLabel("Password:"));
        passField = new JPasswordField();
        add(passField);

        JButton loginBtn = new JButton("Login");
        add(loginBtn);

        loginBtn.addActionListener(_ -> login());

        setVisible(true);
    }

    void login() {
        String username = userField.getText();
        String password = String.valueOf(passField.getPassword());

        try (Connection conn = DBHelper.getConnection()) {
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM users WHERE username = ? AND password = ?");
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                int userId = rs.getInt("id");
                new QuizFrame(userId);
                dispose();
            } else {
                JOptionPane.showMessageDialog(this, "Invalid credentials.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

// Quiz Frame
class QuizFrame extends JFrame {
    List<Question> questions;
    List<String> userAnswers = new ArrayList<>();
    int currentQuestion = 0;
    int score = 0;
    int userId;
    int quizId = 1;

    JLabel questionLabel;
    JRadioButton optA, optB, optC, optD;
    ButtonGroup options;

    JLabel timerLabel;
    Timer countdownTimer;
    int timeLeft = 60;

    public QuizFrame(int userId) {
        this.userId = userId;

        setTitle("Quiz");
        setSize(500, 300);
        setDefaultCloseOperation(EXIT_ON_CLOSE);
        setLayout(new BorderLayout());

        questions = fetchQuestions();

        questionLabel = new JLabel();
        optA = new JRadioButton();
        optB = new JRadioButton();
        optC = new JRadioButton();
        optD = new JRadioButton();

        options = new ButtonGroup();
        options.add(optA);
        options.add(optB);
        options.add(optC);
        options.add(optD);

        JPanel centerPanel = new JPanel(new GridLayout(6, 1));
        centerPanel.add(questionLabel);
        centerPanel.add(optA);
        centerPanel.add(optB);
        centerPanel.add(optC);
        centerPanel.add(optD);

        timerLabel = new JLabel("Time Left: 60", SwingConstants.CENTER);
        timerLabel.setFont(new Font("Arial", Font.BOLD, 16));
        centerPanel.add(timerLabel);

        JButton nextBtn = new JButton("Next");
        nextBtn.addActionListener(_ -> {
            stopTimer();
            nextQuestion();
        });

        add(centerPanel, BorderLayout.CENTER);
        add(nextBtn, BorderLayout.SOUTH);

        loadQuestion();

        setVisible(true);
    }

    List<Question> fetchQuestions() {
        List<Question> list = new ArrayList<>();
        try (Connection conn = DBHelper.getConnection()) {
            PreparedStatement ps = conn.prepareStatement("SELECT * FROM questions WHERE quiz_id = ?");
            ps.setInt(1, quizId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                list.add(new Question(
                        rs.getString("question_text"),
                        rs.getString("option_a"),
                        rs.getString("option_b"),
                        rs.getString("option_c"),
                        rs.getString("option_d"),
                        rs.getString("correct_option")
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    void loadQuestion() {
        if (currentQuestion >= questions.size()) {
            endQuiz();
            return;
        }

        Question q = questions.get(currentQuestion);
        questionLabel.setText("Q" + (currentQuestion + 1) + ": " + q.question);
        optA.setText(q.optionA);
        optB.setText(q.optionB);
        optC.setText(q.optionC);
        optD.setText(q.optionD);
        options.clearSelection();

        timeLeft = 60;
        timerLabel.setText("Time Left: " + timeLeft);
        startTimer();
    }

    void startTimer() {
        countdownTimer = new Timer(1000, e -> {
            timeLeft--;
            timerLabel.setText("Time Left: " + timeLeft);
            if (timeLeft <= 0) {
                stopTimer();
                nextQuestion();
            }
        });
        countdownTimer.start();
    }

    void stopTimer() {
        if (countdownTimer != null && countdownTimer.isRunning()) {
            countdownTimer.stop();
        }
    }

    void nextQuestion() {
        String selected = null;
        if (optA.isSelected()) selected = "A";
        else if (optB.isSelected()) selected = "B";
        else if (optC.isSelected()) selected = "C";
        else if (optD.isSelected()) selected = "D";

        userAnswers.add(selected != null ? selected : "X");

        if (selected != null && selected.equalsIgnoreCase(questions.get(currentQuestion).answer)) {
            score++;
        }

        currentQuestion++;
        loadQuestion();
    }

    void endQuiz() {
        stopTimer();
        saveResult();
        dispose();
        new ResultFrame(questions, userAnswers, score);
    }

    void saveResult() {
        try (Connection conn = DBHelper.getConnection()) {
            PreparedStatement ps = conn.prepareStatement("INSERT INTO results(user_id, quiz_id, score) VALUES (?, ?, ?)");
            ps.setInt(1, userId);
            ps.setInt(2, quizId);
            ps.setInt(3, score);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

// Result Frame (Updated to show option text instead of A/B/C/D)
class ResultFrame extends JFrame {
    public ResultFrame(List<Question> questions, List<String> userAnswers, int score) {
        setTitle("Results");
        setSize(600, 400);
        setDefaultCloseOperation(EXIT_ON_CLOSE);
        setLayout(new BorderLayout());

        JTextArea resultArea = new JTextArea();
        resultArea.setEditable(false);

        for (int i = 0; i < questions.size(); i++) {
            Question q = questions.get(i);
            String userAnswer = userAnswers.get(i);
            String userAnswerText = switch (userAnswer) {
                case "A" -> q.optionA;
                case "B" -> q.optionB;
                case "C" -> q.optionC;
                case "D" -> q.optionD;
                default -> "Not Answered";
            };
            String correctAnswerText = switch (q.answer.toUpperCase()) {
                case "A" -> q.optionA;
                case "B" -> q.optionB;
                case "C" -> q.optionC;
                case "D" -> q.optionD;
                default -> "Unknown";
            };

            resultArea.append("Q" + (i + 1) + ": " + q.question + "\n");
            resultArea.append("Your answer: " + userAnswerText + "\n");
            resultArea.append("Correct answer: " + correctAnswerText + "\n\n");
        }

        resultArea.append("Your final score: " + score + "/" + questions.size());

        add(new JScrollPane(resultArea), BorderLayout.CENTER);

        setVisible(true);
    }
}

// Question class
class Question {
    String question, optionA, optionB, optionC, optionD, answer;

    public Question(String question, String a, String b, String c, String d, String answer) {
        this.question = question;
        this.optionA = a;
        this.optionB = b;
        this.optionC = c;
        this.optionD = d;
        this.answer = answer;
    }
}
