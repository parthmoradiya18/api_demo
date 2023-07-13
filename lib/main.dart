import 'dart:convert';
import 'package:currency_picker/currency_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(debugShowCheckedModeBanner: false, home: Home(),));
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  TextEditingController t3 = TextEditingController();
  String rate = "";
String par_amount="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("currency converter [api]"),),
      body: SingleChildScrollView(
        child: Column(children: [
          Card(margin: EdgeInsets.all(5),

            color: Colors.grey,
            child: TextField(onTap: () {
          },
            controller: t1,
            decoration: InputDecoration(hintText: "Enter amount"),),),
          Card(margin: EdgeInsets.all(5),
            color: Colors.grey,
            child: TextField(onTap: () {
            showCurrencyPicker(
              context: context,
              showFlag: true,
              showCurrencyName: true,
              showCurrencyCode: true,
              onSelect: (Currency currency) {
                t2.text = currency.code;
                print('Select currency: ${currency.name}');
              },
            );
          },
            controller: t2,
            decoration: InputDecoration(hintText: "Enter from"),),),
          Card(margin: EdgeInsets.all(5),
            color: Colors.grey,
            child: TextField(onTap: () {
            showCurrencyPicker(
              context: context,
              showFlag: true,
              showCurrencyName: true,
              showCurrencyCode: true,
              onSelect: (Currency currency) {
                t3.text = currency.code;
                print('Select currency: ${currency.name}');
              },
            );
          },
            controller: t3,
            decoration: InputDecoration(hintText: "Enter to"),),),

          ElevatedButton(onPressed: () async {
            String amount = t1.text;
            String from = t2.text;
            String to = t3.text;
            var url = Uri.parse(
                'https://parthmoradiya.000webhostapp.com/currancy.php');
            var response = await http.post(
                url, body: {'from': '$from', 'to': '$to', 'amount': '$amount'});
            print('Response status: ${response.statusCode}');
            print('Response body: ${response.body}');
            Map m = jsonDecode(response.body);
            par_amount = m['info']['quote'].toString();
              rate =m['result'].toString();
            setState(() {

            });
          }, child: Text("submit")),
          Container(
            height: 35,
              width: double.infinity,
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 1, color: Colors.black)),

              child: Text(
                "Total Amount: ${rate}",style: TextStyle(fontSize: 25, color: Colors.black),)),

          Container(
              height: 35,
              width: double.infinity,
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                  border: Border.all(width: 1, color: Colors.black)),

              child: Text(
                "Amount : ${par_amount}", style: TextStyle(fontSize: 25, color: Colors.black),)),
        ],),
      ),
    );
  }
}
