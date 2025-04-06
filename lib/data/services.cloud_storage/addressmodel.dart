import 'package:cloud_firestore/cloud_firestore.dart';

class Addressmodel {
  final String uid;
  final String firstName;
  final String lastName;
  final String phone;
  final String pincode;
  final String flat;
  final String street;
  final String landmark;
  final String city;
  final String state;
  final String addressType; // Use String for clarity: 'Home', 'Work', etc.
  final DateTime? time;

  Addressmodel({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.pincode,
    required this.flat,
    required this.street,
    required this.landmark,
    required this.city,
    required this.state,
    required this.addressType,
    this.time,
  });

  /// Empty instance for defaults
  static Addressmodel empty() => Addressmodel(
    uid: "",
    firstName: "",
    lastName: "",
    phone: "",
    pincode: "",
    flat: "",
    street: "",
    landmark: "",
    city: "",
    state: "",
    addressType: "Home", // or "Work" as default
  );

  /// Convert Addressmodel to Firestore Map
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'phone': phone,
      'pincode': pincode,
      'flat': flat,
      'street': street,
      'landmark': landmark,
      'city': city,
      'state': state,
      'addressType': addressType,
      'createdAt':
          time != null
              ? Timestamp.fromDate(time!)
              : FieldValue.serverTimestamp(),
    };
  }

  /// Create Addressmodel from Firestore Map
  factory Addressmodel.fromMap(Map<String, dynamic> map) {
    return Addressmodel(
      uid: map['uid'] ?? '',
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      phone: map['phone'] ?? '',
      pincode: map['pincode'] ?? '',
      flat: map['flat'] ?? '',
      street: map['street'] ?? '',
      landmark: map['landmark'] ?? '',
      city: map['city'] ?? '',
      state: map['state'] ?? '',
      addressType: map['addressType'] ?? 'Home',
      time:
          map['createdAt'] != null
              ? (map['createdAt'] as Timestamp).toDate()
              : null,
    );
  }
}
