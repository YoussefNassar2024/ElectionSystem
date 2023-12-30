import 'package:vote/models/poll_model.dart';
import 'package:vote/models/results_model.dart';

class PollHistoryItem {
  final Poll? poll;
  final Results? results;
  final bool isPollCreator;
  PollHistoryItem(
      {required this.poll, required this.results, required this.isPollCreator});
}
