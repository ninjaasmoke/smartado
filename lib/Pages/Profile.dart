import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartado/Bloc/UserBloc.dart';
import 'package:smartado/contants.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: BlocConsumer<UserBloc, UserState>(
        builder: (context, state) {
          if (state is LoggedInUserState) {
            return Container(
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 12.0,
                  ),
                  Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      image: DecorationImage(
                        image: NetworkImage(state.user.photoURL),
                        fit: BoxFit.cover,
                      ),
                    ),
                    padding: EdgeInsets.all(10),
                  ),
                  SizedBox(
                    height: 12.0,
                  ),
                  Text(state.user.displayName),
                  ListTile(
                    title: Text('Sign Out'),
                    onTap: () {
                      context.read<UserBloc>().add(LogoutUserEvent());
                    },
                  ),
                ],
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
        listener: (c, s) {
          if (s is LoggedOutUserState) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
