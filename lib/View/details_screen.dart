import 'package:flutter/material.dart';
class DetailsScreen extends StatefulWidget {
  String name;
  String image,continent;
  int totalcases,totalRecoverd,active,critical,test;
   DetailsScreen({
    required this.name,
    required this. image,
    required this.totalcases,
    required this.totalRecoverd,
    required this.active,
    required  this.critical,
    required this.test,
    required this.continent,
});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
   appBar: AppBar(
     title: Text( widget.name,style: TextStyle(color: Colors.lightBlue),),
     centerTitle: true,
   ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .067),
                child: Card(
                  child: Column(
                    children:[
                      SizedBox(height: MediaQuery.of(context).size.height * .06,),
                      ReusableRow(title: 'Cases', value: widget.totalcases.toString(),),
                      ReusableRow(title: 'Continent', value: widget.continent.toString(),),
                      ReusableRow(title: 'Active', value: widget.active.toString(),),
                      ReusableRow(title: 'Tests', value: widget.test.toString(),),
                      ReusableRow(title: 'Critical', value: widget.critical.toString(),),
                      ReusableRow(title: 'TotalRecovered', value: widget.totalRecoverd.toString(),),

                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          )
        ],
      ),
    );
  }
}
class ReusableRow extends StatefulWidget {
  String title, value;
  ReusableRow({super.key, required this.title, required this.value});

  @override
  State<ReusableRow> createState() => _ReusableRowState();
}

class _ReusableRowState extends State<ReusableRow> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.title),
              Text(widget.value),
            ],
          ),
          const SizedBox(
            height: 5,
          ),
          const Divider(),
        ],
      ),
    );
  }
}