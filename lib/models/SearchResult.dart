import 'GroupEnum.dart';
import 'School.dart';

class SearchResult {
  String? searchText;
  Map<GroupEnum, List<School>> searchResults = new Map();
}