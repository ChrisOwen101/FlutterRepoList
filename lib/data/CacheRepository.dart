import 'dart:async';
import 'dart:collection';

import 'package:ChrisRepoList/data/Api.dart';
import 'package:ChrisRepoList/data/Cache.dart';
import 'package:ChrisRepoList/data/Repository.dart';
import 'package:ChrisRepoList/model/git_read_me.dart';
import 'package:ChrisRepoList/model/git_repo.dart';

class CacheRepository extends Repository {
  final Cache<List<GitRepo>> cache;
  final Api api = Api();

  final completers = HashMap<String, Set<Completer>>();

  CacheRepository(this.cache);

  @override
  Future<List<GitRepo>> getGitRepo(String username) {
    if (cache.contains(username)) {
      return cache.get(username);
    } else {
      var future = api.fetchRepo(username);
      future.asStream().listen((List<GitRepo> repos) {
        cache.put(username, repos);
        Set<Completer> comps = completers[username];

        if (comps != null) {
          for (var completer in comps) {
            completer.complete(repos);
          }
          comps.clear();
        }
      });

      return buildFuture(username);
    }
  }

  @override
  Future<String> getReadMeInfo(String username, String repo) {
    return api.fetchReadMe(username, repo);
  }

  Future<List<GitRepo>> buildFuture(String index) {
    var completer = Completer<List<GitRepo>>();

    if (completers[index] == null) {
      completers[index] = Set<Completer>();
    }
    completers[index].add(completer);

    return completer.future;
  }
}
