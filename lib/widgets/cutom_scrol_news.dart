import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news/models/news_model.dart';
import 'package:news/services/news_services.dart';
import 'package:news/widgets/new_tile.dart';

// This widget is responsible for fetching and displaying news articles based on the provided category.
// It uses a FutureBuilder to manage the asynchronous data fetching and provides a user-friendly interface for loading, error, and empty states.
//
class CustomNewTile extends StatefulWidget {
  const CustomNewTile({
    super.key,
    required this.category,
  });

  final String category;

  @override
  State<CustomNewTile> createState() => _CustomNewTileState();
}

class _CustomNewTileState extends State<CustomNewTile> {
  late Future<List<NewsModel>> newsFuture;

  List<NewsModel>? cachedNews;

  @override
  void initState() {
    super.initState();
    _loadNews();
  }

  @override
  void dispose() {
    // Cancel any ongoing operations if needed
    super.dispose();
  }

  Future<void> _loadNews() async {
    final currentFuture =
        NewsServices(Dio()).getNews(category: widget.category);
    if (mounted) {
      setState(() {
        newsFuture = currentFuture;
      });
    }

    try {
      final news = await currentFuture;
      //mounted check to prevent setState after widget is disposed
      if (mounted) {
        // Dismiss any previous error SnackBars when data loads successfully
        ScaffoldMessenger.of(context).clearSnackBars();

        setState(() {
          cachedNews = news;
        });
      }
      // No need to call setState here since the FutureBuilder will react to the completion of the future.
    } catch (e) {
      final errorMsg = e.toString();

      // Check if it's a network/internet error
      final isNetworkError = errorMsg.contains('No internet connection') ||
          errorMsg.contains('Failed host lookup') ||
          errorMsg.contains('Connection refused') ||
          errorMsg.contains('Connection errored');

      // Show a SnackBar notification for network errors
      if (mounted && isNetworkError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
                'No internet connection. Please check your network.'),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 4),
            action: SnackBarAction(
              label: 'Retry',
              textColor: Colors.white,
              onPressed: _onRefresh,
            ),
          ),
        );
      }

      // Let the FutureBuilder handle the error state - don't rethrow
      // This prevents the app from crashing and allows the error UI to display
    }
  }

  // This method is called when the user taps the refresh button in the error state.
  // It reloads the news data.
  //_loadNews is private and can be called from both initState and the refresh button, ensuring that the news data is fetched when the widget is first created and can be refreshed on demand.
  Future<void> _onRefresh() async {
    await _loadNews();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<NewsModel>>(
      future: newsFuture,
      //snapshot contains the state of the future, including loading, error, and data states. The builder function uses this snapshot to determine what to display in the UI.
      builder: (context, snapshot) {
        // Loading state
        if (snapshot.connectionState == ConnectionState.waiting &&
            cachedNews == null) {
          return const SliverToBoxAdapter(
            child: SizedBox(
              height: 300,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Loading news...'),
                  ],
                ),
              ),
            ),
          );
        }

        // Error state
        if (snapshot.hasError && cachedNews == null) {
          final errorMessage = snapshot.error.toString();
          final isNoInternet =
              errorMessage.contains('No internet connection') ||
                  errorMessage.contains('Failed host lookup') ||
                  errorMessage.contains('Connection refused') ||
                  errorMessage.contains('Connection errored');

          return SliverToBoxAdapter(
            child: SizedBox(
              height: 400,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Icon
                    Icon(
                      isNoInternet ? Icons.wifi_off : Icons.error_outline,
                      size: 64,
                      color: isNoInternet ? Colors.orange : Colors.red,
                    ),
                    const SizedBox(height: 24),
                    // Title
                    Text(
                      isNoInternet
                          ? 'No Internet Connection'
                          : 'Error Loading News',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    // Description
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text(
                        isNoInternet
                            ? 'Please check your internet connection and try again.'
                            : errorMessage.replaceAll('Exception: ', ''),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Retry Button
                    ElevatedButton.icon(
                      onPressed: _onRefresh,
                      icon: const Icon(Icons.refresh),
                      label: const Text('Retry'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 32,
                          vertical: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }

        // Empty state
        if ((snapshot.data == null || snapshot.data!.isEmpty) &&
            cachedNews == null) {
          return const SliverToBoxAdapter(
            child: SizedBox(
              height: 200,
              child: Center(
                child: Text('No news available'),
              ),
            ),
          );
        }
        // Use cached news if available, otherwise use the snapshot data
        final newsList = snapshot.data ?? cachedNews ?? [];

        if (newsList.isEmpty) {
          return const SliverToBoxAdapter(
            child: SizedBox(
              height: 200,
              child: Center(
                child: Text('No news available'),
              ),
            ),
          );
        }

        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) => NewTile(news: newsList[index]),
            childCount: newsList.length,
          ),
        );
      },
    );
  }
}
