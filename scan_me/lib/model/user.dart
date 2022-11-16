import 'package:cloud_firestore/cloud_firestore.dart';

class UserClass{
  String id;
  final String name;
  final String email;

  UserClass({
    this.id = '',
    required this.name,
    required this.email,
  });

  Map<String,dynamic> toJson() =>{
    'id' :id,
    'name':name,
    'email':email
  };
  static UserClass fromJson(Map<String,dynamic> json)=>UserClass(
    id: json['id'],
    name : json['name'],
    email: json['email']
  );

}