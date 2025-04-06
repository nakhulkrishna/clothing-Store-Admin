import 'package:thestyldclubadmin/common/utils/constants/enums.dart';
import 'package:thestyldclubadmin/common/utils/formatters/formatter.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModels {
  final String? id;
  String firstName;
  String lastName;
  String userName;
  String email;
  String phoneNumber;
  String profilePicture;
  AppRole role;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserModels({
    this.id,
    required this.email,
    this.createdAt,
    this.firstName = "",
    this.lastName = "",
    this.userName = "",
    this.profilePicture = "",
    this.phoneNumber = "",
    this.role = AppRole.user,
    this.updatedAt,
  });
  // Helper Methods
  String get fullname => "$firstName $lastName";
  String get formattedDate => TFormatter.formatDate(createdAt);
  String get formattedUpdatedAtDate => TFormatter.formatDate(updatedAt);
  String get formattedPhoneNo => TFormatter.formatPhoneNumber(phoneNumber);

  //static function to create an empty user model.
  static UserModels empty() => UserModels(email: '');

  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'UserName': userName,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
      'Role': role.name.toString(),
      'CreatedAt': createdAt,
      'UpdatedAt': updatedAt = DateTime.now(),
    };
  }

  // Factory method to create a usermodel from a firebase

  factory UserModels.fromSnapshot(
    DocumentSnapshot<Map<String, dynamic>> document,
  ) {
    if (document.data() != null) {
      final data = document.data()!;
      return UserModels(
        id: document.id,
        firstName: data.containsKey('FirstName') ? data['FirstName'] ?? '' : '',
        lastName: data.containsKey('LastName') ? data['LastName'] ?? '' : '',
        userName: data.containsKey('UserName') ? data['UserName'] ?? '' : '',
        email: data.containsKey('Email') ? data['Email'] ?? '' : '',
        phoneNumber:
            data.containsKey('PhoneNumber') ? data['PhoneNumber'] ?? '' : '',
        profilePicture:
            data.containsKey('ProfilePicture')
                ? data['ProfilePicture'] ?? ''
                : '',
        role:
            data.containsKey('Role')
                ? AppRole.values.firstWhere(
                  (r) => r.name == data['Role'],
                  orElse: () => AppRole.user,
                )
                : AppRole.user,
        createdAt:
            data.containsKey('CreatedAt')
                ? (data['CreatedAt'] as Timestamp?)?.toDate() ?? DateTime.now()
                : DateTime.now(),
        updatedAt:
            data.containsKey('UpdatedAt')
                ? (data['UpdatedAt'] as Timestamp?)?.toDate() ?? DateTime.now()
                : DateTime.now(),
      );
    } else {
      return empty(); // Return an empty UserModels object if data is null
    }
  }
}
