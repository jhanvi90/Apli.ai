
import 'package:flutter/material.dart';
class ImageData extends StatelessWidget {
  ImageData({this.url, this.name,this.date,this.hashtag});
  final String url;
   final String name;
   final String date;
   final String hashtag;
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return  Align(
      alignment: Alignment.topRight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
      SizedBox(height:screenHeight*0.04),
      Container(
      width:screenWidth,
      height:  screenHeight*0.30,
      decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(40),
      ),
      padding: EdgeInsets.all(10),
      child: Image.network(url.substring(0,url.length-1), fit: BoxFit.cover,)
      ),
      Padding(
        padding:  EdgeInsets.only(left:screenWidth*0.02),
        child: Align(
          alignment: Alignment.bottomLeft,
            child: Text(name)),
      ),
          Padding(
            padding:  EdgeInsets.only(left:screenWidth*0.02,top:screenHeight*0.01),
            child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(hashtag)),
          ),
          Padding(
            padding:  EdgeInsets.only(left:screenWidth*0.02,top:screenHeight*0.01),
            child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(date)),
          ),
          Divider(),
        ],
      ),
    );
  }
}
