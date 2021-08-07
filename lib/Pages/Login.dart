import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartado/Bloc/UserBloc.dart';

import '../contants.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.2,
          alignment: Alignment.center,
          child: Text(
            "SmartAdo",
            style: GoogleFonts.raleway(
              fontSize: 36.0,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.3,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/env.png'),
            ),
          ),
        ),
        BlocBuilder<UserBloc, UserState>(
          builder: (c, s) {
            if (s is LoadingUserState) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 24.0,
                    width: 24.0,
                    margin: EdgeInsets.all(32.0),
                    child: CircularProgressIndicator(),
                  ),
                ],
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 20.0,
              ),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: btnColor,
                ),
                onPressed: () {
                  c.read<UserBloc>().add(LoginUserEvent());
                },
                child: Text(
                  'Sign in with Google',
                  style: TextStyle(
                    color: primaryTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
