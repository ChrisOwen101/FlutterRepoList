import 'package:ChrisRepoList/ui/CircleImage.dart';
import 'package:flutter/material.dart';

import 'package:ChrisRepoList/model/git_repo.dart';
import 'repo_detail_page.dart';
import 'package:flutter_icons/flutter_icons.dart';

class GitRepoCard extends StatefulWidget {
  final GitRepo repo;

  GitRepoCard(this.repo);

  @override
  _GitRepoCardState createState() => _GitRepoCardState(repo);
}

class _GitRepoCardState extends State<GitRepoCard> {
  GitRepo repo;

  _GitRepoCardState(this.repo);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        height: 115.0,
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 50.0,
              child: repoCard,
            ),
            Positioned(top: 7.5, child: CircleImage(repo.avatarUrl)),
          ],
        ),
      ),
    );
  }

  showRepoDetailPage(repo) {
    Navigator.of(context).push(
      MaterialPageRoute(
        // builder methods always take context!
        builder: (context) {
          return GitRepoDetailPage(repo);
        },
      ),
    );
  }

  Widget get repoCard {
    return InkWell(
      onTap: () => showRepoDetailPage(repo),
      child: Container(
        width: 300.0,
        height: 115.0,
        child: Card(
          color: Colors.black87,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0, left: 64.0, right: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text(repo.name, style: Theme.of(context).textTheme.headline),
                Text("Made with ${repo.language}",
                    style: Theme.of(context).textTheme.subhead),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(repo.stars.toString(),
                          style: Theme.of(context).textTheme.subhead),
                      Icon(Octicons.getIconData("star"))
                    ])
              ],
            ),
          ),
        ),
      ),
    );
  }
}
