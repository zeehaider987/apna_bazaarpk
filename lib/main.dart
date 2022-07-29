import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';
void main() {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp( WillPopScope(child: MyApp(), onWillPop:()async{return false;}));
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => new _MyAppState();
}
class _MyAppState extends State<MyApp> {
  // final Completer<WebViewController> _controller =
  //     Completer<WebViewController>();
  @override
  void initState() {
    super.initState();
    if (Platform.isAndroid) WebView.platform = AndroidWebView();
    // initialization();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  // void initialization() async {
  //   // This is where you can initialize the resources needed by your app while
  //   // the splash screen is displayed.  Remove the following example because
  //   // delaying the user experience is a bad design practice!
  //   // ignore_for_file: avoid_print
  //   // print('ready in 3...');
  //   // await Future.delayed(const Duration(seconds: 1));
  //   // print('ready in 2...');
  //   // await Future.delayed(const Duration(seconds: 1));
  //   // print('ready in 1...');
  //   // await Future.delayed(const Duration(seconds: 1));
  //   // print('go!');
  //   this is rouaf work for git 
  //   // FlutterNativeSplash.remove(); 
  // }
 
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title:"Apna Bazaar",
      color:Color.fromARGB(255, 34, 181, 115),
      
      debugShowCheckedModeBanner: false,
      home:WillPopScope(
        onWillPop: ()async{
      print("you donot go back ");
      return await Future.value(false);
     } ,
        child: Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/Images/appbar.png'),
        backgroundColor:Color.fromARGB(255, 34, 181, 115)
        ),
      // ignore: prefer_const_constructors
      body: WebView(
       initialUrl: 'https://apnabazaar.pk',
       javascriptMode: JavascriptMode.unrestricted,
       gestureNavigationEnabled: true,
      )
     ),
      )
     );
  }
  }