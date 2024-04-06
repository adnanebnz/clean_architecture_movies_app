import 'package:youtube_data_api/youtube_data_api.dart';

class YoutubeDataApiManager {
  static final YoutubeDataApi youtubeDataApi = YoutubeDataApi();
  static YoutubeDataApi getYoutubeApi() {
    return youtubeDataApi;
  }
}
