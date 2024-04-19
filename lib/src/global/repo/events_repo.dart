import 'package:ccms/src/models/events.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';



final eventsRepoProvider = Provider<EventsRepo>((ref) {
  return EventsRepo();
});


// class NearestEventsRepo extends StateNotifier<List<NearestEvents>> {
class EventsRepo{
  // NearestEventsRepo() : super([
  //   NearestEvents(
  //     eventDate: DateTime.now().copyWith(hour: 18, minute: 15),
  //     eventLength: Duration(hours: 4),
  //     eventName: "Follow up with the client",
  //     priority: "High",
  //   ),
  //   NearestEvents(
  //     eventDate: DateTime.now().copyWith(hour: 17, minute: 30).add(Duration(days: 1)),
  //     eventLength: Duration(hours: 4),
  //     eventName: "Meeting with Development Team",
  //     priority: "High",
  //   ),
  //   NearestEvents(
  //     eventDate: DateTime.now().copyWith(hour: 17),
  //     eventLength: Duration(hours: 2),
  //     eventName: "Abhigyna Birthday",
  //     priority: "Low",
  //   ),
  //   NearestEvents(
  //     eventDate: DateTime(2023,9,15),
  //     eventLength: Duration(hours: 3),
  //     eventName: "Connecting new lead",
  //     priority: "Low",
  //   ),
  // ]);

  final _events = [
    // Event(
    //   eventDate: DateTime.now().copyWith(hour: 18, minute: 15),
    //   eventLength: const Duration(hours: 4),
    //   eventName: "Follow up with the client",
    //   priority: "High",
    //   icon: {"icon":ImageAssets.kiNearestEventsActive,"color" :const Color(0xff3F8CFF)},
    // ),
    // Event(
    //   eventDate: DateTime.now().copyWith(hour: 17, minute: 30).add(const Duration(days: 1)),
    //   eventLength: const Duration(hours: 4),
    //   eventName: "Meeting with Development Team",
    //   priority: "High",
    //   icon: {"icon":ImageAssets.kiNearestEventsMeeting,"color" :const Color(0xffFDC748)}
    // ),
    // Event(
    //   eventDate: DateTime.now().copyWith(hour: 17,minute: 10),
    //   eventLength: const Duration(hours: 2),
    //   eventName: "Abhigyna Birthday",
    //   priority: "Low",icon: {"icon":ImageAssets.kiNearestEventsBirthDay,"color" :const Color(0xffDE92EB)},
    // ),
    // Event(
    //   eventDate: DateTime(2023,9,15),
    //   eventLength: const Duration(hours: 3),
    //   eventName: "Connecting new lead",
    //   priority: "Low",
    //   icon: {"icon" : ImageAssets.kiNearestEventsConnect,"color" :const Color(0xff6D5DD3)}
    // ),
    
  ];

  Future<void> fetchEventsFromAPI() async {
    // Populate state with items from api if not exist in state
  }

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

  void addEvent(Event event){
    _events.add(event);
  }

  List<Event> getEvents (){

    return [..._events];
  }
}
