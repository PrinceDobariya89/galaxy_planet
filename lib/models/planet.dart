// To parse this JSON data, do
//
//     final planet = planetFromJson(jsonString);

import 'dart:convert';

List<Planet> planetFromJson(String str) => List<Planet>.from(json.decode(str).map((x) => Planet.fromJson(x)));

String planetToJson(List<Planet> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Planet {
    String? position;
    String? name;
    String? image;
    String? velocity;
    String? distance;
    String? description;

    Planet({
        this.position,
        this.name,
        this.image,
        this.velocity,
        this.distance,
        this.description,
    });

    factory Planet.fromJson(Map<String, dynamic> json) => Planet(
        position: json["position"],
        name: json["name"],
        image: json["image"],
        velocity: json["velocity"],
        distance: json["distance"],
        description: json["description"],
    );

    Map<String, dynamic> toJson() => {
        "position": position,
        "name": name,
        "image": image,
        "velocity": velocity,
        "distance": distance,
        "description": description,
    };
}
