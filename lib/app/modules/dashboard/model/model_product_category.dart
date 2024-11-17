class ModelProductCategory {
  int? id;
  String? name;
  String? description;
  String? imageUrl;
  DateTime? createdAt;
  DateTime? updatedAt;

  ModelProductCategory({
    this.id,
    this.name,
    this.description,
    this.imageUrl,
    this.createdAt,
    this.updatedAt,
  });

  factory ModelProductCategory.fromJson(Map<String, dynamic> json) =>
      ModelProductCategory(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        imageUrl: json["image_url"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image_url": imageUrl,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
