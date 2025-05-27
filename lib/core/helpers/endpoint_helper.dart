import 'package:tmdb_web/core/networking/constants.dart';
import 'package:tmdb_web/private.dart';

class EndpointHelper {
  static String getEndPoint({
    int? typeIndex,
    required String category,
    int? page,
    String? query,
  }) {
    return "${Constants.baseUrl}${typeIndex != null ? Constants.types[typeIndex] : ''}$category?api_key=$apiKey&language=en-US${query != null ? '&query=$query' : ''}${page != null ? '&page=$page' : ''}";
  }
}
