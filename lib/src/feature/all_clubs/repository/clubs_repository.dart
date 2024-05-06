import 'dart:convert';
import 'dart:developer';
import 'package:ccms/src/models/club.dart';
import 'package:ccms/src/models/events.dart';
import 'package:ccms/src/res/endpoints.dart';
import 'package:ccms/src/res/strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ccms/src/core/core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart';

final clubsRepoProvider = Provider<ClubsRepo>((ref) {
  final api = ref.watch(networkRepoProvider);
  return ClubsRepo(api: api);
});

// class NearestClubsRepo extends StateNotifier<List<NearestEvents>> {
class ClubsRepo {
  final NetworkRepo _api;
  final _name = "CLUBS REPO";
  ClubsRepo({required api}) : _api = api;

  Future<void> fetchEventsFromAPI() async {
    // Populate state with items from api if not exist in state
  }
  final List<Club> _clubs = []; 
  // Future<List> getEvents() async {
  //   // TODO: Make API Call and populate the _events List and also the state
  //   // fetchEventsFromAPI();
  //   return [..._events];
  // }

  // Future<void> addEvent(NearestEvents event) async{
  //   // TODO: Make API Call to add Event
  //   _events.add(event);
  //   // state.add(event);
  // }

  void addClub(Club club) {
    _clubs.add(club);
  }

  FutureEither<List<Club>?> getClubs() async {
    final result =
        await _api.getRequest(url: EndPoints.getClubs, requireAuth: false);
    return result.fold(
      (Failure failure) {
        log(failure.message, name: _name);
        return Left(failure);
      },
      (Response response) {
        try {
          final data = jsonDecode(response.body);
          final eventsMap = data['body']['data'];
          int i = 1;
          final List<Club> clubs = [];
          eventsMap.forEach((e) {
            log(e.toString(), name: "ALL CLUBS DATA $i");
            
            clubs.add(
              Club(
                clubId: e['club_id'],
                clubName: e['club_name'],
                clubDescription: e['club_description'],
                isTechnical: e['is_technical'],
                clubMentor: e['club_mentor'],
                clubPresident: e['club_president'],
                clubVicePresident: e['club_vice_president'],
                clubSecretary: e['club_secretary'],
                clubTreasurer: e['club_treasurer'],
                eventCount: e['event_count'],
                events: [],
              )
              // Club.fromMap(e)
            );
            
            i++;
          });
          // for(dynamic product in eventJson){
          //   products.add(Event.fromMap(product));
          // }
          log("Value Returned");
          return Right(clubs);
        } catch (e, stktrc) {
          log(FailureMessage.jsonParsingFailed, name: _name);
          return Left(Failure(
            message: FailureMessage.jsonParsingFailed,
            stackTrace: stktrc,
          ));
        }
      },
    );

    // return [..._events];
  }
}
