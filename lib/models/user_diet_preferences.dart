class UserDietPreferences {
  int? userid;
  List<String> diet;

  UserDietPreferences({
    required this.userid,
    required this.diet,
  });

  Map<String, dynamic> toMap() => {
        'userid': userid,
        'categories': diet,
      };
}
