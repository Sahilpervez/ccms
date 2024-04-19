import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ccms/src/models/student.dart';

/// Watch the [authTokenProvider] to check if the user is logged in.
final authTokenProvider = StateProvider<String?>((ref) => null);

final currentUserProvider = StateProvider<Student?>((ref) => null);