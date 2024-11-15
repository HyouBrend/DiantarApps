# Delivery and Route Optimization App - Flutter Frontend

A comprehensive Flutter application for managing delivery orders, optimizing routes, and real-time tracking using Google Maps integration. This application seamlessly connects with a Flask backend API to provide a robust delivery management solution.

![Flutter Version](https://img.shields.io/badge/Flutter-3.0+-blue.svg)
![Dart Version](https://img.shields.io/badge/Dart-3.0+-blue.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)

## 📱 Features

### Core Functionalities

1. **📦 Delivery Order Management**
   - Create, edit, and delete delivery orders
   - Real-time synchronization with backend
   - Advanced filtering and pagination
   - Comprehensive data validation
   - Bulk operations support

2. **🗺️ Journey Tracking**
   - Complete journey history logging
   - Detailed route visualization
   - Distance and time tracking
   - Driver path monitoring
   - Real-time location updates

3. **🌍 Google Maps Integration**
   - Interactive route visualization
   - Optimized path calculation
   - Custom markers and InfoWindows
   - Real-time distance calculation
   - Geolocation services

4. **🔍 Smart Search & Selection**
   - Type-ahead search functionality
   - Dynamic dropdown menus
   - Customer/Driver selection
   - Location autocomplete
   - Search history

5. **📊 State Management**
   - Bloc pattern implementation
   - Efficient state handling
   - Organized data flow
   - Error handling
   - Loading states

6. **🌐 Localization & UI**
   - Multi-language support
   - Responsive design
   - Custom theme implementation
   - Dark/Light mode
   - Accessibility features

## 🏗️ Project Architecture

### Directory Structure
```
├── android/                          # Android specific files
├── assets/                           # Asset files
│   └── config/
│       ├── config.json
│       ├── aef.jpeg
│       ├── alan.jpeg
│       ├── arwin.jpeg
│       ├── cahyono.jpeg
│       ├── diantarin_load.png
│       ├── doni.jpeg
│       ├── eko.jpeg
│       ├── hanafi.jpeg
│       ├── nandar.jpeg
│       ├── roni.jpeg
│       ├── toro.jpeg
│       └── udin.jpeg
├── ios/                              # iOS specific files
├── lib/                              # Main source code
│   ├── bloc/                         # Bloc state management
│   │   ├── delivery_order_bloc/
│   │   │   ├── edit_delivery_order_bloc/
│   │   │   │   ├── edit_delivery_order_bloc.dart
│   │   │   │   ├── edit_delivery_order_event.dart
│   │   │   │   └── edit_delivery_order_state.dart
│   │   │   ├── get_delivery_order_bloc.dart
│   │   │   └── product_bloc/
│   │   ├── detail_perjalanan_bloc/
│   │   │   ├── detail_perjalanan/
│   │   │   ├── update_detail_pengantaran/
│   │   │   └── update_detail_perjalanan/
│   │   ├── history_perjalanan_bloc/
│   │   └── search_dropdown_bloc/
│   │       ├── dropdown_customer_bloc/
│   │       ├── dropdown_driver_bloc/
│   │       └── submit_perjalanan/
│   ├── data/                         # Data layer
│   │   ├── models/                   # Data models
│   │   │   ├── delivery_order_model/
│   │   │   │   ├── add_delivery_order_model.dart
│   │   │   │   ├── edit_detail_delivery_order.dart
│   │   │   │   ├── get_delivery_order_model.dart
│   │   │   │   └── produk_model.dart
│   │   │   ├── detail_perjalanan_model/
│   │   │   ├── history_perjalanan_model/
│   │   │   ├── search_dropdown_model/
│   │   │   └── submit_perjalanan_model/
│   │   └── service/                  # API services
│   │       ├── delivery_order_service/
│   │       ├── detail_perjalanan_service/
│   │       ├── history_perjalanan_service/
│   │       ├── search_dropdown_service/
│   │       └── submit_perjalanan_service/
│   ├── helpers/                      # Helper functions
│   │   ├── api/
│   │   │   └── api_strings.dart
│   │   └── network/
│   │       ├── api_helper.dart
│   │       └── api_helper_dio.dart
│   ├── pages/                        # UI pages
│   │   ├── delivery_order/
│   │   │   ├── delivery_order_widget/
│   │   │   │   ├── dropdown_widget/
│   │   │   │   ├── add_delivery_order_widget.dart
│   │   │   │   ├── card_delivery_order.dart
│   │   │   │   ├── delivery_order_pagination.dart
│   │   │   │   └── get_delivery_order_widget.dart
│   │   │   └── delivery_order_page.dart
│   │   ├── detail_delivery_order_page/
│   │   ├── detail_perjalanan/
│   │   ├── history_perjalanan/
│   │   │   └── history_perjalanan_widget/
│   │   │       ├── card_history.dart
│   │   │       ├── filter_history.dart
│   │   │       └── paging_history.dart
│   │   └── search_dropdown/
│   │       └── search_dropdown_widget/
│   │           ├── cek_google_widget/
│   │           ├── dropdown_widget/
│   │           └── search_footer_widget/
│   ├── theme/                        # Theme configuration
│   │   └── theme.dart
│   ├── util/                         # Utility functions
│   │   ├── capitalize_word.dart
│   │   ├── datetimepicker.dart
│   │   ├── format_date.dart
│   │   ├── size.dart
│   │   └── splash_screen.dart
│   └── main.dart                     # Entry point
├── linux/                            # Linux specific files
├── macos/                            # macOS specific files
├── test/                             # Test files
├── web/                              # Web specific files
├── windows/                          # Windows specific files
├── .gitignore
├── .metadata
├── README.md
├── analysis_options.yaml
├── pubspec.lock
└── pubspec.yaml
```


## 🚀 Installation

### Prerequisites
- Flutter SDK (3.0+)
- Dart SDK (3.0+)
- IDE (VS Code/Android Studio)
- Google Maps API Key

### Setup Steps

1. **Clone Repository**
   ```bash
   git clone https://github.com/yourusername/delivery-route-app.git
   cd delivery-route-app
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Environment**
   Create a `.env` file in the root directory:
   ```env
   API_BASE_URL=http://your-backend-url:5100
   ```


## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_localizations: 
    sdk: flutter
  
  # State Management
  flutter_bloc: ^7.3.0
  equatable: ^2.0.2
  
  # Networking
  dio: ^5.1.1
  
  # UI Components
  flutter_typeahead: ^4.3.0
  dropdown_search: ^5.0.2
  material_symbols_icons: ^4.2789.0
  
  # Maps & Location
  google_maps_flutter: ^2.7.0
  geolocator: ^9.0.0
  geolocator_web: ^2.0.5
  
  # Utilities
  intl: ^0.19.0
  rxdart: ^0.27.3
  url_launcher: ^6.0.20
```

## 💻 Code Examples

### API Service Implementation
```dart
import 'package:diantar_jarak/helpers/network/api_helper.dart';
import 'package:diantar_jarak/helpers/api/api_strings.dart';

class SubmitPerjalananService {
  final ApiHelper apiHelper;

  SubmitPerjalananService({required this.apiHelper});

  Future submitPengantaran(SubmitPerjalananModel submitPengantaranModel) async {
    final response = await apiHelper.post(
      url: APIJarakLocal.submitPengantaran,
      body: submitPengantaranModel.toJson(),
    );
    return response.data['message'];
  }
}

```

### Bloc Implementation
```dart
import 'package:bloc/bloc.dart';
import 'package:diantar_jarak/bloc/search_dropdown_bloc/submit_perjalanan/submit_perjalanan_event.dart';
import 'package:diantar_jarak/bloc/search_dropdown_bloc/submit_perjalanan/submit_perjalanan_state.dart';
import 'package:diantar_jarak/data/service/submit_perjalanan_service/submit_perjalanan_service.dart';

class SubmitPerjalananBloc extends Bloc<SubmitPerjalananEvent, SubmitPerjalananState> {
  final SubmitPerjalananService submitPerjalananService;

  SubmitPerjalananBloc({required this.submitPerjalananService}) : super(SubmitPerjalananInitial());

  @override
  Stream<SubmitPerjalananState> mapEventToState(SubmitPerjalananEvent event) async* {
    if (event is SubmitPerjalanan) {
      yield PerjalananSubmitting();
      try {
        await submitPerjalananService.submitPengantaran(event.submitPerjalananModel);
        yield PerjalananSubmitted(detailPerjalanan: event.submitPerjalananModel);
      } catch (e) {
        yield SubmitPerjalananError(message: e.toString());
      }
    }
  }
}

```

## 🚀 Deployment

### Web Deployment
```bash
# Build for web
flutter build web --release --dart-define=API_BASE_URL=your-api-url

# Serve locally to test
python -m http.server 8000 --directory build/web
```

### Mobile Deployment
```bash
# Android Release Build
flutter build apk --release --dart-define=API_BASE_URL=your-api-url

# iOS Release Build
flutter build ios --release --dart-define=API_BASE_URL=your-api-url
```

## 🔍 Troubleshooting

### Common Issues

1. **Map Loading Issues**
   ```
   Solution:
   - Verify Google Maps API key
   - Enable required Google Maps APIs
   - Check browser console for errors
   ```

2. **API Connection Failures**
   ```
   Solution:
   - Verify API base URL configuration
   - Check CORS settings on backend
   - Validate network connectivity
   ```

3. **State Management Issues**
   ```
   Solution:
   - Check Bloc event emission order
   - Verify state transitions
   - Debug using Bloc observer
   ```

## 🤝 Contributing

1. Fork repository
2. Create feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Open Pull Request

## 📜 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter Team for the framework
- Google Maps Platform for mapping services
- Contributors and maintainers
- Open source community

---

📫 For support, please create an issue in the repository or contact the development team.
