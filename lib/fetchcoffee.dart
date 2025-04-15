import 'dart:convert';

import 'package:coffeeapp/coffeemodal.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Fetchcoffee extends StatefulWidget {
  const Fetchcoffee({super.key});

  @override
  State<Fetchcoffee> createState() => _FetchcoffeeState();
}

class _FetchcoffeeState extends State<Fetchcoffee> {
  Future<List<coffeemodal>> fetchingcoffeeData() async {
    const url = 'https://decayapp.github.io/coffeelist/coffee.json';
    final response = await http.get(Uri.parse(url));
    /* words = 'checkinng  bbutton'; */

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((coffee) => coffeemodal.fromJson(coffee))
          .toList();
    } else {
      throw Exception();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: const Text('Coffee Info'),
        centerTitle: true,
        backgroundColor: Colors.brown,
      ),
      body: FutureBuilder<List<coffeemodal>>(
        future: fetchingcoffeeData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var coffee = snapshot.data![index];
                return ListTile(
                  title: Text(coffee.name ?? 'No Name'),
                  subtitle: Text(coffee.description ?? 'No Description'),
                  trailing: Text(coffee.brewingMethod ?? 'No Ingredients'),
                );
              },
            );
          }
        },
      ),
    ));
  }
}
