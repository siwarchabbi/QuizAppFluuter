import 'package:flutter/material.dart';
import './question.dart';
import './answer.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  var _questionIndex = 0;
  var _answersChosen = <String>[];
  Color? _backgroundColor;

  void _answerQuestion(String answer, Color? backgroundColor) {
    setState(() {
      if (_questionIndex == 0) {
        _backgroundColor = backgroundColor;
      }
      _answersChosen.add(answer);
      _questionIndex = _questionIndex + 1;
    });
    print(_questionIndex);
    print(_answersChosen);
  }

  void _restartQuiz() {
    setState(() {
      _questionIndex = 0;
      _answersChosen.clear();
      _backgroundColor = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    var questions = [
      {
        'questionText': 'What\'s your favorite Color?',
        'answers': [
          {'text': 'Pink', 'color': Colors.pink},
          {'text': 'Red', 'color': Colors.red},
          {'text': 'Green', 'color': Colors.green},
          {'text': 'Yellow', 'color': Colors.yellow},
        ],
      },
      {
        'questionText': 'What\'s your favorite Animal?',
        'answers': [
          {'text': 'Rabbit'},
          {'text': 'Snake'},
          {'text': 'Elephant'},
          {'text': 'Lion'},
        ],
      },
      {
        'questionText': 'Who\'s your favorite Food?',
        'answers': [
          {'text': 'Koskos' },
          {'text': 'Tajin'},
          {'text': 'Lablebi'},
          {'text': 'Frikasse'},
        ],
      },
    ];

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('My First App'),
        ),
        body: _questionIndex < questions.length
            ? Column(
          children: [
            Question(
              questions[_questionIndex]['questionText'] as String,
            ),
            ...(questions[_questionIndex]['answers'] as List<Map<String, Object>>)
                .map((answer) {
              return Answer(
                      () => _answerQuestion(
                    answer['text'] as String,
                    answer.containsKey('color') ? answer['color'] as Color : null,
                  ),
                  answer['text'] as String);
            }).toList()
          ],
        )
            : Container(
          color: _backgroundColor,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'You\'ve completed the quiz!',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 20),
                Text(
                  'This is so interesting! You like color "${_answersChosen[0]}" which is a really great color, and your favorite animal is "${_answersChosen[1]}". Haha, this is so cute with your favorite food "${_answersChosen[2]}".',
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _restartQuiz,
                  child: Text('Restart Quiz'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
