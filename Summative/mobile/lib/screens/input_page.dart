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

  // Error messages
  Map<String, String> errorMessages = {};
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Future<void> sendPredictionRequest() async {
      // Clear previous errors
      setState(() {
        errorMessages = {};
        isLoading = true;
      });

      try {
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
          // Handle validation errors
          Map<String, dynamic> errorResponse = jsonDecode(response.body);

          if (errorResponse.containsKey('detail') && errorResponse['detail'] is List) {
            List<dynamic> details = errorResponse['detail'];

            Map<String, String> newErrors = {};
            for (var error in details) {
              if (error is Map && error.containsKey('loc') && error.containsKey('msg')) {
                List<dynamic> location = error['loc'];
                if (location.length >= 2 && location[0] == 'body') {
                  String fieldName = location[1].toString();
                  String errorMsg = error['msg'].toString();

                  // Convert API field names to user-friendly names
                  String displayField = _getDisplayFieldName(fieldName);
                  newErrors[fieldName] = '$displayField: $errorMsg';
                }
              }
            }

            setState(() {
              errorMessages = newErrors;
            });

            // Show error dialog
            _showErrorDialog(context);
          } else {
            // Show general server error
            _showGeneralErrorDialog(context, 'Server Error: ${response.statusCode}');
          }
        }
      } catch (e) {
        // Handle parse errors and connection errors
        if (e is FormatException) {
          _showGeneralErrorDialog(context, 'Please enter valid numbers in all fields');
        } else {
          _showGeneralErrorDialog(context, 'Connection error: $e');
        }
      } finally {
        setState(() {
          isLoading = false;
        });
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
              SizedBox(height:30,),
              // Hours Studied
              TextField(
                controller: hoursStudyController,
                keyboardType: TextInputType.number,
                style: TextStyle(
                    color: AppColors.whiteAccent,
                    fontSize: 17
                ),
                decoration: InputDecoration(
                    labelText: "Hours Studied (1-12)",
                    labelStyle: TextStyle(
                        color: AppColors.lightBlue
                    ),
                    filled: true,
                    fillColor: AppColors.darkestBlue,
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lightBlue)
                    ),
                    border: InputBorder.none,
                    errorText: errorMessages.containsKey('hours_studied') ? errorMessages['hours_studied'] : null,
                    errorStyle: TextStyle(color: Colors.redAccent, fontSize: 8)
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
                    labelText: "Previous Scores (0-100)",
                    labelStyle: TextStyle(
                        color: AppColors.lightBlue
                    ),
                    filled: true,
                    fillColor: AppColors.darkestBlue,
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lightBlue)
                    ),
                    border: InputBorder.none,
                    errorText: errorMessages.containsKey('previous_scores') ? errorMessages['previous_scores'] : null,
                    errorStyle: TextStyle(color: Colors.redAccent, fontSize: 8)
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
                    labelText: "Sleep Hours (4-10)",
                    labelStyle: TextStyle(
                        color: AppColors.lightBlue
                    ),
                    filled: true,
                    fillColor: AppColors.darkestBlue,
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lightBlue)
                    ),
                    border: InputBorder.none,
                    errorText: errorMessages.containsKey('sleep_hours') ? errorMessages['sleep_hours'] : null,
                    errorStyle: TextStyle(color: Colors.redAccent, fontSize: 8)
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
                    labelText: "Sample Question Papers Practiced (0-10)",
                    labelStyle: TextStyle(
                        color: AppColors.lightBlue
                    ),
                    filled: true,
                    fillColor: AppColors.darkestBlue,
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lightBlue)
                    ),
                    border: InputBorder.none,
                    errorText: errorMessages.containsKey('sample_question_papers_practiced') ? errorMessages['sample_question_papers_practiced'] : null,
                    errorStyle: TextStyle(color: Colors.redAccent, fontSize: 8)
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
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.lightBlue)
                    ),
                    errorText: errorMessages.containsKey('extracurricular_activities') ? errorMessages['extracurricular_activities'] : null,
                    errorStyle: TextStyle(color: Colors.redAccent)
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
                            borderRadius: BorderRadius.circular(50),
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
                      )
                  ),
                  ElevatedButton(
                    onPressed: isLoading ? null : sendPredictionRequest,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 40,
                      ),
                      backgroundColor: isLoading ? Colors.grey : AppColors.orangeAccent,
                    ),
                    child: isLoading
                        ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.whiteAccent,
                        )
                    )
                        : Text(
                      "Predict",
                      style: TextStyle(
                          color: AppColors.whiteAccent,
                          fontSize: 17
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to show error dialog
  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.darkestBlue,
          title: Text(
            'Validation Error',
            style: TextStyle(color: AppColors.whiteAccent),
          ),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: errorMessages.values.map((errorMsg) =>
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      '• $errorMsg',

                      style: TextStyle(color: Colors.redAccent, fontSize: 10),
                    ),
                  )
              ).toList(),
            ),
          ),
          actions: [
            TextButton(
              child: Text(
                'OK',
                style: TextStyle(color: AppColors.lightBlue),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Helper method to show general error dialog
  void _showGeneralErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: AppColors.darkestBlue,
          title: Text(
            'Error',
            style: TextStyle(color: AppColors.whiteAccent),
          ),
          content: Text(
            message,
            style: TextStyle(color: AppColors.whiteAccent),
          ),
          actions: [
            TextButton(
              child: Text(
                'OK',
                style: TextStyle(color: AppColors.lightBlue),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Helper method to get user-friendly field names
  String _getDisplayFieldName(String apiFieldName) {
    switch(apiFieldName) {
      case 'hours_studied':
        return 'Hours Studied';
      case 'previous_scores':
        return 'Previous Scores';
      case 'extracurricular_activities':
        return 'Extracurricular Activities';
      case 'sleep_hours':
        return 'Sleep Hours';
      case 'sample_question_papers_practiced':
        return 'Sample Question Papers';
      default:
        return apiFieldName;
    }
  }
}