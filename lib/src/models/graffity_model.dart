import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/graffity_data.dart';

class GraffityModel extends ChangeNotifier {
  List<GraffityData> _artworks = [];
  List<GraffityData> get artworks => _artworks;

  getGraffitiesData() async {
    var snapshot =
        await FirebaseFirestore.instance.collection('graffities').get();
    _artworks = [];
    var data = snapshot.docs;
    _artworks.addAll(data.map((artwork) {
      return GraffityData(
        id: artwork['id'],
        name: artwork['name'],
        description: artwork['description'],
        city: artwork['city'],
        address: artwork['address'],
        audio: artwork['audio'],
        ar: artwork['ar'],
        latlng: artwork['latlng'],
        artist: artwork['artist'],
        bio: artwork['bio'],
        avatar: artwork['avatar'],
        insta: artwork['insta'],
        insta2: artwork['insta2'],
        photoUrl: artwork['photoUrl'],
        photoSqr: artwork['photoSqr'],
      );
    }).toList());
    _artworks.sort((a, b) => int.parse(a.id).compareTo(int.parse(b.id)));
    notifyListeners();
  }

  void removeAll() {
    _artworks.clear();
    notifyListeners();
  }
}
