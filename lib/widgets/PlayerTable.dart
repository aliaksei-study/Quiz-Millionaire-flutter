import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_millionaire_flutter_test/entity/Player.dart';
import 'package:quiz_millionaire_flutter_test/service/Service.dart';

/// This is the stateful widget that the main application instantiates.
class PlayersTableWidget extends StatefulWidget {
  PlayersTableWidget({Key key}) : super(key: key);

  @override
  _PlayersTableWidgetState createState() => _PlayersTableWidgetState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _PlayersTableWidgetState extends State<PlayersTableWidget> {
  List<Player> players = [];

  fetchPlayers(BuildContext context) async {
    players = await getPlayers();
    setState(() {
      players = players;
    });
  }

  @override
  void initState() {
    Timer.run(() async {
      showSpinnerDialog(context);
      await fetchPlayers(context);
      Navigator.of(context, rootNavigator: true).pop();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(children: [
          DataTable(
            showBottomBorder: true,
            columnSpacing: 10,
            columns: <DataColumn>[
              DataColumn(
                  label: Text(
                    'Имя пользователя',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                  ),
              DataColumn(
                label: Text(
                  'Роль',
                  style: TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            ],
            rows: players
                .map((player) => DataRow(
                cells: [
                  DataCell(
                    SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Text(player.username)),
                  ),
                  DataCell(
                    SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Text(player.role)),
                  ),
                ]))
                .toList(),
          ),
        ]));
  }
}
