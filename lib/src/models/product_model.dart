import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
    String id;
    String title    = '';
    double value    = 0.0;
    bool available = true;
    String fotoUrl;

    Product({
        this.id,
        this.title = '',
        this.value = 0.0,
        this.available = true,
        this.fotoUrl,
    });

    factory Product.fromJson(Map<String, dynamic> json) => Product(
        id:         json["id"],
        title:      json["title"],
        value:      json["value"],
        available:  json["available"],
        fotoUrl:    json["fotoUrl"],
    );

    Map<String, dynamic> toJson() => {
        //"id":         id, To not send id to serveron edit requests
        "title":      title,
        "value":      value,
        "available": available,
        "fotoUrl":    fotoUrl,
    };

    String toJsonString() => productToJson(this);
}
