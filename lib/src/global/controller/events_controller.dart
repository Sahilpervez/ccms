import 'package:ccms/src/global/repo/events_repo.dart';
import 'package:ccms/src/models/events.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final eventsControllerProvider =
    StateNotifierProvider<EventsController, List<Event>>((ref) {
  final repo = ref.watch(eventsRepoProvider);
  return EventsController(ref: ref, repo: repo);
});

class EventsController extends StateNotifier<List<Event>> {
  final EventsRepo _repo;
  EventsController({required ref, required repo})
      : _ref = ref,_repo = repo,
        super([...repo.getEvents()]);
  final _ref;

  // Add Events;  
  void addEvents(Event event){
    state.add(event);
    _repo.addEvent(event);
  }

  // Future<List<NearestEvents>?> getEventsFromRepo({ BuildContext? context }) async {

  //   final result = await _repo.getEvents();
    
  //   return [...result];
    
  //   // return result.fold(
  //   //   (failure){
  //   //     if(AppConfig.devMode && context!=null){
  //   //       SnackBarService.showSnackBar(context: context, message: "Events loading failed, Please try again later");
  //   //     }
  //   //     return null;
  //   //   },
  //   //   (products){
  //   //     if(AppConfig.devMode && context!=null){
  //   //       SnackBarService.showSnackBar(context: context, message: "Events loaded");
  //   //     }
  //   //     return products;
  //   //   },
  //   // );
  // }
  
}
