import 'package:equatable/equatable.dart';

class EmployeesEntity extends Equatable {
  const EmployeesEntity({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.profileImage,
    this.address,
    required this.phone,
    required this.website,
    this.company,
  });

  final int id;
  final String name;
  final String username;
  final String email;
  final String profileImage;
  final AddressEntity? address;
  final String phone;
  final String website;
  final CompanyEntity? company;

  @override
  List<Object?> get props => [
        id,
        name,
        username,
        email,
        profileImage,
        address,
        phone,
        website,
        company,
      ];
}

class AddressEntity extends Equatable {
  const AddressEntity({
    required this.street,
    required this.suite,
    required this.city,
    required this.zipcode,
    this.geo,
  });

  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final GeoEntity? geo;

  @override
  List<Object?> get props => [
        street,
        suite,
        city,
        zipcode,
        geo,
      ];
}

class GeoEntity extends Equatable {
  const GeoEntity({
    required this.lat,
    required this.lng,
  });

  final String lat;
  final String lng;

  @override
  List<Object?> get props => [
        lat,
        lng,
      ];
}

class CompanyEntity extends Equatable {
  const CompanyEntity({
    required this.name,
    required this.catchPhrase,
    required this.bs,
  });

  final String name;
  final String catchPhrase;
  final String bs;

  @override
  List<Object?> get props => [
        name,
        catchPhrase,
        bs,
      ];
}
