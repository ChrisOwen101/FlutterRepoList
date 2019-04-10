import 'package:ChrisRepoList/model/git_read_me.dart';
import 'package:ChrisRepoList/model/git_repo.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';

class Api {
  final String BASE_URL = "https://api.github.com";
  final String USER = "/users";
  final String REPOS = "/repos";
  final String README = "/readme";

  Future<List<GitRepo>> fetchRepo(String username) async {
    final response = await http.get("$BASE_URL$USER/$username$REPOS");
    List responseJson = json.decode(response.body);

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON
      return responseJson.map((m) => new GitRepo.fromJson(m)).toList();
    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }

  Future<String> fetchReadMe(String username, String repo) async {
    final response = await http.get("$BASE_URL$REPOS/$username/$repo$README");

    if (response.statusCode == 200) {
      var readMe = ReadMe.fromJson(json.decode(response.body));
      final responseReadMe = await http.get(readMe.downloadUrl);

      if (responseReadMe.statusCode == 200) {
        return responseReadMe.body;
      } else {
        return Future.value("No ReadMe found for this Repo");
      }
    } else {
      return Future.value("No ReadMe found for this Repo");
    }
  }
}
