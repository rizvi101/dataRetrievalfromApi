import 'dart:async';
import 'package:album/controller.dart';
import 'package:flutter/material.dart';
import 'model.dart';

void main() => runApp(MyHomePage());

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<User> _users = List<User>();
  bool isLoading = false;
  String error = '';

  Future fetchAlbum() async {
    isLoading = true;
    setState(() {});
    try {
      UsersApi usersApi = UsersApi();
      var users = await usersApi.getUsers();
      _users = users;
    } catch (e) {
      error = e.message;
    } finally {
      isLoading = false;
      setState(() {});
    }
  }

  @override
  void initState() {
    fetchAlbum();
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
            ? _buildLoader()
            : error.isNotEmpty
                ? _buildErrorWidget()
                : _buildListView(),
      ),
    );
  }

  Center _buildLoader() => Center(child: CircularProgressIndicator());

  ListView _buildListView() {
    return ListView.builder(
      itemCount: _users.length,
      itemBuilder: (context, index) {
        var user = _users[index];
        return Card(
          elevation: 4,
          child: ListTile(
            leading: CircleAvatar(
              child: Text(user.name.substring(0, 2)),
            ),
            title: Text(user.name),
            subtitle: Text(user.email),
            trailing: Text(user.username),
          ),
        );
      },
    );
  }

  Center _buildErrorWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error,
            color: Colors.red.withOpacity(0.3),
            size: 40,
          ),
          Text(
            error,
            style: TextStyle(
              fontSize: 24,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
