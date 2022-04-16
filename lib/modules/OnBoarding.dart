import 'package:ecommerce/Reusable/Reusable.dart';
import 'package:ecommerce/Shared/Network/Local/CasheHelper.dart';
import 'package:ecommerce/modules/Login/LoginScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class onBoardingModel{
  String?imgepath;
  String?title;
  String?body;
  onBoardingModel({this.imgepath, this.title, this.body
  });
}
List<onBoardingModel> onboarding= [
  onBoardingModel(imgepath: 'assets/images/onboarding.png', title: "welcome",body: "Hi there! We missed you and we prepared a little gift for you!"
       ),
  onBoardingModel(imgepath: 'assets/images/onboarding1.png', title: "welcome",body: "It’s great to see you back! We have a special discount for our returning customers. Are you interested?"),
  onBoardingModel(imgepath: 'assets/images/onboarding2.png', title: "welcome",body: "If you have any questions, please contact our customer service team"),
];
var pageviewcontroller= PageController();
bool isLast=false;

class OnBoarding extends StatefulWidget {


  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  void sumbit(){
    CasheHelper.saveDate(key: 'onBoarding', value: true);
    navigationandclose(context, LoginScreen());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.only(top: 20, right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              InkWell(

                child: Text("Skip",
                  style: TextStyle(color:  HexColor('#8222e3'),
                      fontWeight: FontWeight.bold,fontSize: 25),)
                ,onTap: (){ sumbit();

              },
              )
            ],),
          ),
          Expanded(child: PageView.builder(itemBuilder: (context, index)=>buildPageViewer(onboarding[index]),
          physics: BouncingScrollPhysics(),
          itemCount: 3,
          controller: pageviewcontroller,
          onPageChanged: (index){

            if(index== 2){
              setState(() {
                isLast=true;
              });
            }
            else
            setState(() {
              isLast=false;
            });
          },),
          ),
          const SizedBox(height: 20,),
          Row(children: [
            Expanded(child: SmoothPageIndicator(
              controller: pageviewcontroller,
              count:  onboarding.length,
              axisDirection: Axis.horizontal,
              effect:   SlideEffect(
                  spacing:  8.0,
                  radius:  4.0,
                  dotWidth:  20.0,
                  dotHeight:  10.0,
                  paintStyle:  PaintingStyle.stroke,
                  strokeWidth:  1,
                  dotColor:  Colors.grey,
                  activeDotColor:  HexColor('#8222e3')
              ),
            )
            ),

            FloatingActionButton(onPressed: (){
              if(isLast){
sumbit();
              }
              else
                {
                  pageviewcontroller.nextPage(duration: Duration(microseconds: 900),
                      curve: Curves.easeInCirc
                  );
                }
            }
              ,child: const Icon(Icons.double_arrow),
              backgroundColor: HexColor('#8222e3'),)
          ],)
        ],),
      ) ,
    );
  }
}
buildPageViewer(onBoardingModel boardingModel ,)=> Column(
  crossAxisAlignment: CrossAxisAlignment.start,
  children:  [
  Expanded(child: Image(image: AssetImage("${boardingModel.imgepath}"))),
  const SizedBox(height: 25,),
  Text("${boardingModel.title}", style: const TextStyle(fontSize: 30),),
  const SizedBox(height: 25,),
  Text("${boardingModel.body}",  style: const TextStyle(fontSize: 20)),


],);
