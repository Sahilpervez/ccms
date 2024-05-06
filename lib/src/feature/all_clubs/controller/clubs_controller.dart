import 'dart:developer';

import 'package:ccms/src/feature/all_clubs/repository/clubs_repository.dart';
import 'package:ccms/src/global/providers/common_providers.dart';
import 'package:ccms/src/global/repo/events_repo.dart';
import 'package:ccms/src/models/club.dart';
import 'package:ccms/src/models/events.dart';
import 'package:ccms/src/utils/config.dart';
import 'package:ccms/src/utils/snackbar_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final clubsControllerProvider =
    StateNotifierProvider<ClubsController, List<Club>>((ref) {
  final repo = ref.watch(clubsRepoProvider);
  return ClubsController(ref: ref, repo: repo);
});

class ClubsController extends StateNotifier<List<Club>> {
  final ClubsRepo _repo;
  final _name = "CLUBS CONTROLLER";
  ClubsController({required ref, required repo})
      : _ref = ref,_repo = repo,
        super([]);
  final StateNotifierProviderRef<ClubsController, List<Club>> _ref;

  // Add Clubs;  
  void addClubs(Club club){
    state.add(club);
    _repo.addClub(club);
  }

  Future<List<Club>?> getClubsFromRepo({ BuildContext? context }) async {
    final clubsFetchStatus = _ref.read(isClubsFetchedProvider);
    print ("CLUBS FEFTCH STATUS : $clubsFetchStatus");
    if(clubsFetchStatus == true && state.isNotEmpty){
      return [...state];
    }

    final result = await _repo.getClubs();
    
    return result.fold(
      (failure){
        if(AppConfig.devMode && context!=null){
          SnackBarService.showSnackBar(context: context, message: "Clubs loading failed, Please try again later");
        }
        return null;
      },
      (events){
        if(AppConfig.devMode && context!=null){
          SnackBarService.showSnackBar(context: context, message: "Clubs loaded");
        }
        if(events != null){
          state = [...events];
        }
        _ref.read(isClubsFetchedProvider.notifier).update((state) => true,);
        return events;
      },
    );
  }
  
  
}
