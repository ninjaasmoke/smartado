import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartado/Bloc/UserBloc.dart';
import 'package:smartado/Pages/App.dart';
import 'package:smartado/Pages/Login.dart';
import 'package:smartado/Pages/NewUser.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBloc>(
          create: (context) => UserBloc(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: AppBarTheme(
              elevation: 0,
              backgroundColor: Colors.white,
              titleTextStyle: TextStyle(
                color: Colors.black,
              ),
              centerTitle: true,
              textTheme: TextTheme(
                headline6: GoogleFonts.raleway(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              )),
          fontFamily: GoogleFonts.raleway().fontFamily,
        ),
        home: BlocConsumer<UserBloc, UserState>(
          builder: (context, state) {
            if (state is InitUserState || state is LoggedOutUserState) {
              return LoginPage();
            }
            if (state is NewUserState) {
              return NewUserWrapper();
            }
            if (state is LoggedInUserState) {
              return App();
            }
            return LoginPage();
          },
          listener: (context, state) {
            if (state is LoadingUserState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.loadingMessage),
                ),
              );
            } else if (state is ErrorUserState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.errorMessage),
                ),
              );
            }
          },
        ),
        title: 'SmartAdo',
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
