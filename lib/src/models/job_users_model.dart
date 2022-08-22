// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class JobUserModel {
  JobUserModel({
    required this.name,
    required this.phoneNumber,
    required this.jobCategory,
    required this.city,
    required this.email,
    required this.uid,
  });
  String name;
  String phoneNumber;
  String jobCategory;
  String city;
  String email;
  String uid;

  // copyWith is used to update a property
  JobUserModel copyWith({
    String? name,
    String? phoneNumber,
    String? jobCategory,
    String? city,
    String? email,
    String? uid,
  }) {
    return JobUserModel(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      jobCategory: jobCategory ?? this.jobCategory,
      city: city ?? this.city,
      email: email ?? this.email,
      uid: uid ?? this.uid,
    );
  }



  // toMap is used to write a property
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'phoneNumber': phoneNumber,
      'jobCategory': jobCategory,
      'city': city,
      'email': email,
      'uid': uid,
    };
  }

  // toMap is used to read a property (get data from database)
  factory JobUserModel.fromMap(Map<String, dynamic> map) {
    return JobUserModel(
      name: map['name'] as String,
      phoneNumber: map['phoneNumber'] as String,
      jobCategory: map['jobCategory'] as String,
      city: map['city'] as String,
      email: map['email'] as String,
      uid: map['uid'] as String,
    );
  }


  // Jsin is an objet of map
  // toJson is used to encode a property
  String toJson() => json.encode(toMap());

  factory JobUserModel.fromJson(String source) =>
      JobUserModel.fromMap(json.decode(source) as Map<String, dynamic>);



  @override
  String toString() {
    return 'JobVacanciesModel(name: $name, phoneNumber: $phoneNumber, jobCategory: $jobCategory, city: $city, email: $email, uid: $uid)';
  }

  // compare two users
  // user1 == user2 
  @override
  bool operator ==(covariant JobUserModel other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.phoneNumber == phoneNumber &&
        other.jobCategory == jobCategory &&
        other.city == city &&
        other.email == email &&
        other.uid == uid;
  }


  // useful when we cimmunicate data, when we send data to some other api that we don't trust it.
  @override
  int get hashCode {
    return name.hashCode ^
        phoneNumber.hashCode ^
        jobCategory.hashCode ^
        city.hashCode ^
        email.hashCode ^
        uid.hashCode;
  }
}
