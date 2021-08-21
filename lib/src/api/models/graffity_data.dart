import 'package:publicart/src/api/models/graffity_model.dart';

class GraffityData {
  final String id;
  final String name;
  final String description;
  final String city;
  final String address;
  final String audio;
  final String ar;
  final String latlng;
  final String artist;
  final String bio;
  final String avatar;
  final String insta;
  final String insta2;
  final String photoUrl;
  final String photoSqr;

  const GraffityData({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.audio,
    required this.ar,
    required this.latlng,
    required this.artist,
    required this.bio,
    required this.avatar,
    required this.insta,
    required this.insta2,
    required this.photoUrl,
    required this.photoSqr,
  });

  static GraffityData fromJson(Map<String, dynamic> json) => GraffityData(
      id: json[GraffityModel.id],
      name: json[GraffityModel.name],
      description: json[GraffityModel.description],
      city: json[GraffityModel.city],
      address: json[GraffityModel.address],
      audio: json[GraffityModel.audio],
      ar: json[GraffityModel.ar],
      latlng: json[GraffityModel.latlng],
      artist: json[GraffityModel.artist],
      bio: json[GraffityModel.bio],
      avatar: json[GraffityModel.avatar],
      insta: json[GraffityModel.insta],
      insta2: json[GraffityModel.insta2],
      photoUrl: json[GraffityModel.photoUrl],
      photoSqr: json[GraffityModel.photoSqr]);

  Map<String, dynamic> toJson() => {
        GraffityModel.id: id,
        GraffityModel.address: address,
        GraffityModel.ar: ar,
        GraffityModel.artist: artist,
        GraffityModel.audio: audio,
        GraffityModel.avatar: avatar,
        GraffityModel.bio: bio,
        GraffityModel.city: city,
        GraffityModel.description: description,
        GraffityModel.insta: insta,
        GraffityModel.insta2: insta2,
        GraffityModel.latlng: latlng,
      };
}
