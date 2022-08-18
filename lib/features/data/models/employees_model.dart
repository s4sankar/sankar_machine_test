import 'package:sankar_machine_test/features/domain/entities/employees_entity.dart';

class EmployeesModel extends EmployeesEntity {
  const EmployeesModel({
    required int id,
    required String name,
    required String username,
    required String email,
    required String profileImage,
    AddressModel? address,
    required String phone,
    required String website,
    CompanyModel? company,
  }) : super(
          id: id,
          name: name,
          username: username,
          email: email,
          profileImage: profileImage,
          address: address,
          phone: phone,
          website: website,
          company: company,
        );

  factory EmployeesModel.fromJson(Map<String, dynamic> json) => EmployeesModel(
        id: json["id"] ?? '',
        name: json["name"] ?? '',
        username: json["username"] ?? '',
        email: json["email"] ?? '',
        profileImage: json["profile_image"] ?? '',
        address: json["company"] != null
            ? AddressModel.fromJson(json["address"])
            : null,
        phone: json["phone"] ?? '',
        website: json["website"] ?? '',
        company: json["company"] != null
            ? CompanyModel.fromJson(json["company"])
            : null,
      );
}

class AddressModel extends AddressEntity {
  const AddressModel({
    required String street,
    required String suite,
    required String city,
    required String zipcode,
    GeoModel? geo,
  }) : super(
          street: street,
          suite: suite,
          city: city,
          zipcode: zipcode,
          geo: geo,
        );

  factory AddressModel.fromJson(Map<String, dynamic> json) => AddressModel(
        street: json["street"] ?? '',
        suite: json["suite"] ?? '',
        city: json["city"] ?? '',
        zipcode: json["zipcode"] ?? '',
        geo: json["geo"] != null ? GeoModel.fromJson(json["geo"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "street": street,
        "suite": suite,
        "city": city,
        "zipcode": zipcode,
        "geo": geo != null ? (geo as GeoModel).toJson() : '',
      };
}

class GeoModel extends GeoEntity {
  const GeoModel({
    required String lat,
    required String lng,
  }) : super(
          lat: lat,
          lng: lng,
        );

  factory GeoModel.fromJson(Map<String, dynamic> json) => GeoModel(
        lat: json["lat"] ?? '',
        lng: json["lng"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}

class CompanyModel extends CompanyEntity {
  const CompanyModel({
    required String name,
    required String catchPhrase,
    required String bs,
  }) : super(
          name: name,
          catchPhrase: catchPhrase,
          bs: bs,
        );

  factory CompanyModel.fromJson(Map<String, dynamic> json) => CompanyModel(
        name: json["name"] ?? '',
        catchPhrase: json["catchPhrase"] ?? '',
        bs: json["bs"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "catchPhrase": catchPhrase,
        "bs": bs,
      };
}
