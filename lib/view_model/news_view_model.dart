

import 'package:my_news_app/model/news_channels_categories_model.dart';
import 'package:my_news_app/model/news_channels_headlines_model.dart';

import '../repository/news_repository.dart';

class NewsViewModel{
  final _rep= NewsRepository();
  Future<NewsChannelsHeadlinesModel> fetchNewsChannelsHeadlinesApi(String channelName) async{
    final response= await _rep.fetchNewsChannelsHeadlinesApi(channelName);
    return response ;
  }

  Future<NewsChannelsCategoriesModel> fetchNewsChannelsCategories(String category) async{
    final response= await _rep.fetchNewsChannelsCategories(category);
    return response ;
  }

}