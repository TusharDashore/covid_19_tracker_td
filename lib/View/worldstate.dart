// import 'package:covid_19_tracker_td/Model/WorldStateModel.dart';
// import 'package:covid_19_tracker_td/View/services/utilitis/state_services.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:pie_chart/pie_chart.dart';
// import 'package:http/http.dart' as http;
// import 'package:covid_19_tracker_td/View/countries_list.dart';

// class WorldState extends StatefulWidget {
//   const WorldState({super.key});

//   @override
//   State<WorldState> createState() => _WorldStateState();
// }

// class _WorldStateState extends State<WorldState> with TickerProviderStateMixin {
//   late final AnimationController _controller =
//   AnimationController(duration: const Duration(seconds: 3), vsync: this)
//     ..repeat();

//   @override
//   void dispose() {
//     // TODO: implement dispose
//     super.dispose();
//     _controller.dispose();
//   }

//   final ColorList = <Color>[
//     const Color(0xf906eae3),
//     const Color(0xff1aa260),
//     const Color(0xffde5246)
//   ];

//   @override
//   Widget build(BuildContext context) {
//     StatesServices statesServices = StatesServices();
//     return Scaffold(
//       body: SafeArea(
//         child: FutureBuilder(
//           future: statesServices.fetchworldStatesRecords(),
//           builder: (context, AsyncSnapshot<WorldStateModel> snapshot) {
//             if (!snapshot.hasData) {
//               // Yaha Expanded ki zarurat nahi
//               return Center(
//                 child: SpinKitFadingCircle(
//                   color: Colors.white,
//                   size: 50.0,
//                   controller: _controller,
//                 ),
//               );
//             } else {
//               return SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     SizedBox(height: MediaQuery.of(context).size.height * .08),
//                     PieChart(
//                       dataMap: {
//                         "Total": double.parse(snapshot.data!.cases.toString()),
//                         "Recovered": double.parse(snapshot.data!.recovered.toString()),
//                         "Deaths": double.parse(snapshot.data!.deaths.toString()),
//                       },
//                       chartValuesOptions: const ChartValuesOptions(
//                         showChartValues: true,
//                         showChartValuesInPercentage: true,
//                         showChartValueBackground: true,
//                       ),
//                       legendOptions: const LegendOptions(
//                         legendPosition: LegendPosition.left,
//                         legendShape: BoxShape.rectangle,
//                         legendTextStyle: TextStyle(fontWeight: FontWeight.bold),
//                       ),
//                       animationDuration: const Duration(milliseconds: 1200),
//                       chartRadius: 150,
//                       chartType: ChartType.ring,
//                       colorList: ColorList,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 15),
//                       child: Card(
//                         child: Column(
//                           children: [
//                             ReusableRow(title: 'Totle',
//                                 value: snapshot.data!.cases.toString()),
//                             ReusableRow(title: 'Recovered',
//                                 value: snapshot.data!.recovered.toString()),
//                             ReusableRow(title: 'Deaths',
//                                 value: snapshot.data!.deaths.toString()),
//                             ReusableRow(title: 'Active',
//                                 value: snapshot.data!.active.toString()),
//                             ReusableRow(title: 'Today Deaths',
//                                 value: snapshot.data!.todayDeaths.toString()),
//                             ReusableRow(title: 'Today Recovered',
//                                 value: snapshot.data!.todayRecovered
//                                     .toString()),
//                             ReusableRow(title: 'Updated',
//                                 value: snapshot.data!.updated.toString()),
//                           ],
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 20),
//                       child: GestureDetector(
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => CountriesListScreen()),
//                           );
//                         },
//                         child: Container(
//                           decoration: BoxDecoration(
//                             color: Colors.green,
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                           height: 50,
//                           child: const Center(child: Text("Tracking Covid")),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }

//   class ReusableRow extends StatefulWidget {
//   String title, value;
//   ReusableRow({super.key, required this.title, required this.value});

//   @override
//   State<ReusableRow> createState() => _ReusableRowState();
// }

// class _ReusableRowState extends State<ReusableRow> {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(widget.title),
//               Text(widget.value),
//             ],
//           ),
//           const SizedBox(
//             height: 5,
//           ),
//           const Divider(),
//         ],
//       ),
//     );
//   }
// }
import 'package:covid_19_tracker_td/Model/WorldStateModel.dart';
import 'package:covid_19_tracker_td/View/countries_list.dart';
import 'package:covid_19_tracker_td/View/services/utilitis/state_services.dart';
import 'package:covid_19_tracker_td/provider/covid_provider.dart';
// import 'package:covid_19_tracker_td/providers/covid_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldState extends ConsumerStatefulWidget {
  const WorldState({super.key});

  @override
  ConsumerState<WorldState> createState() => _WorldStateState();
}

class _WorldStateState extends ConsumerState<WorldState>
    with TickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 3), vsync: this)
        ..repeat();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246)
  ];

  @override
  Widget build(BuildContext context) {
    final worldStateAsync = ref.watch(covidProvider);

    return Scaffold(
      body: SafeArea(
        child: worldStateAsync.when(
          // ✅ LOADING UI (same spinner)
          loading: () => Center(
            child: SpinKitFadingCircle(
              color: Colors.white,
              size: 50.0,
              controller: _controller,
            ),
          ),

          // ✅ ERROR UI
          error: (err, stack) => Center(
            child: Text(
              'Error: $err',
              style: const TextStyle(color: Colors.red),
            ),
          ),

          // ✅ DATA UI (same as FutureBuilder)
          data: (WorldStateModel data) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * .08),

                  /// Pie Chart
                  PieChart(
                    dataMap: {
                      "Total": data.cases!.toDouble(),
                      "Recovered": data.recovered!.toDouble(),
                      "Deaths": data.deaths!.toDouble(),
                    },
                    chartValuesOptions: const ChartValuesOptions(
                      showChartValues: true,
                      showChartValuesInPercentage: true,
                      showChartValueBackground: true,
                    ),
                    legendOptions: const LegendOptions(
                      legendPosition: LegendPosition.left,
                      legendShape: BoxShape.rectangle,
                      legendTextStyle: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    animationDuration: const Duration(milliseconds: 1200),
                    chartRadius: 150,
                    chartType: ChartType.ring,
                    colorList: colorList,
                  ),

                  /// Data Card
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Card(
                      child: Column(
                        children: [
                          ReusableRow(
                              title: 'Total', value: data.cases.toString()),
                          ReusableRow(
                              title: 'Recovered',
                              value: data.recovered.toString()),
                          ReusableRow(
                              title: 'Deaths', value: data.deaths.toString()),
                          ReusableRow(
                              title: 'Active', value: data.active.toString()),
                          ReusableRow(
                              title: 'Today Deaths',
                              value: data.todayDeaths.toString()),
                          ReusableRow(
                              title: 'Today Recovered',
                              value: data.todayRecovered.toString()),
                          ReusableRow(
                              title: 'Updated', value: data.updated.toString()),
                        ],
                      ),
                    ),
                  ),

                  /// Navigate Button
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const CountriesListScreen()),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        height: 50,
                        child: const Center(
                          child: Text(
                            "Tracking Covid",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

/// ✅ Reusable Row Widget (same as before)
class ReusableRow extends StatelessWidget {
  final String title;
  final String value;
  const ReusableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          const SizedBox(height: 5),
          const Divider(),
        ],
      ),
    );
  }
}
