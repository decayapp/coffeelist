class coffeemodal {
  int? id;
  String? name;
  String? description;
  List<String>? ingredients;
  String? brewingMethod;

  coffeemodal(
      {this.id,
      this.name,
      this.description,
      this.ingredients,
      this.brewingMethod});

  coffeemodal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    ingredients = json['ingredients'].cast<String>();
    brewingMethod = json['brewingMethod'];
  }
}
