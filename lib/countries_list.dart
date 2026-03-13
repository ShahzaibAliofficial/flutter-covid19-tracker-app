import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'package:covid_19_app/Services/Utilities/states_services.dart';
import 'details_screen.dart';

class CountriesListScreen extends StatefulWidget{
  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {
  TextEditingController searchController = TextEditingController();

  StatesServices statesServices = StatesServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  controller: searchController,
                   onChanged: (value){
                    setState(() {

                    });
                   },
                   decoration: InputDecoration(
                     hintText: "Search with countries name...",
                     hintStyle: TextStyle(color: Colors.grey),
                     border: OutlineInputBorder(
                       borderRadius: BorderRadius.circular(30),
                     ),
                   ),
                ),
              ),
              Expanded(child: FutureBuilder(future: statesServices.countriesListApi(),
                  builder: (context,AsyncSnapshot<List<dynamic>> snapshot){
                if(!snapshot.hasData){
                  return Text('Loading');
                }else{
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index){
                        String name = snapshot.data![index]['country'];

                        if(searchController.text.isEmpty){
                          return Column(
                            children: [
                              InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(
                                    image: snapshot.data![index]['countryInfo']['flag'],
                                    name: snapshot.data![index]['country']?? "",
                                    totalCases: snapshot.data![index]['cases']?? 0,
                                    totalDeaths: snapshot.data![index]['deaths']?? 0,
                                    totalRecovered: snapshot.data![index]['recovered']?? 0,
                                    active: snapshot.data![index]['active']?? 0,
                                    critical: snapshot.data![index]['critical']?? 0,
                                    todayRecovered: snapshot.data![index]['todayRecovered']?? 0,
                                    test: snapshot.data![index]['tests']?? 0,
                                  )));
                                },
                                child: ListTile(
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(snapshot.data![index]['cases'].toString()),
                                  leading: Image(
                                      height: 50,
                                      width: 50,
                                      image: NetworkImage(snapshot.data![index]['countryInfo']['flag'])),
                                ),
                              )
                            ],
                          );
                        }else if(name.toLowerCase().contains(searchController.text.toLowerCase())){
                          return Column(
                            children: [
                              InkWell(
                                onTap:(){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen(
                                  image: snapshot.data![index]['countryInfo']['flag'],
                                  name: snapshot.data![index]['country']?? "",
                                  totalCases: snapshot.data![index]['cases']?? 0,
                                  totalDeaths: snapshot.data![index]['deaths']?? 0,
                                  totalRecovered: snapshot.data![index]['recovered']?? 0,
                                  active: snapshot.data![index]['active']?? 0,
                                  critical: snapshot.data![index]['critical']?? 0,
                                  todayRecovered: snapshot.data![index]['todayRecovered']?? 0,
                                  test: snapshot.data![index]['tests']?? 0,
                                    )));
                                },
                                child: ListTile(
                                  title: Text(snapshot.data![index]['country']),
                                  subtitle: Text(snapshot.data![index]['cases'].toString()),
                                  leading: Image(
                                      height: 50,
                                      width: 50,
                                      image: NetworkImage(snapshot.data![index]['countryInfo']['flag'])),
                                ),
                              )
                            ],
                          );
                        }
                        else{
                        return Container();
                        }
                      }
                      );
                }
                  }))
            ],
          )),
    );
  }
}