import 'package:flutter/material.dart';
import 'package:texol_task/constants.dart';
import 'package:texol_task/options.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
        body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("TRIVIA APP",style: TextStyle(fontSize: 22,color: Colors.black,fontWeight: FontWeight.bold),),
              SizedBox(height: 30,),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: kPrimaryColor
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    children: [
                      Text("TAKE TRIVIA",style: TextStyle(fontSize: 18,color: kTextColor),),
                      SizedBox(width: 10,),
                      Icon(Icons.arrow_forward_ios_outlined,color: Colors.black,),
                    ],
                  ),
                ),
                  onPressed: (){
                    _trivia(context);
                  },
                  )

            ],
          ),
        ),
      )

    );
  }
  _trivia(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (sheetContext) => BottomSheet(
        builder: (_) => QuizOptionsDialog(),
        onClosing: (){},

      ),

    );

  }
}