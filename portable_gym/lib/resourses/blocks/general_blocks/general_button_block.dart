import 'package:flutter/material.dart';


class GeneralButtonBlock extends StatelessWidget {
 final String lable;
final VoidCallback function;
final double width,hight/*,borderRadius*/;
 final /*Color textColor,*/backgroundColor;
 final TextStyle textStyle;

 GeneralButtonBlock({required this.lable,
   required this.function,
   this.width=0,
    this.hight=0,
  // , required this.textColor,
   required this.backgroundColor,
   //required this.borderRadius
   required this.textStyle
     });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed:function,

        style: ElevatedButton.styleFrom(
       //    shape: RoundedRectangleBorder(
       //    //  borderRadius: BorderRadius.circular(borderRadius)
       //    ),
         backgroundColor: backgroundColor,
      fixedSize: width == 0 && hight==0?null: Size(width, hight),
         ),
        child:Text(lable,
        style:textStyle,)
    );
  }
}
