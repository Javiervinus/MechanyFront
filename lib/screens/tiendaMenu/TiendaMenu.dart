import 'package:flutter/material.dart';
import 'package:mechany/Constants.dart';
import 'package:mechany/Model/Tienda.dart';
import 'package:mechany/screens/listaDescuentos/ListaDescuentos.dart';
import 'package:mechany/screens/mapa/Mapa.dart';
import 'package:mechany/screens/stockTienda/StockTienda.dart';
import 'package:mechany/screens/tiendaMenu/components/OptionMenu.dart';
import 'package:mechany/sizeConfig.dart';
import 'package:url_launcher/url_launcher.dart';

class TiendaMenu extends StatefulWidget {
  Tienda tienda;
  TiendaMenu({Key key,this.tienda}) : super(key: key);

  @override
  _TiendaMenuState createState() => _TiendaMenuState();
}

class _TiendaMenuState extends State<TiendaMenu> {
    int currentPage = 0;
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      backgroundColor: kPrimaryLightColor,
          body: Stack(
        children: [
            buildBackground(),
            buildContainer(),
            
        ],
      ),
    );
  }

   Widget buildBackground(){
    return Stack(
      children: [
        Container(
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight*0.4,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/img/tienda.jpg"),
              fit: BoxFit.contain              
               )
          ),
          child:Align(
            alignment: Alignment.center,
                child: Text(widget.tienda.nombre,style: TextStyle(
                fontSize: getProportionateScreenHeight(40),
                color: kPrimaryLightColor,
                fontWeight: FontWeight.bold,
                shadows: [BoxShadow(color:Colors.black,offset: Offset(1,2))]
                ),),
          ) ),
           
      ],
    );
        
  }

  Widget buildContainer(){
    return Container(
      margin: EdgeInsets.only(top:getProportionateScreenHeight(230)),
      height: getProportionateScreenHeight(590),
      width: SizeConfig.screenWidth,
      decoration: BoxDecoration(color:kPrimaryLightColor,borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40)
      )
      ),
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(15),),
          FlatButton(onPressed: () {
            MaterialPageRoute route= MaterialPageRoute(builder: (_)=>StockTienda(tienda: widget.tienda,));
            Navigator.of(context).push(route);
           },
           child: Padding(
             padding: EdgeInsets.all(6.0),
             child: Text("Ver Stock",style: TextStyle(fontSize: getProportionateScreenHeight(20),color: kPrimaryLightColor)),
           ),
           color: Colors.brown,
           shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
           ),
           SizedBox(height: getProportionateScreenHeight(10),),
          Container(   
            width: SizeConfig.screenWidth,
            height: getProportionateScreenHeight(400),
            child: PageView(
              onPageChanged: (index){
                setState(() {
                  currentPage=index;
                });
              },
              children: [
                OptionMenu(url:"assets/img/descuentos.jpeg",press: (){
                  MaterialPageRoute route= MaterialPageRoute(builder: (_)=>ListaDescuentos(tienda: widget.tienda,));
                  Navigator.of(context).push(route);
                },color: Colors.red,buttonText: "Descuentos",),
                OptionMenu(url:"assets/img/telefono.jpg",press: ()async {
                  String url = 'https://api.whatsapp.com/send?phone=+593${widget.tienda.telefono}';
                  if (await canLaunch(url)) {
                    await launch(url);
                  } else {
                    throw 'Could not launch $url';
                  }
                },color: Colors.green[700],buttonText: "Whatsapp",),
                OptionMenu(url:"assets/img/ubicacion.jpg",press: (){
                  MaterialPageRoute route= MaterialPageRoute(builder: (_)=>MapaPage(tienda: widget.tienda,));
                  Navigator.of(context).push(route);
                },color: Colors.brown,buttonText: "Ubicacion",)
              ],
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(10),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  List.generate(
                        3,
                        (index) => buildDot(index: index),
                      ),
                    ),
        ],
      ),
      );
  }
  AnimatedContainer buildDot({int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: getProportionateScreenHeight(10),
      width: currentPage == index ? getProportionateScreenHeight(20) : getProportionateScreenHeight(10),
      decoration: BoxDecoration(
        color: currentPage == index ? kPrimaryColor : Color(0xFFD8D8D8),
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}