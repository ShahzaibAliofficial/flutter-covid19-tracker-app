import 'package:covid_19_app/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:covid_19_app/Services/Utilities/states_services.dart';


class DetailsScreen extends StatefulWidget{
  String image;
  String name;
  int totalCases, totalDeaths, totalRecovered, active, critical, todayRecovered, test;

  DetailsScreen({
  required this.image,
  required this.name,
  required this.totalCases,
  required this.totalDeaths,
  required this.todayRecovered,
  required this.active,
  required this.critical,
  required this.totalRecovered,
  required this.test});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}
class _DetailsScreenState extends State<DetailsScreen>{
  @override
  Widget build(BuildContext context){
    return Scaffold(
    appBar: AppBar(
      title: Text(widget.name,style: TextStyle(fontSize: 25),),
      centerTitle: true,
    ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(top: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * .087),
                    child: Card(
                      child: Column(
                        children: [

                          buildRow('Cases', widget.totalCases.toString()),
                          Divider(color: Colors.grey.shade700,),
                          buildRow('Recovered', widget.totalRecovered.toString()),
                          Divider(color: Colors.grey.shade700,),
                          buildRow('Deaths', widget.totalDeaths.toString()),
                          Divider(color: Colors.grey.shade700,),
                          buildRow('Active', widget.active.toString()),
                          Divider(color: Colors.grey.shade700,),
                          buildRow('Critical', widget.critical.toString()),
                          Divider(color: Colors.grey.shade700,),
                          buildRow('Today Deaths', widget.totalDeaths.toString()),
                          Divider(color: Colors.grey.shade700,),
                          buildRow('Today Recovered', widget.todayRecovered.toString()),
                        ],
                      ),
                    ),
                  ),
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(widget.image),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}