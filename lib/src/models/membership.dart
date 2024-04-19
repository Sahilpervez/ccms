// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:ccms/src/models/club.dart';
import 'package:ccms/src/models/enums.dart';
import 'package:ccms/src/models/student.dart';

class Membership {
  final String enrollmentNumber;
  final int clubId;
  final int clubCredits;
  final ClubRoles clubRole;
  final Student students;
  final Club clubs;
  Membership({
    this.enrollmentNumber = '',
    this.clubId = 0,
    this.clubCredits = 0,
    required this.clubRole,
    required this.students,
    required this.clubs,
  });

  // model Membership {
  //   enrollment_number String     @db.VarChar(9)
  //   club_id           Int
  //   club_credits      Int
  //   club_role         club_roles
  //   students          Student    @relation(fields: [enrollment_number], references: [enrollment_number], onDelete: NoAction, onUpdate: NoAction, map: "Membership_enrollment_number_students_enrollment_number_fk")
  //   clubs             Club       @relation(fields: [club_id], references: [club_id], onDelete: NoAction, onUpdate: NoAction, map: "Membership_club_id_clubs_club_id_fk")

  //   @@id([enrollment_number, club_id], map: "Membership_enrollment_number_club_id_pk")
  // }

  Membership copyWith({
    String? enrollmentNumber,
    int? clubId,
    int? clubCredits,
    ClubRoles? clubRole,
    Student? students,
    Club? clubs,
  }) {
    return Membership(
      enrollmentNumber: enrollmentNumber ?? this.enrollmentNumber,
      clubId: clubId ?? this.clubId,
      clubCredits: clubCredits ?? this.clubCredits,
      clubRole: clubRole ?? this.clubRole,
      students: students ?? this.students,
      clubs: clubs ?? this.clubs,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'enrollmentNumber': enrollmentNumber,
      'clubId': clubId,
      'clubCredits': clubCredits,
      'clubRole': clubRole.toString(),
      'students': students.toMap(),
      'clubs': clubs.toMap(),
    };
  }

  factory Membership.fromMap(Map<String, dynamic> map) {
    return Membership(
      enrollmentNumber: map['enrollmentNumber'] as String,
      clubId: map['clubId'] as int,
      clubCredits: map['clubCredits'] as int,
      clubRole: (map['clubRole'] == "president")
          ? ClubRoles.president
          : (map['clubRole'] == "vice_president")
              ? ClubRoles.vice_president
              : (map['clubRole'] == "secretary")
                  ? ClubRoles.secretary
                  : (map['clubRole'] == "treasurer")
                  ? ClubRoles.treasurer
                  : (map['clubRole'] == "executive")
                  ? ClubRoles.executive
                  : ClubRoles.member,
      students: Student.fromMap(map['students'] as Map<String, dynamic>),
      clubs: Club.fromMap(map['clubs'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Membership.fromJson(String source) =>
      Membership.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Membership(enrollmentNumber: $enrollmentNumber, clubId: $clubId, clubCredits: $clubCredits, clubRole: $clubRole, students: $students, clubs: $clubs)';
  }

  @override
  bool operator ==(covariant Membership other) {
    if (identical(this, other)) return true;

    return other.enrollmentNumber == enrollmentNumber &&
        other.clubId == clubId &&
        other.clubCredits == clubCredits &&
        other.clubRole == clubRole &&
        other.students == students &&
        other.clubs == clubs;
  }

  @override
  int get hashCode {
    return enrollmentNumber.hashCode ^
        clubId.hashCode ^
        clubCredits.hashCode ^
        clubRole.hashCode ^
        students.hashCode ^
        clubs.hashCode;
  }
}
