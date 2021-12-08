import 'package:flutter/material.dart';
import 'package:texol_task/constants.dart';
import 'package:texol_task/models/question.dart';

class QuizFinishedPage extends StatelessWidget {
  final List<Question> questions;
  final Map<int, dynamic> answers;
  
  int correctAnswers;
  QuizFinishedPage({Key key, @required this.questions, @required this.answers}): super(key: key) {
    
  }

  @override
  Widget build(BuildContext context){
    int correct = 0;
    this.answers.forEach((index,value){
      if(this.questions[index].correctAnswer == value)
        correct++;
    });

    
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text("TRIVIA APP",style: TextStyle(fontSize: 24,color: Colors.black,fontWeight: FontWeight.bold),),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Your Score Is",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold), ),
              SizedBox(height: 20,),
              Text("${correct*10}/${questions.length*10}",style: TextStyle(fontSize: 28,color: Colors.black,fontWeight: FontWeight.bold),),
              SizedBox(height: 80,),
              RaisedButton(
                color: kPrimaryColor,
                  child: Text("RETAKE TRIVIA",style: TextStyle(color: kTextColor),),
                  onPressed: ()=>Navigator.pop(context))


            ],
          ),
        ),
      ),
    );
  }
}