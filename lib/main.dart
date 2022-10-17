import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/screens/auth_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../screens/chat_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FlutterChat',
        theme: ThemeData(
          backgroundColor: Colors.pink,
          // accentColorBrightness: Brightness.dark,
          buttonTheme: ButtonTheme.of(context).copyWith(
            buttonColor: Colors.pink,
            textTheme: ButtonTextTheme.primary,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.pink)
              .copyWith(
                  secondary: Colors.deepPurple, brightness: Brightness.light),
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.hasData) {
              return ChatScreen();
            } else {
              return AuthScreen();
            }
          },
        )
        // Scaffold(
        //   floatingActionButton: FloatingActionButton(
        //     onPressed: () {
        //       FirebaseFirestore.instance
        //           .collection('chats/vytwmpvUwSuRsrIpStH1/messages')
        //           .snapshots()
        //           .listen((data) {
        //         print(data.docs[0]['text']);
        //       });
        //     },
        //     child: Icon(Icons.check),
        //   ),
        //   body: ChatScreen(),
        // ),
        );
  }
}
