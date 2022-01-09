import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Classes/Coffee.dart';




class CoffeeCarouselPage extends StatefulWidget {
  CoffeeCarouselPage({Key? key}) : super(key: key);

  @override
  _CoffeeCarouselPageState createState() => _CoffeeCarouselPageState();
}

class _CoffeeCarouselPageState extends State<CoffeeCarouselPage> {

  double _page = 0.0;
  PageController _coffeeCarouselController = PageController( viewportFraction: 0.35);
  PageController _nameController = PageController(viewportFraction: 1);
  Matrix4 matrix = new Matrix4.identity();

@override
  void initState() {
    
    _coffeeCarouselController.addListener(() {
      setState(() {
        _page = _coffeeCarouselController.page!;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    if(_nameController.hasClients){
        _nameController.animateToPage(_page.round(),duration: Duration(milliseconds: 100),curve: Curves.linear);
    }

  
    return Stack(
      children: [

      
          AnimatedPositioned(
            duration : Duration(milliseconds: 10),
            curve: Curves.easeIn,
          top : _page.round() < coffees.length? size.height*0.8 : size.height*0.6,
          left:_page.round() < coffees.length? size.width*0.35 : size.width*0.4,
          width: _page.round() < coffees.length? size.width*0.3 : size.width*0.2,
          height: _page.round() < coffees.length? size.height*0.2 :size.height*0.1 ,
          child: DecoratedBox(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.brown,
                  blurRadius: 90,
                  spreadRadius: 60
                )
              ]
            ),
          ),
        ),
        Transform.translate(
          offset: Offset(0,-size.height*0.3),
          child: Transform.scale(
            scale: 1.6,
            child: PageView.builder(
              controller: _coffeeCarouselController,
              itemCount: coffees.length+1,
              scrollDirection: Axis.vertical,
              itemBuilder: (context,index){
                
                double resultScaling = (_page -  index)+1  ;
                double value = -0.4*resultScaling + 1;
                print(value);
          
          
                matrix = Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..translate(0.0,size.height/2.1*(1-value).abs())
                ..scale(value);
          
           
              if(index == 0){
                return const SizedBox.shrink();
              }
          
          
              
                return GestureDetector(
                  onTap :() {
                    print(index);
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom : 20),
                    child: Opacity(
                      opacity: index -1 == coffees.length-1 ? 1 : value.clamp(0, 1),
                      child: Transform(
                        alignment: Alignment.bottomCenter,
                        transform: matrix,
                        child:Image.asset(coffees[index-1]!.image,)
                        ),
                    ),
                  ),
                );
              
              }),
          ),
        ),
        
        Positioned(
          top : 0,
          left : 0,
          right : 0,
          height: size.height*0.3,
          child: Container(
            padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.transparent
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
            Container(
              margin: EdgeInsets.only(top: size.height*0.06),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                GestureDetector(
                  onTap: () {
                    print("Back Button");
                  },
                  child: Icon(Icons.arrow_back_ios_new_rounded,size: 40,)),
                GestureDetector(
                  onTap: (){
                      print("Cart");
                  },
                  child: Icon(CupertinoIcons.bag, size : 40))
              ],),
            ),

            
           
                  Stack(
                    children: [
                      ClipRect(
                      child: Container(
                        width : size.width*0.8,
                        height: size.height *0.08,
                        color: Colors.transparent,
                        child: PageView.builder(
                          controller: _nameController,
                          itemCount: coffees.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (context,index){
                            return Center(child: Text(coffees[index]!.name, style: GoogleFonts.poppins(
                                                    textStyle: TextStyle(
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w600,
                                                        fontSize:20)
                                                        )
                                                        )
                                                        );
                          }
                          )
                
                      ),
                ),

                Container(  width : size.width*0.8,
                        height: size.height *0.08,
                        color: Colors.transparent,)
                    ],
                  ),

              AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: Text(coffees[_page.round() < coffees.length ? _page.round() : coffees.length-1]!.price.toStringAsFixed(2)+"\$", style: GoogleFonts.poppins(
                                                textStyle: TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize:30)
                                                    )
                                                    ),
                )
          ],
          ),
        )
        ),
      ],
    );
  }
}