# 📰 Flutter News App

A beautiful and robust Flutter news application that fetches real-time news from NewsAPI.org with comprehensive offline support and error handling.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Android](https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white)
![iOS](https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=ios&logoColor=white)

## ✨ Features

- 🏷️ **Categorized News**: Browse news by categories (Business, Sports, Technology, Entertainment, Health, Science)
- 📱 **Responsive Design**: Optimized for both mobile and tablet devices
- 🌐 **Real-time Updates**: Fetches latest news from NewsAPI
- 🚫 **Offline Support**: Comprehensive error handling for network issues
- 🔄 **Retry Functionality**: Easy retry when connection is restored
- 🎨 **Modern UI**: Material Design 3 with smooth animations
- 🖼️ **Image Loading**: Smart image loading with error handling and shimmer effects
- 📄 **Clean Architecture**: Well-structured code with separation of concerns

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (latest version recommended)
- Android Studio / VS Code with Flutter extensions
- Android/iOS device or emulator

### Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/HussienAboSoker/news.git
   cd news
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Set up API Key:**
   - Get a free API key from [NewsAPI.org](https://newsapi.org/)
   - Replace the API key in `lib/services/news_services.dart`:
     ```dart
     static const String _apiKey = 'YOUR_API_KEY_HERE';
     ```

4. **Run the app:**
   ```bash
   flutter run
   ```

## 🏗️ Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/
│   ├── news_model.dart       # News data model
│   └── catigory_model.dart   # Category data model
├── services/
│   └── news_services.dart    # News API service with error handling
├── views/
│   ├── home_view.dart        # Main home screen
│   └── catigory_view.dart    # Category-specific news view
└── widgets/
    ├── cutom_scrol_news.dart # News list with error handling
    ├── new_tile.dart         # Individual news item
    ├── catigory_card.dart    # Category selection card
    ├── catigory_listview.dart # Horizontal category list
    ├── build_image_loding.dart # Image loading widget
    └── news_shimmer.dart     # Loading shimmer effect
```

## 🛠️ Technical Implementation

### Error Handling
- **Network Detection**: Automatically detects internet connectivity issues
- **User-Friendly Messages**: Clear error messages for different scenarios
- **Retry Mechanism**: One-tap retry when connection is restored
- **Crash Prevention**: Prevents `setState()` after widget disposal

### State Management
- **FutureBuilder**: Handles async operations and loading states
- **Cached Data**: Maintains data during network issues
- **Lifecycle Management**: Proper widget disposal and cleanup

### UI/UX Features
- **Loading States**: Shimmer effects during data fetching
- **Error States**: Contextual error screens with appropriate icons
- **Empty States**: Handles no-data scenarios gracefully
- **Smooth Scrolling**: Bouncing scroll physics for better UX

## 📱 Screenshots

*[Add screenshots of your app here]*

## 🔧 API Configuration

The app uses [NewsAPI](https://newsapi.org/) for fetching news. The free tier provides:
- 100 requests per day
- Access to top headlines and everything endpoint
- Support for multiple countries and categories

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is open source and available under the [MIT License](LICENSE).

## 🙏 Acknowledgments

- [NewsAPI](https://newsapi.org/) for providing the news data
- [Flutter](https://flutter.dev/) for the amazing framework
- [Dio](https://pub.dev/packages/dio) for HTTP client functionality

## 📞 Contact

Hussien Abo Soker - [GitHub Profile](https://github.com/HussienAboSoker)

---

⭐ **Star this repo** if you found it helpful!