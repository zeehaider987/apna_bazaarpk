
import 'package:apna_bazaarpk/BackEventNotifyer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
void main() {
  // WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp( ChangeNotifierProvider(child: HomeWebView(), create:(context) => BackEventNotifyer()));
}
class HomeWebView extends StatefulWidget {
  const HomeWebView({super.key});
  @override
  State<HomeWebView> createState() => new _HomeWebViewState();
}
class _HomeWebViewState extends State<HomeWebView> {
  late WebViewController _controll;
  GlobalKey _globalKey=GlobalKey();
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
        onWillPop: _onBack,
        child: Scaffold(
          key: _globalKey,
      appBar: AppBar(
        title: Image.asset('assets/Images/appbar.png'),
        backgroundColor:Color.fromARGB(255, 34, 181, 115)
        ),
      // ignore: prefer_const_constructors
      body: WebView(
        
        onWebViewCreated: ( webViewController) {
            _controll=webViewController;},
       initialUrl: 'https://apnabazaar.pk',
       
       javascriptMode: JavascriptMode.unrestricted,
       gestureNavigationEnabled: true,
       
       navigationDelegate: (NavigationRequest request)async {
          print(request.url);
          if (request.url.contains("mailto:")) {
            if (!await launchUrl(Uri.parse(request.url)) ){
              throw 'Could not launch ${Uri.parse(request.url)}' ;
              }
            return NavigationDecision.prevent;
          } else {
            return NavigationDecision.navigate;
          }
        }
        
       

      ),
     ),

      )
     );
  }
  
   Future<bool> _onBack() async {
    bool goBack;
    var value = await _controll.canGoBack();  // check webview can go back
    if (value) {
     _controll.goBack(); // perform webview back operation
      return false;
    } else {
      late BackEventNotifyer _notifier;
     await showDialog(
        context: _globalKey.currentState!.context,
        builder: (context) => Consumer(
       builder: (context,BackEventNotifyer event, childs) {
         _notifier=event;
         return new AlertDialog(
           title: new Text(
               'Confirmation ', style: TextStyle(color: Color.fromARGB(131, 6, 90, 38))),
           content: new Text('Do you want exit app ? '),
           actions: [
             new TextButton(
               onPressed: () {
                 Navigator.of(context).pop(false);
                 event.add(false);
               },
               child: new Text("No"), // No
             ),
             new TextButton(
               onPressed: () {
                 Navigator.of(context).pop();
                 event.add(true);
               },
               child: new Text("Yes"), // Yes
             ),
           ],
         );
       }
       )
      );

      //Navigator.pop(_globalKey.currentState!.context);
   print("_notifier.isBack ${_notifier.isBack}");
      return _notifier.isBack;
    }
  }
  }