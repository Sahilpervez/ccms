// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:ccms/src/models/attendance.dart';
import 'package:ccms/src/models/enums.dart';
import 'package:ccms/src/models/events.dart';
import 'package:ccms/src/models/membership.dart';

/// Sample User class just to demonstrate Authentication.

class Student {
  final String enrollmentNumber;
  final String firstName;
  final String lastName;
  final int? credits;
  final String cisId;
  final String password;
  final List<ClubsEnum> inClubAsTeam;
  final List<ClubsEnum> inClubAsMember;
  final List<Attendance> attendance;
  final List<Event> events;
  final List<Membership> membership;
  Student({
    this.enrollmentNumber = '',
    this.firstName = '',
    this.lastName = '',
    this.credits,
    this.cisId = '',
    this.password = '',
    this.inClubAsTeam = const [],
    this.inClubAsMember = const [],
    this.attendance = const [],
    this.events = const [],
    this.membership = const [],
  });

  // Prisma Schema
  //
  // model Student {
  // enrollment_number                         String       @id @db.VarChar(9)
  // first_name                                String       @db.VarChar
  // last_name                                 String?      @db.VarChar
  // credits                                   Int?         @default(0)
  // cis_id                                    String?      @db.VarChar
  // password                                  String?      @db.VarChar
  // in_club_as_team                           clubs_enum[]
  // in_club_as_member                         clubs_enum[]
  // attendance                                Attendance[]
  // clubs_clubs_club_presidentTostudents      Club[]       @relation("clubs_club_presidentTostudents")
  // clubs_clubs_club_secretaryTostudents      Club[]       @relation("clubs_club_secretaryTostudents")
  // clubs_clubs_club_treasurerTostudents      Club[]       @relation("clubs_club_treasurerTostudents")
  // clubs_clubs_club_vice_presidentTostudents Club[]       @relation("clubs_club_vice_presidentTostudents")
  // events                                    Event[]
  // membership                                Membership[]

  // @@map("students")
  // }

  Student copyWith({
    String? enrollmentNumber,
    String? firstName,
    String? lastName,
    int? credits,
    String? cisId,
    String? password,
    List<ClubsEnum>? inClubAsTeam,
    List<ClubsEnum>? inClubAsMember,
    List<Attendance>? attendance,
    List<Event>? events,
    List<Membership>? membership,
  }) {
    return Student(
      enrollmentNumber: enrollmentNumber ?? this.enrollmentNumber,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      credits: credits ?? this.credits,
      cisId: cisId ?? this.cisId,
      password: password ?? this.password,
      inClubAsTeam: inClubAsTeam ?? this.inClubAsTeam,
      inClubAsMember: inClubAsMember ?? this.inClubAsMember,
      attendance: attendance ?? this.attendance,
      events: events ?? this.events,
      membership: membership ?? this.membership,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'enrollmentNumber': enrollmentNumber,
      'firstName': firstName,
      'lastName': lastName,
      'credits': credits,
      'cisId': cisId,
      'password': password,
      'inClubAsTeam': inClubAsTeam.map((x) => x.toString()).toList(), // TODO : TEST THIS !!
      'inClubAsMember': inClubAsMember.map((x) => x.toString()).toList(), // TODO : TEST THIS !!
      'attendance': attendance.map((x) => x.toMap()).toList(),
      'events': events.map((x) => x.toMap()).toList(),
      'membership': membership.map((x) => x.toMap()).toList(),
    };
  }

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      enrollmentNumber: map['enrollmentNumber'] as String,
      firstName: map['firstName'] as String,
      lastName: map['lastName'] as String,
      credits: map['credits'] != null ? map['credits'] as int : null,
      cisId: map['cisId'] as String,
      password: map['password'] as String,
      inClubAsTeam: List<ClubsEnum>.from(
        (map['inClubAsTeam'] as List<String>).map<ClubsEnum>(
          // (x) => ClubsEnum.fromMap(x as Map<String, dynamic>),
          (x){
            if(x == "cold"){
              ClubsEnum.cold;
            }else if(x == "loop"){
              return ClubsEnum.loop;
            }else if(x == "gdsc"){
              return ClubsEnum.gdsc;
            }
            // else if(x == "volt"){
              
            // }
            return ClubsEnum.volt;
          }
        ),
      ),
      inClubAsMember: List<ClubsEnum>.from(
        (map['inClubAsMember'] as List<int>).map<ClubsEnum>(
          (x){
            if(x == "cold"){
              ClubsEnum.cold;
            }else if(x == "loop"){
              return ClubsEnum.loop;
            }else if(x == "gdsc"){
              return ClubsEnum.gdsc;
            }
            // else if(x == "volt"){
              
            // }
            return ClubsEnum.volt;
          }
        ),
      ),
      attendance: List<Attendance>.from(
        (map['attendance'] as List<int>).map<Attendance>(
          (x) => Attendance.fromMap(x as Map<String, dynamic>),
        ),
      ),
      events: List<Event>.from(
        (map['events'] as List<int>).map<Event>(
          (x) => Event.fromMap(x as Map<String, dynamic>),
        ),
      ),
      membership: List<Membership>.from(
        (map['membership'] as List<int>).map<Membership>(
          (x) => Membership.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Student.fromJson(String source) =>
      Student.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Student(enrollmentNumber: $enrollmentNumber, firstName: $firstName, lastName: $lastName, credits: $credits, cisId: $cisId, password: $password, inClubAsTeam: $inClubAsTeam, inClubAsMember: $inClubAsMember, attendance: $attendance, events: $events, membership: $membership)';
  }

  @override
  bool operator ==(covariant Student other) {
    if (identical(this, other)) return true;

    return other.enrollmentNumber == enrollmentNumber &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.credits == credits &&
        other.cisId == cisId &&
        other.password == password &&
        listEquals(other.inClubAsTeam, inClubAsTeam) &&
        listEquals(other.inClubAsMember, inClubAsMember) &&
        listEquals(other.attendance, attendance) &&
        listEquals(other.events, events) &&
        listEquals(other.membership, membership);
  }

  @override
  int get hashCode {
    return enrollmentNumber.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        credits.hashCode ^
        cisId.hashCode ^
        password.hashCode ^
        inClubAsTeam.hashCode ^
        inClubAsMember.hashCode ^
        attendance.hashCode ^
        events.hashCode ^
        membership.hashCode;
  }
}
