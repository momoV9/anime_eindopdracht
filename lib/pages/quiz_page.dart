import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  bool _quizStarted = false;

  final List<Question> _easyQuestions = const [
    Question(
      text: 'In which anime series does the character Monkey D. Luffy appear?',
      choices: ['One Piece', 'Naruto', 'Bleach', 'Attack on Titan'],
      correctAnswerIndex: 0,
    ),
    Question(
      text: 'Who is the main protagonist of the anime series "Naruto"?',
      choices: ['Naruto Uzumaki', 'Sasuke Uchiha', 'Kakashi Hatake', 'Itachi Uchiha'],
      correctAnswerIndex: 0,
    ),

  ];

  final List<Question> _mediumQuestions = const [
    Question(
      text: 'What is the name of the shinigami who gives Ichigo Kurosaki his powers in the anime "Bleach"?',
      choices: ['Rukia Kuchiki', 'Yoruichi Shihouin', 'Sosuke Aizen', 'Urahara Kisuke'],
      correctAnswerIndex: 0,
    ),
    Question(
      text: 'Who is the captain of Squad 10 in the Gotei 13 in the anime "Bleach"?',
      choices: ['Byakuya Kuchiki', 'Toshiro Hitsugaya', 'Retsu Unohana', 'Kensei Muguruma'],
      correctAnswerIndex: 1,
    ),

  ];

  final List<Question> _hardQuestions = const [
    Question(
      text: 'What is the full name of the main character in the anime "Attack on Titan"?',
      choices: ['Eren Yeager', 'Armin Arlert', 'Mikasa Ackerman', 'Levi Ackerman'],
      correctAnswerIndex: 0,
    ),
    Question(
      text: 'Which anime features the character "Spike Spiegel" as its main protagonist?',
      choices: ['One Piece', 'Cowboy Bebop', 'Dragon Ball Z', 'Death Note'],
      correctAnswerIndex: 1,
    ),

  ];

  List<Question>? _currentQuestions;

  void _startQuiz(List<Question> questions) {
    setState(() {
      _quizStarted = true;
      _currentQuestionIndex = 0;
      _score = 0;
      _currentQuestions = questions;
    });
  }

  void _checkAnswer(int selectedAnswerIndex) {
    if (selectedAnswerIndex == _currentQuestions![_currentQuestionIndex].correctAnswerIndex) {

      setState(() {
        _score++;
      });
    }
    _goToNextQuestion();
  }

  void _goToNextQuestion() {
    setState(() {
      if (_currentQuestionIndex < _currentQuestions!.length - 1) {
        _currentQuestionIndex++;
      } else {

        _showQuizResult();
      }
    });
  }

  void _showQuizResult() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Quiz Result'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Your score: $_score/${_currentQuestions!.length}'),
              const SizedBox(height: 16),
              Text(
                _getQuizResultMessage(),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          actions: [
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String _getQuizResultMessage() {
    double percentage = (_score / _currentQuestions!.length) * 100;
    if (percentage >= 80) {
      return 'Congratulations! You did an amazing job!';
    } else if (percentage >= 50) {
      return 'Good job! You did well!';
    } else {
      return 'Keep practicing! You can improve!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quizzes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Choose a Quiz',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _startQuiz(_easyQuestions),
              child: const Text('Easy Quiz'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => _startQuiz(_mediumQuestions),
              child: const Text('Medium Quiz'),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              onPressed: () => _startQuiz(_hardQuestions),
              child: const Text('Hard Quiz'),
            ),
            if (_quizStarted)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Text(
                    'Question ${_currentQuestionIndex + 1}/${_currentQuestions!.length}',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _currentQuestions![_currentQuestionIndex].text,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(height: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: _currentQuestions![_currentQuestionIndex].choices.map((choice) {
                      int choiceIndex = _currentQuestions![_currentQuestionIndex].choices.indexOf(choice);
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(12),
                          ),
                          child: Text(
                            choice,
                            style: const TextStyle(fontSize: 16),
                          ),
                          onPressed: () {
                            _checkAnswer(choiceIndex);
                          },
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class Question {
  final String text;
  final List<String> choices;
  final int correctAnswerIndex;

  const Question({required this.text, required this.choices, required this.correctAnswerIndex});
}
