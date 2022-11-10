class Orders {
  final int id;
  final String name;
  final num unit_price;
  final String image;
  final int quantity;
  final String status;

  Orders(
      {required this.id,
      required this.image,
      required this.name,
      required this.quantity,
      required this.status,
      required this.unit_price});

  factory Orders.fromJson(Map<dynamic, dynamic> json) {

    return Orders(
        id: json["id"],
        image: json["image"],
        name: json["name"],
        quantity: json["quantity"],
        status: json["status"],
        unit_price: json["total"]);
  }
}
