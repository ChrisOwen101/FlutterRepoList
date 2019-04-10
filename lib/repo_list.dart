import 'package:flutter/material.dart';

import 'repo_card.dart';
import 'package:ChrisRepoList/model/git_repo.dart';

class GitRepoList extends StatelessWidget {
  final List<GitRepo> repos;

  GitRepoList(this.repos);

  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }

  ListView _buildList(context) {
    return ListView.builder(
      itemCount: repos.length,
      itemBuilder: (context, int) {
        return GitRepoCard(repos[int]);
      },
    );
  }
}
