import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartado/Bloc/UserBloc.dart';
import 'package:smartado/Pages/App.dart';
import 'package:smartado/Pages/Login.dart';
import 'package:smartado/Pages/NewUser.dart';
import 'package:smartado/contants.dart';

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
          create: (context) => UserBloc()..add(FetchUserEvent()),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: bgColor,
          appBarTheme: AppBarTheme(
            elevation: 0,
            backgroundColor: bgColor,
            titleTextStyle: TextStyle(
              color: primaryTextColor,
            ),
            centerTitle: true,
            iconTheme: IconThemeData(
              color: primaryTextColor,
            ),
            textTheme: TextTheme(
              headline6: GoogleFonts.raleway(
                color: primaryTextColor,
                fontSize: 20.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          accentColor: accentColor,
          primarySwatch: swatch,
          primaryColor: accentColor,
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
            if (state is LoadingUserState && state.loadingMessage.isNotEmpty) {
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
            } else if (state is LoggedOutUserState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.loggedOutMessage),
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
