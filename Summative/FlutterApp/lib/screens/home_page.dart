import "package:flutter/material.dart";
import '../theme/colors.dart';
import 'input_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBlueBackground,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              padding: EdgeInsets.all(5),
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border:Border.all(color: AppColors.orangeAccent, width: 2.5),
                  color: AppColors.darkestBlue
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("SP", style: TextStyle(
                        color: AppColors.orangeAccent,
                        fontSize: 100,
                        fontWeight: FontWeight.w400
                    ),),
                    SizedBox(height: 4,),
                    Text("PREDICT", style: TextStyle(
                        color: AppColors.whiteAccent,
                        fontSize:26
                    ),)
                  ],
                ),
              ),
            ),
            SizedBox(height:15,),
            Text("Student Performance Prediction", style: TextStyle(
                color: AppColors.lightBlue,
                fontSize: 20,
                fontWeight: FontWeight.w300
            ),),
            SizedBox(height: 25,),
            ElevatedButton(
                style: ElevatedButton.styleFrom(

                  backgroundColor: AppColors.orangeAccent,
                ),
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context)=>InputPage())
                  );
                },
                child: Text(
                  "Get Started",
                  style: TextStyle(
                      color: AppColors.whiteAccent,
                      fontSize: 17,
                      fontWeight: FontWeight.w400
                  ),
                ))
          ],
        ),

      ),
    );
  }
}