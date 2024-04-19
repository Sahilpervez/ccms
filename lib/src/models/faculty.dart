// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:ccms/src/models/club.dart';

class Faculty {
final int facultyId;
final String facultyName;
final List<Club> clubs;
  Faculty({
    this.facultyId = 0,
    this.facultyName = '',
    this.clubs = const [],
  });

//   model Faculty {
//   faculty_id   Int    @id @default(autoincrement())
//   faculty_name String @db.VarChar
//   clubs        Club[]

//   @@map("faculties")
// }

  Faculty copyWith({
    int? facultyId,
    String? facultyName,
    List<Club>? clubs,
  }) {
    return Faculty(
      facultyId: facultyId ?? this.facultyId,
      facultyName: facultyName ?? this.facultyName,
      clubs: clubs ?? this.clubs,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'facultyId': facultyId,
      'facultyName': facultyName,
      'clubs': clubs.map((x) => x.toMap()).toList(),
    };
  }

  factory Faculty.fromMap(Map<String, dynamic> map) {
    return Faculty(
      facultyId: map['facultyId'] as int,
      facultyName: map['facultyName'] as String,
      clubs: List<Club>.from((map['clubs'] as List<int>).map<Club>((x) => Club.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory Faculty.fromJson(String source) => Faculty.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Faculty(facultyId: $facultyId, facultyName: $facultyName, clubs: $clubs)';

  @override
  bool operator ==(covariant Faculty other) {
    if (identical(this, other)) return true;
  
    return 
      other.facultyId == facultyId &&
      other.facultyName == facultyName &&
      listEquals(other.clubs, clubs);
  }

  @override
  int get hashCode => facultyId.hashCode ^ facultyName.hashCode ^ clubs.hashCode;
}
