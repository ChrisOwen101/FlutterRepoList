import 'dart:async';

import 'package:ChrisRepoList/data/CacheRepository.dart';
import 'package:ChrisRepoList/data/MemCache.dart';
import 'package:ChrisRepoList/ui/repo_list.dart';
import 'package:flutter/material.dart';
import 'package:ChrisRepoList/model/git_repo.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  CacheRepository cacheRepository = CacheRepository(MemCache());

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: "Chris's Repo List",
        home: new MyRepoPage(title: "Chris's Repo List", gitRepo: cacheRepository.getGitRepo("ChrisOwen101")),
        theme: ThemeData(
          // Define the default Brightness and Colors
          brightness: Brightness.dark,
          primaryColor: Colors.lightBlue[800],
          accentColor: Colors.cyan[600],

          // Define the default Font Family
          fontFamily: 'Montserrat',

          // Define the default TextTheme. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          textTheme: TextTheme(
            headline: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            title: TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic),
            body1: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
          ),
        ));
  }
}

class MyRepoPage extends StatelessWidget {
  MyRepoPage({Key key, this.title, this.gitRepo}) : super(key: key);

  final String title;
  final Future<List<GitRepo>> gitRepo;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.white,
        appBar: new AppBar(
          title: new Text(title),
        ),
        body: Center(child: repoList));
  }

  FutureBuilder<List<GitRepo>> get repoList {
    return FutureBuilder<List<GitRepo>>(
        future: gitRepo,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return GitRepoList(snapshot.data);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          return CircularProgressIndicator();
        });
  }
}
