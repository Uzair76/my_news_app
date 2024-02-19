
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_news_app/model/news_channels_categories_model.dart';
import 'package:my_news_app/model/news_channels_headlines_model.dart';

class NewsRepository{

  Future<NewsChannelsHeadlinesModel> fetchNewsChannelsHeadlinesApi(String channelName) async{

    String url= 'https://newsapi.org/v2/top-headlines?sources=${channelName}&apiKey=d950d54b43a946d6b3445bbb5603dfe8';

    final response= await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      final body= jsonDecode(response.body);
      return NewsChannelsHeadlinesModel.fromJson(body);

    }
    throw Exception('Error');
  }


  Future<NewsChannelsCategoriesModel> fetchNewsChannelsCategories(String category) async{

    String url= 'https://newsapi.org/v2/everything?q=${category}&apiKey=d950d54b43a946d6b3445bbb5603dfe8';

    final response= await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      final body= jsonDecode(response.body);
      return NewsChannelsCategoriesModel.fromJson(body);

    }
    throw Exception('Error');
  }


}