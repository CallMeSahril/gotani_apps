class ModelProfile {
  int? id;
  String? name;
  String? email;
  String? role;
  int? balance;
  String? storeName;
  String? storeLogo;
  String? storeAddress;
  String? storeProvince;
  String? storeProvinceId;
  String? storeCity;
  dynamic storeCityId;
  dynamic emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  ModelProfile({
    this.id,
    this.name,
    this.email,
    this.role,
    this.balance,
    this.storeName,
    this.storeLogo,
    this.storeAddress,
    this.storeProvince,
    this.storeProvinceId,
    this.storeCity,
    this.storeCityId,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory ModelProfile.fromJson(Map<String, dynamic> json) => ModelProfile(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        role: json["role"],
        balance: json["balance"],
        storeName: json["store_name"],
        storeLogo: json["store_logo"],
        storeAddress: json["store_address"],
        storeProvince: json["store_province"],
        storeProvinceId: json["store_province_id"],
        storeCity: json["store_city"],
        storeCityId: json["store_city_id"],
        emailVerifiedAt: json["email_verified_at"],
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
        "email": email,
        "role": role,
        "balance": balance,
        "store_name": storeName,
        "store_logo": storeLogo,
        "store_address": storeAddress,
        "store_province": storeProvince,
        "store_province_id": storeProvinceId,
        "store_city": storeCity,
        "store_city_id": storeCityId,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
