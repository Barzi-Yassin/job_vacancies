// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class JobVacanciesModel {
  String name;
  String phoneNumber;
  String jobCategory;
  String city;
  String email;
  String uid;
  JobVacanciesModel({
    required this.name,
    required this.phoneNumber,
    required this.jobCategory,
    required this.city,
    required this.email,
    required this.uid,
  });


  JobVacanciesModel copyWith({
    String? name,
    String? phoneNumber,
    String? jobCategory,
    String? city,
    String? email,
    String? uid,
  }) {
    return JobVacanciesModel(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      jobCategory: jobCategory ?? this.jobCategory,
      city: city ?? this.city,
      email: email ?? this.email,
      uid: uid ?? this.uid,
    );
  }

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

  factory JobVacanciesModel.fromMap(Map<String, dynamic> map) {
    return JobVacanciesModel(
      name: map['name'] as String,
      phoneNumber: map['phoneNumber'] as String,
      jobCategory: map['jobCategory'] as String,
      city: map['city'] as String,
      email: map['email'] as String,
      uid: map['uid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory JobVacanciesModel.fromJson(String source) => JobVacanciesModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'JobVacanciesModel(name: $name, phoneNumber: $phoneNumber, jobCategory: $jobCategory, city: $city, email: $email, uid: $uid)';
  }

  @override
  bool operator ==(covariant JobVacanciesModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.phoneNumber == phoneNumber &&
      other.jobCategory == jobCategory &&
      other.city == city &&
      other.email == email &&
      other.uid == uid;
  }

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
