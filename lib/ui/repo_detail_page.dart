import 'package:ChrisRepoList/data/CacheRepository.dart';
import 'package:ChrisRepoList/data/MemCache.dart';
import 'package:ChrisRepoList/model/git_read_me.dart';
import 'package:ChrisRepoList/ui/CircleImage.dart';
import 'package:flutter/material.dart';

import 'package:ChrisRepoList/model/git_repo.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class GitRepoDetailPage extends StatefulWidget {
  final GitRepo repo;

  GitRepoDetailPage(this.repo);

  @override
  _GitRepoDetailPageState createState() => _GitRepoDetailPageState();
}

class _GitRepoDetailPageState extends State<GitRepoDetailPage> {
  Widget get gitRepoDetails {
    return Container(child: Icon(Octicons.getIconData("star")));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          backgroundColor: Colors.black87,
          title: Text(widget.repo.name),
        ),
        body: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircleImage(widget.repo.avatarUrl),
            Text(widget.repo.name, style: Theme.of(context).textTheme.headline),
            Text(widget.repo.desc ?? "No Description",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.caption),
            Flexible(
                child: FutureBuilder<String>(
              future: CacheRepository(MemCache())
                  .getReadMeInfo(widget.repo.owner, widget.repo.name),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Markdown(data: snapshot.data);
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                // By default, show a loading spinner
                return CircularProgressIndicator();
              },
            ))
          ],
        )));
  }
}
