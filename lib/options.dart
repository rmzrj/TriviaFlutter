import 'dart:io';
import 'package:flutter/material.dart';
import 'package:texol_task/constants.dart';
import 'package:texol_task/models/question.dart';
import 'package:texol_task/screens/qzpage.dart';
import 'api/api_provider.dart';

class QuizOptionsDialog extends StatefulWidget {


  const QuizOptionsDialog({Key key,}) : super(key: key);

  @override
  _QuizOptionsDialogState createState() => _QuizOptionsDialogState();
}

class _QuizOptionsDialogState extends State<QuizOptionsDialog> {
  int _noOfQuestions;
  String _difficulty;
  bool processing;

  @override
  void initState() { 
    super.initState();
    _noOfQuestions = 10;
    _difficulty = "easy";
    processing = false;
  }

  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Select Mode",style: TextStyle(color: kPrimaryColor,fontWeight: FontWeight.bold,fontSize: 20),),
            ),
            SizedBox(height: 10,),
            SizedBox(
              width: double.infinity,
              child: Wrap(
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                runSpacing: 16.0,
                spacing: 16.0,
                children: <Widget>[
                  SizedBox(width: 0.0),
                  ActionChip(
                    label: Text("Any"),
                    labelStyle: TextStyle(color: Colors.black),
                    backgroundColor: _difficulty == null ? kPrimaryColor : Colors.grey.shade600,
                    onPressed: () => _selectDifficulty(null),
                  ),
                  ActionChip(
                    label: Text("Easy"),
                    labelStyle: TextStyle(color: Colors.black),
                    backgroundColor: _difficulty == "easy" ? kPrimaryColor : Colors.grey.shade600,
                    onPressed: () => _selectDifficulty("easy"),
                  ),
                  ActionChip(
                    label: Text("Medium"),
                    labelStyle: TextStyle(color: Colors.black),
                    backgroundColor: _difficulty == "medium" ? kPrimaryColor : Colors.grey.shade600,
                    onPressed: () => _selectDifficulty("medium"),
                  ),
                  ActionChip(
                    label: Text("Hard"),
                    labelStyle: TextStyle(color: Colors.black),
                    backgroundColor: _difficulty == "hard" ? kPrimaryColor : Colors.grey.shade600,
                    onPressed: () => _selectDifficulty("hard"),
                  ),
                  
                ],
              ),
            ),
            SizedBox(height: 20.0),
            processing ? CircularProgressIndicator() : RaisedButton(
              color: kPrimaryColor,
              child: Text("Start Quiz"),
              onPressed: _startQuiz,
            ),
            SizedBox(height: 20.0),
          ],
        ),
      );
  }


  _selectDifficulty(String s) {
    setState(() {
      _difficulty=s;
    });
  }

  void _startQuiz() async {
    setState(() {
      processing=true;
    });
      List<Question> questions =  await getQuestions( _difficulty);
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(
        builder: (_) => QuizPage(questions: questions, )
      ));
    }

  }
