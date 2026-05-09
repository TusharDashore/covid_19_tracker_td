// // Service ko provide karne ke liye
// import 'package:covid_19_tracker_td/Model/WorldStateModel.dart';
// import 'package:covid_19_tracker_td/View/services/utilitis/state_services.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final covidServiceProvider = Provider((ref) => StatesServices());

// // World data ke liye FutureProvider
// final worldStateProvider = FutureProvider<WorldStateModel>((ref) async {
//   final service = ref.watch(covidServiceProvider);
//   return service.fetchworldStatesRecords();
// });

// // Countries list ke liye FutureProvider
// final countriesProvider = FutureProvider<List<dynamic>>((ref) async {
//   final service = ref.watch(covidServiceProvider);
//   return service.countriesListApi();
// });
import 'dart:convert';
import 'package:covid_19_tracker_td/Model/WorldStateModel.dart';
import 'package:covid_19_tracker_td/View/services/utilitis/app_url.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:http/http.dart' as http;

// StateNotifier class
// class CovidNotifier extends StateNotifier<AsyncValue<WorldStateModel>> {
//   CovidNotifier() : super(const AsyncLoading()) {
//     fetchWorldStatesRecords();
//   }

//   Future<void> fetchWorldStatesRecords() async {
//     try {
//       final response = await http.get(Uri.parse(AppUrl.worldStateApi));

//       if (response.statusCode == 200) {
//         var data = jsonDecode(response.body);
//         final worldData = WorldStateModel.fromJson(data);
//         state = AsyncData(worldData);
//       } else {
//         state = AsyncError('Failed to load data', StackTrace.current);
//       }
//     } catch (e, st) {
//       state = AsyncError(e, st);
//     }
//   }
// }

// // Provider create karo
// final covidProvider =
//     StateNotifierProvider<CovidNotifier, AsyncValue<WorldStateModel>>((ref) {
//   return CovidNotifier();
// });

class CovidNotifier extends AsyncNotifier<WorldStateModel> {
  @override
  Future<WorldStateModel> build() async {
    final response = await http.get(Uri.parse(AppUrl.worldStateApi));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return WorldStateModel.fromJson(data);
    } else {
      throw Exception('Faild to load data');
    }
  }
}

final covidProvider = AsyncNotifierProvider<CovidNotifier, WorldStateModel>(() {
  return CovidNotifier();
});

// yha dusri api ke liye riverpod hai
class CountriesNotifier extends AsyncNotifier<List<dynamic>> {
  @override
  Future<List<dynamic>> build() async {
    final response = await http.get(Uri.parse(AppUrl.countriesListApi));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data is List) return data;
      return data['countries'] ?? []; // depends on API structure
    } else {
      throw Exception('Failed to load countries');
    }
  }
}

final countriesProvider =
    AsyncNotifierProvider<CountriesNotifier, List<dynamic>>(
        () => CountriesNotifier());
