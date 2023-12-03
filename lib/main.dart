import 'package:flutter/material.dart';
import 'package:screenpaper/wallpaper.dart';
 void main()=>runApp(new myApp());
 
 class myApp extends StatelessWidget {
   const myApp({Key? key}) : super(key: key);
 
   @override
   Widget build(BuildContext context) {
     return MaterialApp(
       debugShowCheckedModeBanner: false,
       theme: ThemeData(brightness: Brightness.dark),
       home: Wallpaper(),

     );
   }
 }
 