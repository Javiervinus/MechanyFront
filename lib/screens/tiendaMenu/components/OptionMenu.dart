
import 'package:flutter/material.dart';
import 'package:mechany/Constants.dart';
import 'package:mechany/sizeConfig.dart';

class OptionMenu extends StatelessWidget {
  String url;
  Function press;
  Color color;
  String buttonText;
  OptionMenu({Key key,this.url,this.press,this.color,this.buttonText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.symmetric(vertical:getProportionateScreenHeight(20),horizontal: getProportionateScreenWidth(20)),
      child: Container(
          
          decoration: BoxDecoration(
            boxShadow:[
              BoxShadow(color: Colors.grey[300],offset: Offset(1,2),blurRadius: 3,spreadRadius: 3)
              ] ,
            borderRadius: BorderRadiusDirectional.circular(20),
            image: DecorationImage(
              image: AssetImage(url) ,
              fit: BoxFit.cover
              )
          ),
          child: Container(
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding:  EdgeInsets.all(getProportionateScreenHeight(20)),
                child: FlatButton(onPressed: press,
             child: Padding(
               padding: EdgeInsets.all(6.0),
               child: Text(buttonText,style: TextStyle(fontSize: getProportionateScreenHeight(20),color: kPrimaryLightColor)),
             ),
             color: color,
             shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
             )
                ),
       
      ),
          )
    )
    );
  }
}