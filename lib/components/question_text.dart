import 'package:flutter/material.dart';

class QuestionText extends StatefulWidget{
  
  final int _questionNumber;
  final String _question;

  QuestionText(this._questionNumber, this._question);

  @override
  State createState() => new QuestionTextState();
}

class QuestionTextState extends State<QuestionText> with SingleTickerProviderStateMixin {
  Animation<double> _fontSizeAnimation;
  AnimationController _fontSizeAnimationController;

  @override
  void initState(){
    super.initState();
    _fontSizeAnimationController = new AnimationController(duration: new Duration(milliseconds: 500), vsync: this);
    _fontSizeAnimation = new CurvedAnimation(parent: _fontSizeAnimationController, curve: Curves.elasticIn);
    _fontSizeAnimation.addListener(() => this.setState((){}));
    _fontSizeAnimationController.forward();
  }

  @override
  void dispose() {
    _fontSizeAnimationController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(QuestionText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if(oldWidget._question != widget._question) {
      _fontSizeAnimationController.reset();
      _fontSizeAnimationController.forward();
    }
  }

  @override
  Widget build(BuildContext context){
    return new Material(
      color: Colors.white,
      child: new Padding(
        child: new Center(
          child: new Text("Statement " + widget._questionNumber.toString()+": " + widget._question,
            style: new TextStyle(fontSize: _fontSizeAnimation.value * 20) 
          ),
        ),
        padding: new EdgeInsets.symmetric(vertical: 20.0),
      )
    );
  }
}