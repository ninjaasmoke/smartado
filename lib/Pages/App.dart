import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartado/Bloc/UserBloc.dart';
import 'package:smartado/Pages/Profile.dart';
import 'package:smartado/contants.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (c, s) {
        if (s is LoggedInUserState) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Smartado'),
              actions: [
                IconButton(
                  icon: CircleAvatar(
                    radius: 13.0,
                    backgroundImage: NetworkImage(s.user.photoURL),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => ProfilePage(),
                      ),
                    );
                  },
                ),
                SizedBox(
                  width: 4.0,
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/test.png'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _gridTile(
                          MediaQuery.of(context).size.width / 2 - 20.0,
                          'assets/food.png',
                          "Food & Order",
                        ),
                        SizedBox(
                          width: 4.0,
                        ),
                        _gridTile(
                          MediaQuery.of(context).size.width / 2 - 20.0,
                          'assets/plan.png',
                          "Activities",
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _gridTile(
                          MediaQuery.of(context).size.width / 2 - 20.0,
                          'assets/walk.png',
                          "Lost & Found",
                        ),
                        SizedBox(
                          width: 4.0,
                        ),
                        _gridTile(
                          MediaQuery.of(context).size.width / 2 - 20.0,
                          'assets/clean.png',
                          "House Keeping",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

  Widget _gridTile(double width, String imgUrl, String title) {
    return Container(
      width: width,
      height: width,
      decoration: BoxDecoration(
        color: bgColor,
        image: DecorationImage(image: AssetImage(imgUrl)),
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Color(0x2a898989),
            blurRadius: 6.0,
            spreadRadius: 1.0,
          )
        ],
      ),
      alignment: Alignment.bottomCenter,
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8.0),
            bottomRight: Radius.circular(8.0)),
        child: Container(
          padding: const EdgeInsets.all(8.0),
          width: width,
          color: accentColor,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.raleway(
              color: secTextColor,
              fontWeight: FontWeight.w800,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }
}
