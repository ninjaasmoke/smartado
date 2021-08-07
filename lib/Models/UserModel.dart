class AppUser {
  final String uid;
  final String displayName;
  final String photoURL;
  final String email;
  final String semester;
  final String section;
  final String usn;
  final int userType; // 0: Admin, 1: Student, 2: Teacher, 3: Worker

  AppUser({
    required this.uid,
    required this.displayName,
    required this.photoURL,
    required this.email,
    required this.semester,
    required this.section,
    required this.usn,
    required this.userType,
  });

  static AppUser fromJson(Map<String, dynamic> json) {
    return new AppUser(
      uid: json["uid"] ?? "",
      displayName: json["displayName"] ?? "",
      photoURL: json["photoURL"] ?? "",
      email: json["email"] ?? "",
      semester: json["semester"] ?? "",
      section: json["section"] ?? "",
      usn: json["usn"] ?? "",
      userType: json["userType"] ?? 1,
    );
  }

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'displayName': displayName,
        'photoURL': photoURL,
        'email': email,
        'semester': semester,
        'section': section,
        'usn': usn,
        'userType': userType,
      };
}
