class ProductModel {
  late String id;
  late String name;
  late String category;
  late String brand;
  late String model;
  late double price;
  late String colour;
  late String weight;
  late String image;
  late bool favorite;

  ProductModel({
    required this.id,
    required this.name,
    required this.category,
    required this.brand,
    required this.model,
    required this.price,
    required this.colour,
    required this.weight,
    required this.image,
    required this.favorite,
  });

  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    category = json['category'];
    brand = json['brand'];
    model = json['model'];
    price = json['price'];
    colour = json['colour'];
    weight = json['weight'];
    image = json['image'];
    favorite = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = id;
    data['name'] = name;
    data['category'] = category;
    data['brand'] = brand;
    data['model'] = model;
    data['price'] = price;
    data['colour'] = colour;
    data['weight'] = weight;
    data['image'] = image;
    data['favorite'] = favorite;

    return data;
  }
}

class ProductFromBackend {
  late bool status;
  late List<ProductModel> result;

  ProductFromBackend({
    required this.status,
    required this.result,
  });

  ProductFromBackend.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['result'] != null) {
      result = <ProductModel>[];
      json['result'].forEach((v) {
        result.add(ProductModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['result'] = result.map((v) => v.toJson()).toList();

    return data;
  }
}
