import 'Course.dart';
import 'GroupEnum.dart';

class SearchResult {
  String? searchText;
  Map<GroupEnum, List<Course>>? searchResults = new Map();
}