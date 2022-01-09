import 'dart:math';



final names = [
"Caramel Macchiato",
" Caramel Cold Drink",
"Iced Coffe Mocha",
"Caramelized Pecan Latte",
"Toffee Nut Latte",
"Capuchino",
"Toffee Nut Iced Latte",
"Americano",
"Vietnamese-Style Iced Coffee",
"Black Tea Latte",
"Classic Irish Coffee",
"Toffee Nut Crunch Latte"
  ];


 double doubleInRange(Random source, num start , num end) => source.nextDouble()* (end-start)+1;
    final random = Random();



  final coffees = List.generate(names.length, (index) {
    
    if(index + 1 <= names.length){
      return   Coffee(

  name: names[index], image: 'assets/coffee/${index + 1}.png', price: doubleInRange(random, 3, 7),
);
    }
  }
);


class Coffee{


  final String name;
  final String image;
  final double price;

Coffee({required this.name, required this.image, required this.price});





  
}

