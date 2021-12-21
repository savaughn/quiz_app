import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

import '../widgets/question.dart';
import '../widgets/answer.dart';
import '../widgets/progress.dart';

class Quiz extends StatefulWidget {
  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  var _questionIndex = 0;
  List questionAnswer = [];
  bool isQuizComplete = false;
  int score = 0;
  List<String> responses = [];

  var _questionsApi = [];

  Future<void> fetchQuestions() async {
    var response = await http.get(Uri.parse(
        'https://opentdb.com/api.php?amount=10&category=9&difficulty=easy&type=multiple'));
    var json = jsonDecode(response.body);
    setState(() {
      _questionsApi.insertAll(0, json['results']);
    });
  }

  @override
  initState() {
    super.initState();
    fetchQuestions();
  }

  void _onRestartQuiz() {
    setState(() {
      isQuizComplete = false;
      _questionIndex = 0;
      score = 0;
    });
  }

  Future<void> _onNewQuiz() async {
    setState(() {
      _questionsApi.clear();
    });
    await fetchQuestions();
    _onRestartQuiz();
  }

  void _onAnswerPress(String answer, bool isCorrect) {
    setState(() {
      _questionIndex++;
      isQuizComplete = _questionIndex == _questionsApi.length;
      if (isCorrect) {
        score++;
      }
      responses.add(answer);
    });
  }

  Widget renderSummary() {
    return (Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: Text(
              'Trivia Complete\n\n$score correct!',
              style: GoogleFonts.londrinaSolid(
                color: Colors.white,
                fontSize: 48,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                width: double.infinity,
                child: RaisedButton(
                  onPressed: _onRestartQuiz,
                  elevation: 3,
                  // padding: const EdgeInsets.all(5),
                  child: Text(
                    'Restart Trivia',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue[50],
                    ),
                  ),
                  color: Colors.blue[400],
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.all(20),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                width: double.infinity,
                child: RaisedButton(
                  onPressed: _onNewQuiz,
                  elevation: 3,
                  // padding: const EdgeInsets.all(5),
                  child: Text(
                    'New Trivia',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue[50],
                    ),
                  ),
                  color: Colors.blue[400],
                  padding: EdgeInsets.all(20),
                  shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(15),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ));
  }

  List markCorrectAnswer(List answers) {
    List _answersList = [];
    for (var i = 0; i < answers.length; i++) {
      _answersList.add({'answer': answers[i], 'isCorrect': i == 0});
    }
    return _answersList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Trivia'),
      ),
      body: Container(
          color: Colors.blueGrey,
          padding: const EdgeInsets.only(bottom: 5, left: 10, right: 10),
          child: !isQuizComplete && _questionsApi.length != 0
              ? Column(
                  children: [
                    Question(_questionsApi[_questionIndex]['question']),
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          ...markCorrectAnswer([
                            _questionsApi[_questionIndex]['correct_answer'],
                            ..._questionsApi[_questionIndex]
                                ['incorrect_answers']
                          ]).map((answer) {
                            return Answer(_onAnswerPress, answer['answer'],
                                answer['isCorrect']);
                          }).toList(),
                          ProgressBar(
                            count: _questionIndex + 1,
                            total: _questionsApi.length,
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : renderSummary()),
    );
  }
}
