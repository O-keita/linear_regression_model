import 'dart:convert';

import 'package:flutter/material.dart';
import '../theme/colors.dart';
import 'result_screen.dart';
import 'package:http/http.dart' as http;

class InputPage extends StatefulWidget {
  const InputPage({super.key});

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {

  final TextEditingController hoursStudyController = TextEditingController();
  final TextEditingController previousScoreController = TextEditingController();
  final TextEditingController extraController = TextEditingController();
  final TextEditingController sleepHoursController = TextEditingController();
  final TextEditingController sampleQuestionsController = TextEditingController();

  String? selectedExtraActivity; // Stores Yes/No for extracurricular
  int extraActivityValue = 0;

  Object? get requestBody => null; // Converts Yes to 1, No to 0

  @override
  Widget build(BuildContext context) {
    Future<void> sendPredictionRequest() async {

      double hoursStudied = double.parse(hoursStudyController.text);
      double previousScores = double.parse(previousScoreController.text);
      double sleepHours = double.parse(sleepHoursController.text);
      double sampleQuestions = double.parse(sampleQuestionsController.text);
      double extracurricularActivities = selectedExtraActivity == 'Yes' ? 1.0 : 0.0;

      // Create the request body
      Map<String, dynamic> requestBody = {
        'hours_studied': hoursStudied,
        'previous_scores': previousScores,
        'extracurricular_activities': extracurricularActivities,
        'sleep_hours': sleepHours,
        'sample_question_papers_practiced': sampleQuestions,
      };

      try {
        print('Request body: ${jsonEncode(requestBody)}');
        final response = await http.post(
          Uri.parse('https://linear-regression-model-mlky.onrender.com/predict'),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(requestBody),
        );

        if (response.statusCode == 200) {
          // Parse the response body
          Map<String, dynamic> responseData = jsonDecode(response.body);
          double prediction = responseData['predicted_performance_index'];
          // Handle the prediction result (e.g., navigate to the result screen)
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResultScreen(predictionValue: prediction),
            ),
          );
        } else {
          // Handle server errors
          print('Server error: ${response.statusCode}');
        }
      } catch (e) {
        // Handle connection errors
        print('Connection error: $e');
      }
    }

    return Scaffold(
      backgroundColor: AppColors.darkBlueBackground,
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          margin: EdgeInsets.all(15),
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 30,),
              Text(
                "Enter Study Data",
                style: TextStyle(
                  color: AppColors.whiteAccent,
                  fontSize: 26,
                  fontWeight: FontWeight.w500
                ),
              ),
              SizedBox(height:30 ,),
              // Hours Studied
              TextField(
                controller: hoursStudyController,
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: AppColors.whiteAccent,
                    fontSize: 17
                ),
                decoration: InputDecoration(
                    labelText: "Hours Studied",
                    labelStyle: TextStyle(
                        color: AppColors.lightBlue
                    ),
                    filled: true,
                    fillColor: AppColors.darkestBlue,
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lightBlue)
                    ),
                    border: InputBorder.none

                ),

              ),
              SizedBox(height: 20,),
              // Previous Scores
              TextField(
                controller: previousScoreController,
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: AppColors.whiteAccent,
                    fontSize: 17
                ),
                decoration: InputDecoration(
                    labelText: " Previous Scores",
                    labelStyle: TextStyle(
                        color: AppColors.lightBlue
                    ),
                    filled: true,
                    fillColor: AppColors.darkestBlue,
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lightBlue)
                    ),
                    border: InputBorder.none

                ),

              ),
              SizedBox(height: 20,),
              TextField(
                controller: sleepHoursController,
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: AppColors.whiteAccent,
                    fontSize: 17
                ),
                decoration: InputDecoration(
                    labelText: " Sleep Hours",
                    labelStyle: TextStyle(
                        color: AppColors.lightBlue
                    ),
                    filled: true,
                    fillColor: AppColors.darkestBlue,
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lightBlue)
                    ),
                    border: InputBorder.none

                ),



              ),
              SizedBox(height: 20,),
              TextField(
                controller: sampleQuestionsController,
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: AppColors.whiteAccent,
                    fontSize: 17
                ),
                decoration: InputDecoration(
                    labelText: "Sample Question Papers Practiced",
                    labelStyle: TextStyle(
                        color: AppColors.lightBlue
                    ),
                    filled: true,
                    fillColor: AppColors.darkestBlue,
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lightBlue)
                    ),
                    border: InputBorder.none

                ),

              ),
              SizedBox(height: 20,),
              //Drop Down for Extra curricular

              DropdownButtonFormField<String>(

                style: TextStyle(
                  color: AppColors.whiteAccent
                ),
                value: selectedExtraActivity,
                decoration: InputDecoration(
                  labelText: "Extracurricular Activities ??",
                  labelStyle: TextStyle(
                    color: AppColors.lightBlue,

                  ),
                  fillColor: AppColors.darkestBlue,
                  filled: true,
                  focusedBorder:UnderlineInputBorder(
                    borderSide: BorderSide(color: AppColors.lightBlue)
                  )
                ),
                items: ["Yes", "No"].map((String value){
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );


                }).toList(),
                onChanged: (newValue){
                  setState(() {
                    selectedExtraActivity = newValue;
                  });
                },
                dropdownColor: AppColors.darkestBlue,

              ),

              SizedBox(height: 25,),
              
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  
                  ElevatedButton(
                      onPressed: (){

                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius:  BorderRadius.circular(50),
                            side: BorderSide(color: AppColors.lightBlue)
                        ),
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                        backgroundColor: AppColors.darkestBlue,

                      ),
                      child: Text(
                          "back",
                        style: TextStyle(
                          fontSize: 17,
                          color: AppColors.lightBlue
                        ),
                      )),
                  ElevatedButton(
                      onPressed: (){
                        sendPredictionRequest();
                      },

                      style: ElevatedButton.styleFrom(

                        padding: EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: 40,
                        ),
                        backgroundColor: AppColors.orangeAccent,
                      ) ,

                    child: Text("Predict",style: TextStyle(
                      color: AppColors.whiteAccent,
                      fontSize: 17
                    ),),
                  )

                  
                ],
              )
            ],
            
            
          ),

        ),
      ),
    );
  }
}
