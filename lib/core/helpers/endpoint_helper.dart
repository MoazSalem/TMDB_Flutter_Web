import 'package:tmdb_web/core/networking/constants.dart';
import 'package:tmdb_web/private.dart';

class EndpointHelper {
  static String getEndPoint({
    int? typeIndex,
    int? id,
    String? category,
    int? page,
    String? query,
    bool adult = false,
  }) {
    return "${Constants.baseUrl}${typeIndex != null ? Constants.types[typeIndex] : ''}${id ?? ''}${category ?? ''}?api_key=$apiKey${adult ? '' : '&include_adult=true'}&language=en-US${query != null ? '&query=$query' : ''}${page != null ? '&page=$page' : ''}";
  }
}
