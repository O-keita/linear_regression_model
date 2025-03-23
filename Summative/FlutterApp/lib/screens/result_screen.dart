import 'package:flutter/material.dart';
import 'package:mobile/theme/colors.dart';

class ResultScreen extends StatelessWidget {
  final double predictionValue;

  const ResultScreen({super.key, required this.predictionValue});

  @override
  Widget build(BuildContext context) {

    String getPerformanceLevel(double prediction) {
      if (prediction >= 90) {
        return "Excellent";
      } else if (prediction >= 75) {
        return "Good";
      } else if (prediction >= 50) {
        return "Average";
      } else {
        return "Poor";
      }
    }
    return Scaffold(
      backgroundColor: AppColors.darkBlueBackground,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Text(
              "Performance Prediction",
              style: TextStyle(
                color: AppColors.whiteAccent,
                fontSize: 26,
              ),
            ),
            SizedBox(height: 40),
            // Outer container with rounded corners
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: AppColors.darkestBlue,
                borderRadius: BorderRadius.circular(20), // Rounded corners
              ),
              child: Center(
                // Inner circle container
                child: Container(
                  width: 210, // Set width of the circle
                  height: 210, // Set height of the circle
                  decoration: BoxDecoration(
                    shape: BoxShape.circle, // Circle shape
                    border: Border.all(
                        color: AppColors.mediumBlue, width: 14), // Border color and thickness
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Background Circle
                      Container(

                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.darkBlueBackground, // Background color of the circle
                        ),
                      ),

                      // Progress Indicator
                      SizedBox(
                        width: 190,
                        height: 190,
                        child: TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0, end: predictionValue / 100),
                          duration: Duration(seconds: 1), // Smooth animation
                          builder: (context, value, _) {
                            return CircularProgressIndicator(
                              value: value, // Dynamic progress
                              strokeWidth: 6,
                              backgroundColor: AppColors.darkestBlue, // Progress background
                              valueColor: AlwaysStoppedAnimation(AppColors.orangeAccent), // Orange progress
                            );
                          },
                        ),
                      ),

                      // Centered Texts (Percentage and Label)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "${predictionValue.toInt()}%",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white, // Text color
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "PREDICTED SCORE",
                            style: TextStyle(
                              color: AppColors.whiteAccent,
                              fontSize: 16, // Optional: Adjust the font size for the label
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: AppColors.darkestBlue
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  Text(
                    "Performance Analysis",
                    style: TextStyle(
                      color: AppColors.whiteAccent,
                      fontSize: 26,
                      fontWeight: FontWeight.w400
                    ),
                  ),
                  SizedBox(height: 10,),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Text("Performance Level:", style: TextStyle(color: AppColors.lightBlue, fontSize:18 ),),
                          Text(getPerformanceLevel(predictionValue), style: TextStyle(color: AppColors.orangeAccent, fontSize: 17),),
                        ],
                      ),
                      Divider(height: 5, color: AppColors.lightBlue,),
                      SizedBox(height: 15,),

                      SizedBox(height: 15,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [

                          Text("Model Used:", style: TextStyle(color: AppColors.lightBlue, fontSize:18 ),),
                          Text("Linear Regression ", style: TextStyle(color: AppColors.orangeAccent, fontSize: 17),),
                        ],
                      ),

                  


                    ],
                  )
                ],
              ),
              
              
            ),
            
            SizedBox(height: 40,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                    onPressed: (){
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(color: AppColors.lightBlue,)
                      ),
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),

                      backgroundColor: AppColors.darkestBlue
                    ),
                    child: Text(
                        "Home",
                      style: TextStyle(
                        color: AppColors.whiteAccent,
                        fontSize: 18
                      ),
                    )),
                ElevatedButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 40),
                      backgroundColor: AppColors.orangeAccent
                    ),
                    child: Text(
                        "New",
                      style: TextStyle(
                        fontSize: 18,
                        color: AppColors.whiteAccent
                      ),
                    ))
              ],
            )
          ],
          
        ),
        
        
      ),
      
    );
  }
}
