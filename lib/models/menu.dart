class Menu {
  final int id;
  final String name;
  final num unit_price;
  final String description;
  final String image;
  final String subcategory_name;
  final String category_name;

  Menu(
      {required this.id,
      required this.name,
      required this.unit_price,
      required this.description,
      required this.category_name,
      required this.image,
      required this.subcategory_name});

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
        id: json["id"],
        name: json["name"],
        unit_price: json["unit_price"],
        description: json["description"],
        category_name: json["category_name"],
        image: json["image"],
        subcategory_name: json["subcategory_name"]);
  }
  factory Menu.createDefault() {
    return Menu(
        id: 3,
        name: "Menu",
        unit_price: 200,
        description:
            "The same differencing principle is used in the unsharp-masking tool in many digital-imaging software packages, such as Adobe Photoshop and GIMP.[1] The software applies a Gaussian blur to a copy of the original image and then compares it to the original. If the difference is greater than a user-specified threshold setting, the images are (in effect) subtracted.",
        category_name: "Lunch",
        image:
            "https://images.unsplash.com/photo-1515003197210-e0cd71810b5f?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1170&q=80",
        subcategory_name: "Dinner");
  }

  Map<String, String> toMap() {
    return {
      "id": id.toString(),
      "name": name,
      "unit_price": unit_price.toString(),
      "description": description,
      "category_name": category_name,
      "image": image,
      "subcategory_name": subcategory_name,
    };
  }

  factory Menu.fromMap(Map<dynamic, dynamic> map) {
    return Menu(
        id: int.parse(map["id"]!),
        name: map["name"]!,
        unit_price: num.parse(map["unit_price"]!),
        description: map["description"]!,
        category_name: map["category_name"]!,
        image: map["image"]!,
        subcategory_name: map["subcategory_name"]!);
  }
}
