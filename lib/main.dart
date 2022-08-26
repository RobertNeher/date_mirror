import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'graphics.dart';

void main() {
  runApp(const MirrorDate());
}

class MirrorDate extends StatefulWidget {
  const MirrorDate({super.key});

  @override
  State<MirrorDate> createState() => _MirrorDateState();
}

class _MirrorDateState extends State<MirrorDate> {
  late Map<String, DateTime> _mirrorDates;

  @override
  void initState() {
    String year = DateTime.now().year.toString();
    _mirrorDates = {
      'New Year': DateTime.parse('$year-01-01'),
      'Spring Equinox': DateTime.parse('$year-03-20'),
      'Summer Solstice': DateTime.parse('$year-06-21'),
      'Fall Equinox': DateTime.parse('$year-09-20'),
      'Winter Solstice': DateTime.parse('$year-12-20'),
      'Year\'s End': DateTime.parse('$year-12-31'),
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mirror Dates ${DateTime.now().year}',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MirrorDatePage(
          title: 'Mirror Dates of year ${DateTime.now().year}',
          mirrorDates: _mirrorDates),
    );
  }
}

class MirrorDatePage extends StatefulWidget {
  const MirrorDatePage(
      {super.key, required this.title, required this.mirrorDates});
  final String title;
  final Map<String, DateTime> mirrorDates;

  @override
  State<MirrorDatePage> createState() => _MirrorDatePageState();
}

class _MirrorDatePageState extends State<MirrorDatePage> {
  final DateFormat _df = DateFormat('dd.MM.yyyy');
  List<DropdownMenuItem> _items = [];
  String _selectedEvent = "";
  final TextEditingController _tec = TextEditingController();

  @override
  void initState() {
    _items = [];

    for (var element in widget.mirrorDates.keys) {
      _items.add(DropdownMenuItem(
        value: element,
        child: Text(element),
      ));
    }
    _selectedEvent = widget.mirrorDates.keys.first;
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          DropdownButton(
              items: _items,
              value: _selectedEvent,
              onChanged: (value) {
                _selectedEvent = value!;
                _tec.text = _df.format(widget.mirrorDates[_selectedEvent]!);
                setState(() {});
              }),
          const SizedBox(
            height: 20,
          ),
          TextField(
            textAlign: TextAlign.left,
            controller: _tec,
            // readOnly: true,
          ),
          const SizedBox(
            height: 20,
          ),
          CustomPaint(
            size: const Size(350, 50),
            painter: DateLinePainter(
                eventLabel:
                    "$_selectedEvent\n${_df.format(widget.mirrorDates[_selectedEvent]!)}",
                mirrorLabel:
                    "Mirror Date\n${_mirrorDateLabel(widget.mirrorDates[_selectedEvent]!, _df)}",
                dayDiff: widget.mirrorDates[_selectedEvent]!
                    .difference(DateTime.now())
                    .inDays),
          )
        ],
      ),
    );
  }
}

String _mirrorDateLabel(DateTime baseDate, DateFormat df) {
  int diff = baseDate.difference(DateTime.now()).inDays;
  return df.format(DateTime.now().add(Duration(days: diff)));
}
