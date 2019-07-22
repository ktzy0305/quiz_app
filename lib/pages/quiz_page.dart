import 'package:flutter/material.dart';
import '../models/question.dart';
import '../models/quiz.dart';
import '../components/answer_button.dart';
import '../components/question_text.dart';
import '../components/validity_overlay.dart';
import './landing_page.dart';
import './score_page.dart';

class QuizPage extends StatefulWidget{
  @override
  State createState() => new QuizPageState();
}

class QuizPageState extends State<QuizPage>{

  Question currentQuestion;
  Quiz quiz = new Quiz([
    new Question("1 + 1 = 2", true),
    new Question("An enemy's enemy is your best friend.", false),
    new Question("AI will take over all jobs by 2030.", false),
    new Question("Pizza originated from Italy.", true),
    new Question("Mario was first introduced in Super Mario Bros in 1985.", false)
  ]);
  String questionText;
  int questionNumber;
  bool isCorrect;
  bool validityOverlayVisible = false;

  @override
  void initState(){
    super.initState();
    currentQuestion = quiz.nextQuestion;
    questionText = currentQuestion.question;
    questionNumber = quiz.questionNumber;
  }

  void checkAnswerValidity(bool answer){
    isCorrect = (currentQuestion.answer == answer);
    quiz.answer(isCorrect);
    this.setState(() {
      validityOverlayVisible = true;
    });
  }

  @override
  Widget build(BuildContext context){
    return new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        new Column(
          children: <Widget>[
            new AnswerButton(true, () => checkAnswerValidity(true)),
            new QuestionText(questionNumber, questionText),
            new AnswerButton(false, () => checkAnswerValidity(false)),
          ],
        ),
        validityOverlayVisible == true ? new ValidityOverlay(
          isCorrect,
          (){
            if(quiz.length == questionNumber){
              Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (BuildContext context) => new ScorePage(quiz.score, quiz.length)), (Route route) => route == null);
              
              push(new MaterialPageRoute(builder: (BuildContext context) => new ScorePage(quiz.score, quiz.length)));
              return;
            }
            currentQuestion = quiz.nextQuestion;
            this.setState((){
              validityOverlayVisible = false;
              questionText = currentQuestion.question;
              questionNumber = quiz.questionNumber;
            });
          }
        ) : new Container(),
      ],
    );
  }
}
