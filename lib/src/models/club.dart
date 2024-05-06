// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:ccms/src/models/events.dart';
import 'package:ccms/src/models/faculty.dart';
import 'package:ccms/src/models/membership.dart';

class Club {

  final int clubId;
  final String clubName;
  final String clubDescription;
  final bool? isTechnical;
  final int clubMentor;
  final String? clubPresident;
  final String? clubVicePresident;
  final String? clubSecretary;
  final String clubTreasurer;
  final int? eventCount;
  // final Faculty faculties;
  final List<Event>? events;
  // final List<Membership> membership; 
  Club({
    this.clubId = 0,
    this.clubName = '',
    this.clubDescription = '',
    this.isTechnical,
    this.clubMentor = 0,
    this.clubPresident,
    this.clubVicePresident,
    this.clubSecretary,
    this.clubTreasurer = '',
    this.eventCount,
    // required this.faculties,
    this.events,
    // this.membership = const [],
  });


  // model Club {
    // club_id                                      Int          @id @default(autoincrement())
    // club_name                                    String       @db.VarChar
    // club_description                             String?
    // is_technical                                 Boolean
    // club_mentor                                  Int          @default(autoincrement()) //should it be auto-increment?
    // club_president                               String?      @db.VarChar(9)
    // club_vice_president                          String?      @db.VarChar(9)
    // club_secretary                               String?      @db.VarChar(9)
    // club_treasurer                               String?      @db.VarChar(9)
    // event_count                                  Int?
    // faculties                                    Faculty      @relation(fields: [club_mentor], references: [faculty_id], onDelete: NoAction, onUpdate: NoAction, map: "clubs_club_mentor_faculties_faculty_id_fk")
    // students_clubs_club_presidentTostudents      Student?     @relation("clubs_club_presidentTostudents", fields: [club_president], references: [enrollment_number], onDelete: NoAction, onUpdate: NoAction, map: "clubs_club_president_students_enrollment_number_fk")
    // students_clubs_club_secretaryTostudents      Student?     @relation("clubs_club_secretaryTostudents", fields: [club_secretary], references: [enrollment_number], onDelete: NoAction, onUpdate: NoAction, map: "clubs_club_secretary_students_enrollment_number_fk")
    // students_clubs_club_treasurerTostudents      Student?     @relation("clubs_club_treasurerTostudents", fields: [club_treasurer], references: [enrollment_number], onDelete: NoAction, onUpdate: NoAction, map: "clubs_club_treasurer_students_enrollment_number_fk")
    // students_clubs_club_vice_presidentTostudents Student?     @relation("clubs_club_vice_presidentTostudents", fields: [club_vice_president], references: [enrollment_number], onDelete: NoAction, onUpdate: NoAction, map: "clubs_club_vice_president_students_enrollment_number_fk")
    // events                                       Event[] //what is this?
    // membership                                   Membership[]

  //   @@map("clubs")
  // }

  Club copyWith({
    int? clubId,
    String? clubName,
    String? clubDescription,
    bool? isTechnical,
    int? clubMentor,
    String? clubPresident,
    String? clubVicePresident,
    String? clubSecretary,
    String? clubTreasurer,
    int? eventCount,
    Faculty? faculties,
    List<Event>? events,
    List<Membership>? membership,
  }) {
    return Club(
      clubId: clubId ?? this.clubId,
      clubName: clubName ?? this.clubName,
      clubDescription: clubDescription ?? this.clubDescription,
      isTechnical: isTechnical ?? this.isTechnical,
      clubMentor: clubMentor ?? this.clubMentor,
      clubPresident: clubPresident ?? this.clubPresident,
      clubVicePresident: clubVicePresident ?? this.clubVicePresident,
      clubSecretary: clubSecretary ?? this.clubSecretary,
      clubTreasurer: clubTreasurer ?? this.clubTreasurer,
      eventCount: eventCount ?? this.eventCount,
      // faculties: faculties ?? this.faculties,
      events: events ?? this.events,
      // membership: membership ?? this.membership,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'club_id': clubId,
      'club_name': clubName,
      'club_description': clubDescription,
      'is_technical': isTechnical,
      'club_mentor': clubMentor,
      'club_president': clubPresident,
      'club_vice_president': clubVicePresident,
      'club_secretary': clubSecretary,
      'club_treasurer': clubTreasurer,
      'event_count': eventCount,
      // 'faculties': faculties.toMap(),
      'events': events?.map((x) => x.toMap()).toList() ?? [],
      // 'membership': membership.map((x) => x.toMap()).toList(),
    };
  }

  factory Club.fromMap(Map<String, dynamic> map) {
    return Club(
      clubId: map['club_id'] as int,
      clubName: map['club_name'] as String,
      clubDescription: map['club_description'] as String,
      isTechnical: map['is_technical'] != null ? map['is_technical'] as bool : null,
      clubMentor: map['club_mentor'] as int,
      clubPresident: map['club_president'] != null ? map['club_president'] as String : null,
      clubVicePresident: map['club_vice_president'] != null ? map['club_vice_president'] as String : null,
      clubSecretary: map['club_secretary'] != null ? map['club_secretary'] as String : null,
      clubTreasurer: map['club_treasurer'] as String,
      eventCount: map['event_count'] != null ? map['event_count'] as int : null,
      // faculties: Faculty.fromMap(map['faculties'] as Map<String,dynamic>),
      events: List<Event>.from((map['events']).map<Event>((x) => Event.fromMap(x as Map<String,dynamic>),),),
      // membership: List<Membership>.from((map['membership'] as List<int>).map<Membership>((x) => Membership.fromMap(x as Map<String,dynamic>),),),
    );
  }

  String toJson() => json.encode(toMap());

  factory Club.fromJson(String source) => Club.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Club(clubId: $clubId, clubName: $clubName, clubDescription: $clubDescription, isTechnical: $isTechnical, clubMentor: $clubMentor, clubPresident: $clubPresident, clubVicePresident: $clubVicePresident, clubSecretary: $clubSecretary, clubTreasurer: $clubTreasurer, eventCount: $eventCount,events: $events,)';
  }

  @override
  bool operator ==(covariant Club other) {
    if (identical(this, other)) return true;
  
    return 
      other.clubId == clubId &&
      other.clubName == clubName &&
      other.clubDescription == clubDescription &&
      other.isTechnical == isTechnical &&
      other.clubMentor == clubMentor &&
      other.clubPresident == clubPresident &&
      other.clubVicePresident == clubVicePresident &&
      other.clubSecretary == clubSecretary &&
      other.clubTreasurer == clubTreasurer &&
      other.eventCount == eventCount &&
      // other.faculties == faculties &&
      listEquals(other.events, events);
      //  &&
      // listEquals(other.membership, membership);
  }

  @override
  int get hashCode {
    return clubId.hashCode ^
      clubName.hashCode ^
      clubDescription.hashCode ^
      isTechnical.hashCode ^
      clubMentor.hashCode ^
      clubPresident.hashCode ^
      clubVicePresident.hashCode ^
      clubSecretary.hashCode ^
      clubTreasurer.hashCode ^
      eventCount.hashCode ^
      // faculties.hashCode ^
      events.hashCode;
      //  ^
      // membership.hashCode;
  }
}
