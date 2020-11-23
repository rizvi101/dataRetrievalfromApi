import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model.dart';

void main() => runApp(Api());

class Api extends StatefulWidget {
  @override
  _ApiState createState() => _ApiState();
}

class _ApiState extends State<Api> {
  List<Album> _users = List<Album>();
  bool isLoading = false;
  bool data = false;
  String error;

  Future<List<Album>> fetchAlbum() async {
    setState(() {
      isLoading = true;
    });
    try {
      var url = 'https://jsonplaceholder.typicode.com/users';
      var response = await http.get(url);
      var users = List<Album>();

      if (response.statusCode == 200) {
        var usersJson = json.decode(response.body);
        for (var userJson in usersJson) {
          users.add(Album.fromJson(userJson));
        }
      }
      setState(() {
        isLoading = false;
        _users.addAll(users);
      });
    } catch (e) {
      setState(() {
        isLoading = false;
        data = true;
        print('Exception Caught: $e');
      });
    }
  }

  @override
  void initState() {
    fetchAlbum();
    // fetchAlbum().then((value) {
    //   setState(() {
    //     _users.addAll(value);
    //   });
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Api Json Data ListView'),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : data
                ? Center(
                    child: Text('Api crashed'),
                  )
                : ListView.builder(
                    itemCount: _users.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              if (isLoading) Text('Is Loading'),
                              Text(
                                _users[index].username,
                                style: TextStyle(fontSize: 32),
                              ),
                              Text(
                                _users[index].name,
                                style: TextStyle(fontSize: 24),
                              ),
                              Text(
                                _users[index].email,
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
      ),
    );
  }
}
