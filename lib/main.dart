import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:untitled5_clase9/providers/db_provider.dart';
import 'package:untitled5_clase9/providers/example_provider.dart';
import 'package:untitled5_clase9/ui/pages/home_page.dart';



void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ExampleProvider(),),
        ChangeNotifierProvider(create: (_)=>DBProvider()),
      ],
      child: MaterialApp(
        title: "QRapp",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.sourceCodeProTextTheme(),
        ),
        home: HomePage(),
      ),
    );
  }
}
