import 'package:flutter/material.dart';
import 'package:texol_task/constants.dart';
import 'package:texol_task/models/question.dart';
import 'package:texol_task/screens/qzfinished.dart';
import 'package:html_unescape/html_unescape.dart';

class QuizPage extends StatefulWidget {
  final List<Question> questions;


  const QuizPage({Key key, @required this.questions,}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _currentIndex = 0;
  final Map<int,dynamic> _answers = {};
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context){
    Question question = widget.questions[_currentIndex];
    final List<dynamic> options = question.incorrectAnswers;
    if(!options.contains(question.correctAnswer)) {
      options.add(question.correctAnswer);
      options.shuffle();
    }
    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("TRIVIA APP",style: TextStyle(fontSize: 24,color: Colors.black,fontWeight: FontWeight.bold),),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Question ${_currentIndex+1}",style: TextStyle(color: kTextColor,fontSize: 18,fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(HtmlUnescape().convert(widget.questions[_currentIndex].question),
                      softWrap: true,
                      style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.w400),),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Card(
                elevation: 0,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 18.0,left: 18),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Questions",style: TextStyle(color: kTextColor,fontWeight: FontWeight.bold),)),
                    ),
                    ...options.map((option)=>RadioListTile(
                      title: Text(HtmlUnescape().convert("$option")),
                      groupValue: _answers[_currentIndex],
                      activeColor: kTextColor,
                      value: option,
                      onChanged: (value){
                        setState(() {
                          _answers[_currentIndex] = option;
                        });
                      },
                    )),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                child: RaisedButton(
                  color: kPrimaryColor,
                  child: Text( _currentIndex == (widget.questions.length - 1) ? "Submit" : "Next"),
                  onPressed: _nextSubmit,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _nextSubmit() {
    if(_answers[_currentIndex] == null) {
      _key.currentState.showSnackBar(SnackBar(
        content: Text("You must select an answer to continue."),
      ));
      return;
    }
    if(_currentIndex < (widget.questions.length - 1)){
      setState(() {
          _currentIndex++;
      });
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => QuizFinishedPage(questions: widget.questions, answers: _answers)
      ));
    }
  }


}