import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartado/Models/UserModel.dart';
import 'package:smartado/Services/auth.dart';
import 'package:smartado/Services/store.dart';

abstract class UserEvent {
  const UserEvent();
}

class FetchUserEvent extends UserEvent {
  const FetchUserEvent();
}

class LoginUserEvent extends UserEvent {
  const LoginUserEvent();
}

class LogoutUserEvent extends UserEvent {
  const LogoutUserEvent();
}

class UpdateUserEvent extends UserEvent {
  final AppUser updateUser;
  const UpdateUserEvent({required this.updateUser});
}

abstract class UserState {
  const UserState();
}

class InitUserState extends UserState {
  const InitUserState();
}

class LoadingUserState extends UserState {
  final String loadingMessage;
  const LoadingUserState({required this.loadingMessage});
}

class NewUserState extends UserState {
  final AppUser user;
  const NewUserState({required this.user});
}

class LoggedInUserState extends UserState {
  final AppUser user;
  const LoggedInUserState({required this.user});
}

class LoggedOutUserState extends UserState {
  final String loggedOutMessage;
  const LoggedOutUserState({required this.loggedOutMessage});
}

class ErrorUserState extends UserState {
  final String errorMessage;
  const ErrorUserState({required this.errorMessage});
}

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(InitUserState());

  late AppUser currentUser;

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is FetchUserEvent) {
      yield LoadingUserState(loadingMessage: 'Logging in...');
      try {
        User? user = await signInWithGoogle();
        FireStoreService _fireStore = FireStoreService();
        AppUser _appUser = await _fireStore.getUser(user!.uid);
        currentUser = _appUser;
        yield LoggedInUserState(user: _appUser);
      } catch (e) {
        yield ErrorUserState(errorMessage: 'Error logging in: $e');
      }
    } else if (event is LoginUserEvent) {
      yield LoadingUserState(loadingMessage: 'Logging in...');
      try {
        User? user = await signInWithGoogle();
        FireStoreService _fireStore = FireStoreService();
        AppUser _appUser = await _fireStore.getUser(user!.uid);
        if (_appUser.uid.isEmpty) {
          AppUser _createUser = new AppUser(
            uid: user.uid,
            displayName: user.displayName!,
            photoURL: user.photoURL!,
            email: user.email!,
            semester: '',
            section: '',
            usn: '',
            userType: 1,
          );
          await _fireStore.addUser(_createUser);
          currentUser = _createUser;
          yield NewUserState(user: _createUser);
        } else {
          currentUser = _appUser;
          yield LoggedInUserState(
            user: _appUser,
          );
        }
      } catch (e) {
        yield ErrorUserState(errorMessage: 'Error logging in: $e');
      }
    } else if (event is LogoutUserEvent) {
      yield LoadingUserState(loadingMessage: 'Logging out...');
      try {
        await signOutGoogle();
        currentUser = AppUser(
          uid: '',
          displayName: '',
          photoURL: '',
          email: '',
          semester: '',
          section: '',
          usn: '',
          userType: 1,
        );
        yield LoggedOutUserState(loggedOutMessage: 'Logged out!');
      } catch (e) {
        yield ErrorUserState(errorMessage: 'Error logging out: $e');
      }
    } else if (event is UpdateUserEvent) {
      yield LoadingUserState(loadingMessage: 'Updating user...');
      try {
        FireStoreService _fireStore = FireStoreService();
        await _fireStore.updateUser(event.updateUser);
        currentUser = event.updateUser;
        yield LoggedInUserState(
          user: currentUser,
        );
      } catch (e) {
        yield ErrorUserState(errorMessage: 'Error updating user: $e');
      }
    }
  }
}
