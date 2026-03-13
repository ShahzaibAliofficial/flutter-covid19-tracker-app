import 'package:covid_19_app/Model/WorldStatesModel.dart';
import 'package:covid_19_app/Services/Utilities/states_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'countries_list.dart';
import 'countries_list.dart';
class HomeScreen  extends StatefulWidget{
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this)..repeat();
  final Map<String,double>dataMap = {
    'Total': 30,
    'Recovered': 8,
    'Deaths': 3,
  };

  final List<Color>ColorList =[
    Color(0xff1aa260),
    Color(0xff4285F4),
    Color(0xffde5246),
    Color(0xfffbbc05),
    Color(0xff34a853),
    Color(0xffff6d01),
    Color(0xff8e44ad),
  ];

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text("World's Covid Stats",style: TextStyle(
            fontSize: 25
          ),
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
          ),
          Expanded(
            child: FutureBuilder(
                future: statesServices.fetchWorldStateRecords(),
                builder: (context, AsyncSnapshot<WorldStatesModel> snapshot ){
                  if(snapshot.hasError){
                    return Text(snapshot.error.toString());
                  }
                if(!snapshot.hasData){
                    return Center(
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          size: 50.0,
                          controller: _controller,
                        ));
                }else{
                  return Column(
                    children: [
                      PieChart(
                        dataMap: {
                          "Total": double.parse(snapshot.data!.cases!.toString()),
                          "Deaths": double.parse(snapshot.data!.deaths!.toString()),
                          "Recovered": double.parse(snapshot.data!.recovered!.toString()),
                          "Alive": double.parse(snapshot.data!.active!.toString()),      
                          "Critical": double.parse(snapshot.data!.critical!.toString()),
                          "Today Deaths": double.parse(snapshot.data!.todayDeaths!.toString()),
                          "Today Recovered": double.parse(snapshot.data!.todayRecovered!.toString()),

                  },
                        animationDuration: Duration(milliseconds: 1200),
                        chartRadius: MediaQuery.of(context).size.width / 2.2,
                        colorList: ColorList,
                        chartType: ChartType.ring,
                        legendOptions: LegendOptions(
                            legendPosition: LegendPosition.left,
                            legendTextStyle: TextStyle(color: Colors.white)
                        ),
                        chartValuesOptions: ChartValuesOptions(
                          showChartValuesInPercentage: true,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Card(
                        color: Colors.grey[900],
                        margin: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            buildRow("Total", snapshot.data!.cases.toString()),
                            Divider(color: Colors.grey.shade700,),
                            buildRow("Recovered", snapshot.data!.recovered.toString()),
                            Divider(color: Colors.grey.shade700,),
                            buildRow("Deaths", snapshot.data!.deaths.toString()),
                            Divider(color: Colors.grey.shade700,),
                            buildRow("Alive", snapshot.data!.active!.toString()),
                            Divider(color: Colors.grey.shade700,),
                            buildRow("Critical", snapshot.data!.critical!.toString()),
                            Divider(color: Colors.grey.shade700,),
                            buildRow("Today Deaths", snapshot.data!.todayDeaths!.toString()),
                            Divider(color: Colors.grey.shade700,),
                            buildRow("Today Recovered", snapshot.data!.todayRecovered!.toString()),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green.shade900,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)
                                  )
                              ),
                              onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => CountriesListScreen()));
                              }, child: Text('Track Countries',style: TextStyle(
                              color: Colors.white,
                              fontSize: 17
                          ),)),
                        ),
                      )
                    ],
                  );
                }
            }),
          ),

        ],
      ),
    );
  }
}


Widget buildRow(String title, String value){
  return Padding(
      padding:const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold
          ),
        )
      ],
    ),
  );
}