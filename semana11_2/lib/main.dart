import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'myContactDetail.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyContractList(),
    );
  }
}

class MyContractList extends StatefulWidget {
  const MyContractList({Key? key}) : super(key: key);

  @override
  State<MyContractList> createState() => _MyContactListState();
}



class _MyContactListState extends State<MyContractList> {
  String url = "https://randomuser.me/api/?results=30";
  List? data;
  Future<String> makeRequest() async{
    var response = await http.get(Uri.parse(url),
        headers: {'Accept': 'aplication/json'});
    setState(() {
      var extractdata = json.decode(response.body);
      data = extractdata['results'];
    });

    print('Nombre: '+ data?[0]['name']['first']);

    print('e-mail: '+ data?[0]['email']);
    //print(response.body);
    return response.body;
  }
  @override
  void initState(){
    this.makeRequest();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text("*** My contact list ***"),
        ),
        body: ListView.builder(
            itemCount: data == null ? 0 : data?.length,
            itemBuilder: (BuildContext context, i){
              return ListTile(
                title: Text(data?[i]['name']['first']),
                subtitle: Text(data?[i]['phone']),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(data?[i]['picture']['thumbnail']),
                ),
                 onTap: (){
                  Navigator.push(
                      context, MaterialPageRoute(
                      builder: (BuildContext context)=>
                          MyContactDetail((data?[i]))
                  ));
                 },
              );
            })
    );
  }
}
