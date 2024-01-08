class UserCategories {
  int? userid;
  List<String> categories;

  UserCategories({
    required this.userid,
    required this.categories,
  });

  Map<String, dynamic> toMap() => {
        'userid': userid,
        'categories': categories,
      };
}
