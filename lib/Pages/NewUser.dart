import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smartado/Bloc/UserBloc.dart';
import 'package:smartado/Models/UserModel.dart';

import '../contants.dart';

class NewUserWrapper extends StatelessWidget {
  const NewUserWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(builder: (c, s) {
      if (s is NewUserState) {
        return NewUserPage(
          user: s.user,
        );
      }
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    });
  }
}

class NewUserPage extends StatefulWidget {
  final AppUser user;
  const NewUserPage({Key? key, required this.user}) : super(key: key);

  @override
  _NewUserPageState createState() => _NewUserPageState();
}

class _NewUserPageState extends State<NewUserPage> {
  late TextEditingController _name, _email, _sem, _sec, _usn;
  int userType = 1;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _name = new TextEditingController(
      text: widget.user.displayName,
    );
    _email = new TextEditingController(
      text: widget.user.email,
    );
    _sem = new TextEditingController(
      text: widget.user.semester,
    );
    _sec = new TextEditingController(
      text: widget.user.section,
    );
    _usn = new TextEditingController(
      text: widget.user.usn,
    );
  }

  Widget textInput(String labelName, TextEditingController controller) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
      child: TextFormField(
        validator: (String? pattern) {
          if (pattern!.length == 0) return 'Please enter $labelName';
          return null;
        },
        style: GoogleFonts.raleway(),
        keyboardType: labelName.contains('Sem')
            ? TextInputType.number
            : TextInputType.text,
        controller: controller,
        cursorColor: accentColor,
        decoration: InputDecoration(
          labelText: labelName,
          labelStyle: GoogleFonts.raleway(
            color: accentColor,
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: accentColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: accentColor),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Fill your details"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Form(
              key: formKey,
              child: Column(
                children: [
                  textInput("Name", _name),
                  textInput("Email", _email),
                  textInput("USN", _usn),
                  textInput("Semester", _sem),
                  textInput("Section", _sec),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: accentColor,
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    AppUser user = new AppUser(
                      displayName: _name.text,
                      email: _email.text,
                      semester: _sem.text,
                      section: _sec.text,
                      usn: _usn.text,
                      uid: widget.user.uid,
                      photoURL: widget.user.photoURL,
                      userType: userType,
                    );
                    context
                        .read<UserBloc>()
                        .add(UpdateUserEvent(updateUser: user));
                  }
                },
                child: Text(
                  "Confirm",
                  style: TextStyle(
                    color: secTextColor,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
