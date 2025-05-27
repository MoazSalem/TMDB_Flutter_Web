import 'package:tmdb_web/core/networking/constants.dart';
import 'package:tmdb_web/private.dart';

class EndpointHelper {
  static String getEndPoint({
    int? typeIndex,
    int? id,
    bool? discover,
    String? category,
    int? page,
    String? query,
    String? genre,
    String? sort,
    bool adult = false,
  }) {
    return "${Constants.baseUrl}${discover != null ? 'discover/' : ''}${typeIndex != null ? Constants.types[typeIndex] : ''}${id ?? ''}${category ?? ''}?api_key=$apiKey${adult ? '' : '&include_adult=false&certification_country=US&certification.lte=R'}${sort != null ? '&sort_by=$sort' : ''}&language=en-US${query != null ? '&query=$query' : ''}${genre != null ? '&with_genres=$genre' : ''}${page != null ? '&page=$page' : ''}";
  }
}
