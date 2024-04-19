// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:ccms/src/models/events.dart';
import 'package:ccms/src/models/student.dart';

class Attendance {

  final int eventID;
  final String enrollmentNumber;
  final bool? checkedIn;
  final Student students;
  final Event events;  
  Attendance({
    this.eventID = 0,
    this.enrollmentNumber = '',
    this.checkedIn,
    required this.students,
    required this.events,
  });


  // Prisma Schema
  // 
  // model Attendance {
  //   event_id          Int      @default(autoincrement())
  //   enrollment_number String   @db.VarChar
  //   checked_in        Boolean?
  //   students          Student  @relation(fields: [enrollment_number], references: [enrollment_number], onDelete: NoAction, onUpdate: NoAction, map: "attendance_enrollment_number_students_enrollment_number_fk")
  //   events            Event    @relation(fields: [event_id], references: [event_id], onDelete: NoAction, onUpdate: NoAction, map: "attendance_event_id_events_event_id_fk")

  //   @@id([event_id, enrollment_number], map: "attendance_event_id_enrollment_number_pk")
  //   @@map("attendance")
  // }


  Attendance copyWith({
    int? eventID,
    String? enrollmentNumber,
    bool? checkedIn,
    Student? students,
    Event? events,
  }) {
    return Attendance(
      eventID: eventID ?? this.eventID,
      enrollmentNumber: enrollmentNumber ?? this.enrollmentNumber,
      checkedIn: checkedIn ?? this.checkedIn,
      students: students ?? this.students,
      events: events ?? this.events,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'eventID': eventID,
      'enrollmentNumber': enrollmentNumber,
      'checkedIn': checkedIn,
      'students': students.toMap(),
      'events': events.toMap(),
    };
  }

  factory Attendance.fromMap(Map<String, dynamic> map) {
    return Attendance(
      eventID: map['eventID'] as int,
      enrollmentNumber: map['enrollmentNumber'] as String,
      checkedIn: map['checkedIn'] != null ? map['checkedIn'] as bool : null,
      students: Student.fromMap(map['students'] as Map<String,dynamic>),
      events: Event.fromMap(map['events'] as Map<String,dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory Attendance.fromJson(String source) => Attendance.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Attendance(eventID: $eventID, enrollmentNumber: $enrollmentNumber, checkedIn: $checkedIn, students: $students, events: $events)';
  }

  @override
  bool operator ==(covariant Attendance other) {
    if (identical(this, other)) return true;
  
    return 
      other.eventID == eventID &&
      other.enrollmentNumber == enrollmentNumber &&
      other.checkedIn == checkedIn &&
      other.students == students &&
      other.events == events;
  }

  @override
  int get hashCode {
    return eventID.hashCode ^
      enrollmentNumber.hashCode ^
      checkedIn.hashCode ^
      students.hashCode ^
      events.hashCode;
  }
}
