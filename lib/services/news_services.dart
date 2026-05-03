import 'dart:io';

import 'package:dio/dio.dart';
import 'package:news/models/news_model.dart';

// This file defines the NewsService interface and its implementation, NewsServices, which is responsible for fetching news articles from the News API using the Dio HTTP client.
//The service includes error handling and data parsing
//to ensure that the application can gracefully handle API responses and errors.
//abstract class NewsService to define the contract for fetching news,
// allowing for flexibility and easier testing. The NewsServices class implements this interface and provides the actual logic for making API requests and parsing responses.
abstract class NewsService {
  Future<List<NewsModel>> getNews({required String category});
}

class NewsServices implements NewsService {
  final Dio _dio;
  static const String _apiKey = '4e4a82ec7a6f4bb6ae19c8236c358c22';
  static const String _baseUrl = 'https://newsapi.org/v2/top-headlines';

  NewsServices(this._dio);

  @override
  Future<List<NewsModel>> getNews({required String category}) async {
    try {
      final normalizedCategory = _normalizeCategory(category);
      final response = await _fetchNewsData(normalizedCategory);
      return _parseNewsData(response);
    } on DioException catch (e) {
      // Handle network errors
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout ||
          e.type == DioExceptionType.sendTimeout) {
        throw Exception(
            'Connection timeout. Please check your internet connection.');
      } else if (e.type == DioExceptionType.unknown) {
        final errorMsg = e.message ?? '';
        final errorStr = e.error?.toString() ?? '';

        // Check for network connectivity issues
        if (e.error is SocketException ||
            errorMsg.contains('Failed host lookup') ||
            errorMsg.contains('Connection refused') ||
            errorMsg.contains('Connection errored') ||
            errorStr.contains('Failed host lookup') ||
            errorStr.contains('Connection refused')) {
          throw Exception('No internet connection detected');
        }
        throw Exception('Network error: $errorMsg');
      } else if (e.type == DioExceptionType.badResponse) {
        throw Exception('Server error: ${e.response?.statusCode}');
      } else {
        throw Exception('Network error: ${e.message}');
      }
    } catch (e) {
      throw Exception('Failed to load news: $e');
    }
  }

// The _normalizeCategory method ensures that the category string is in a consistent format before making the API request, which can help prevent issues with case sensitivity or extra whitespace. The _fetchNewsData method handles the actual API request using Dio, while the _parseNewsData method processes the response and converts it into a list of NewsModel instances.
  String _normalizeCategory(String category) {
    return category.toLowerCase().trim();
  }

  Future<Response> _fetchNewsData(String category) async {
    return await _dio.get(
      _baseUrl,
      queryParameters: {
        'apiKey': _apiKey,
        'country': 'us',
        'category': category,
      },
    );
  }

  List<NewsModel> _parseNewsData(Response response) {
    final newsdata = response.data as Map<String, dynamic>;
    if (newsdata['status'] != 'ok') {
      final message = newsdata['message'] ?? 'Unknown error';
      throw Exception('News API error: $message');
    }

    final List articles = List.from(newsdata['articles'] ?? []);

    return articles
        .map((article) => NewsModel.fromJson(article as Map<String, dynamic>))
        .toList();
    // return articles.map((i)=>NewsModel.fromJson(i as Map<String,dynamic>)).toList();
  }
}
