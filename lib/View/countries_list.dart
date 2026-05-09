// import 'package:covid_19_tracker_td/View/details_screen.dart';
// import 'package:covid_19_tracker_td/View/services/utilitis/state_services.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart'as http;
// import 'package:shimmer/shimmer.dart';
// class CountriesListScreen extends StatefulWidget {
//   const CountriesListScreen({super.key});

//   @override
//   State<CountriesListScreen> createState() => _CountriesListScreenState();
// }

// class _CountriesListScreenState extends State<CountriesListScreen> {
//   TextEditingController searchController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     StatesServices stateservices = StatesServices();

//     return  Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       ),
//       body: SafeArea(
//           child: Column(
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(20.0),
//                   child: TextFormField(
//                     onChanged: (value){
//                       setState(() {

//                       });
//                     },
//                     // textAlign: TextAlign.center,
//                     controller: searchController,
//                     decoration: InputDecoration(
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(50.0),
//                         ),
//                         hintText: "Search with country name"
//                     ),
//                   ),
//                 ),
//                 Expanded(

//                     child: FutureBuilder(
//                         future: stateservices.countriesListApi(),
//                         builder: (context,AsyncSnapshot<List<dynamic>>snapshot){
//                           if(!snapshot.hasData){
//                             return ListView.builder(
//                                 itemCount: 4,
//                                 itemBuilder: (context,index){
//                                   return Shimmer.fromColors( baseColor:Colors.grey.shade700, highlightColor: Colors.grey.shade700,
//                                     child: Column(
//                                       children: [
//                                         ListTile(
//                                           title: Container(height: 10,width: 89,color: Colors.white,),
//                                           subtitle: Container(height: 10,width: 89,color: Colors.white,),
//                                           leading: Container(height: 50,width: 50,color: Colors.white,),
//                                         )
//                                       ],
//                                     ) ,
//                                   );
//                                 });
//                           }else{
//                             return
//                               ListView.builder(
//                                   itemCount: snapshot.data!.length,
//                                   itemBuilder: (context,index){
//                                     String name = snapshot.data![index]['country'];

//                                     if(searchController.text.isEmpty){
//                                       return  Column(
//                                         children: [
//                                           InkWell(
//                                             onTap:(){
//                                               Navigator.push(context,MaterialPageRoute(builder: (context)=> DetailsScreen(
//                                                   name: snapshot.data![index]['country'],
//                                                   image: snapshot.data![index]['countryInfo']['flag'],
//                                                   totalcases: snapshot.data![index]['cases'],
//                                                   totalRecoverd: snapshot.data![index]['recovered'],
//                                                   active: snapshot.data![index]["active"],
//                                                   critical: snapshot.data![index]['critical'],
//                                                   test: snapshot.data![index]['tests'],
//                                                   continent:snapshot.data![index]['continent'])));
//                                       },
//                                             child: ListTile(
//                                               title: Text(snapshot.data![index]['country']),
//                                               subtitle: Text(snapshot.data![index]['cases'].toString()),
//                                               leading: Image(
//                                                 image: NetworkImage(
//                                                     snapshot.data![index]['countryInfo']['flag']
//                                                 ),
//                                                 height: 50,
//                                                 width: 50,
//                                               ),
//                                             ),
//                                           )
//                                         ],
//                                       );
//                                     }else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
//                                       return  Column(
//                                         children: [
//                                           InkWell(
//                                             onTap:(){
//                                               Navigator.push(context,MaterialPageRoute(builder: (context)=> DetailsScreen(
//                                                   name: snapshot.data![index]['country'],
//                                                   image: snapshot.data![index]['countryInfo']['flag'],
//                                                   totalcases: snapshot.data![index]['cases'],
//                                                   totalRecoverd: snapshot.data![index]['recovered'],
//                                                   active: snapshot.data![index]["active"],
//                                                   critical: snapshot.data![index]['critical'],
//                                                   test: snapshot.data![index]['tests'],
//                                                   continent:snapshot.data![index]['continent'])));
//                                       },
//                                             child: ListTile(
//                                               title: Text(snapshot.data![index]['country']),
//                                               subtitle: Text(snapshot.data![index]['cases'].toString()),
//                                               leading: Image(
//                                                 image: NetworkImage(
//                                                     snapshot.data![index]['countryInfo']['flag']
//                                                 ),
//                                                 height: 50,
//                                                 width: 50,
//                                               ),
//                                             ),
//                                           )
//                                         ],
//                                       );
//                                     }else{
//                                       return Container();
//                                     }

//                                   });
//                           }
//                         }))

//               ]
//           )
//       ),
//     );
//   }
// }

import 'package:covid_19_tracker_td/View/details_screen.dart';
import 'package:covid_19_tracker_td/provider/covid_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shimmer/shimmer.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

class CountriesListScreen extends ConsumerStatefulWidget {
  const CountriesListScreen({super.key});

  @override
  ConsumerState<CountriesListScreen> createState() =>
      _CountriesListScreenState();
}

class _CountriesListScreenState extends ConsumerState<CountriesListScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final countriesAsync =
        ref.watch(countriesProvider); // 👈 Riverpod provider use kiya

    final searchQuery = ref.watch(searchQueryProvider);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // 🔍 Search bar
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextFormField(
                onChanged: (value) {
                  // setState(() {});
                  ref.read(searchQueryProvider.notifier).state = value;
                },
                controller: searchController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  hintText: "Search with country name",
                ),
              ),
            ),
            Text('you searched:$searchQuery'),

            // 🌍 List from Riverpod AsyncValue
            Expanded(
              child: countriesAsync.when(
                // ✅ Data loaded
                data: (countriesList) {
                  return ListView.builder(
                    itemCount: countriesList.length,
                    itemBuilder: (context, index) {
                      String name = countriesList[index]['country'];

                      if (searchController.text.isEmpty ||
                          name
                              .toLowerCase()
                              .contains(searchController.text.toLowerCase())) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailsScreen(
                                      name: countriesList[index]['country'],
                                      image: countriesList[index]['countryInfo']
                                          ['flag'],
                                      totalcases: countriesList[index]['cases'],
                                      totalRecoverd: countriesList[index]
                                          ['recovered'],
                                      active: countriesList[index]['active'],
                                      critical: countriesList[index]
                                          ['critical'],
                                      test: countriesList[index]['tests'],
                                      continent: countriesList[index]
                                          ['continent'],
                                    ),
                                  ),
                                );
                              },
                              child: ListTile(
                                title: Text(name),
                                subtitle: Text(
                                  countriesList[index]['cases'].toString(),
                                ),
                                leading: Image.network(
                                  countriesList[index]['countryInfo']['flag'],
                                  height: 50,
                                  width: 50,
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  );
                },

                // ⏳ Loading state
                loading: () {
                  return ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Shimmer.fromColors(
                        baseColor: Colors.grey.shade700,
                        highlightColor: Colors.grey.shade500,
                        child: ListTile(
                          title: Container(
                            height: 10,
                            width: 100,
                            color: Colors.white,
                          ),
                          subtitle: Container(
                            height: 10,
                            width: 100,
                            color: Colors.white,
                          ),
                          leading: Container(
                            height: 50,
                            width: 50,
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  );
                },

                // ❌ Error state
                error: (error, _) {
                  return Center(
                    child: Text(
                      'Error loading countries: $error',
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
