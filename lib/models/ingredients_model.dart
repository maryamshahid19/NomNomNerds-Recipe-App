class Ingredients {
  List<int> ing_id;
  List<String> ing_name;

  Ingredients({
    required this.ing_id,
    required this.ing_name,
  });

  factory Ingredients.fromJson(Map<String, dynamic> json) => Ingredients(
        ing_id: json['ing_id'],
        ing_name: json['ing_name'],
      );

  Map<String, dynamic> toMap() => {
        //      'ing_id': ing_id,
        'ing_name': ing_name,
      };
}
