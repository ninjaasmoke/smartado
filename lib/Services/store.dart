import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smartado/Models/UserModel.dart';

class FireStoreService {
  FirebaseFirestore _firestoreInstance = FirebaseFirestore.instance;

  Future<AppUser> getUser(String? uid) async {
    AppUser _user;
    try {
      DocumentSnapshot<Map<String, dynamic>> doc =
          await _firestoreInstance.collection("users").doc(uid).get();
      _user = AppUser.fromJson(doc.data() ?? {});
    } catch (e) {
      throw Exception(e);
    }
    return _user;
  }

  Future addUser(AppUser user) async {
    Map<String, dynamic> userObject = user.toJson();
    await _firestoreInstance
        .collection("users")
        .doc(user.uid)
        .set(userObject)
        .whenComplete(() {
      return user;
    }).catchError((e) {
      throw Exception(e);
    });
  }

  Future updateUser(AppUser user) async {
    /// this overrites the entire user object
    /// find a way to update only the changed fields

    Map<String, dynamic> userObject = user.toJson();
    await _firestoreInstance
        .collection("users")
        .doc(user.uid)
        .update(userObject)
        .whenComplete(() {
      return user;
    }).catchError((e) {
      throw Error();
    });
  }
}
