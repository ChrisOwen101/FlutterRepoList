import 'package:ChrisRepoList/model/git_read_me.dart';
import 'package:ChrisRepoList/model/git_repo.dart';

abstract class Repository {
  Future<List<GitRepo>> getGitRepo(String username);
  Future<String> getReadMeInfo(String username, String repo);
}