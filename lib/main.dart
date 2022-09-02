import 'package:date_mirror/vertical_layout.dart';
import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';

import 'horizontal_layout.dart';
import 'utils.dart';

void main() {
  runApp(MirrorDate());
}

class MirrorDate extends StatefulWidget {
  MirrorDate({super.key});

  @override
  State<MirrorDate> createState() => _MirrorDateState();
}

class _MirrorDateState extends State<MirrorDate> {
  final Set<String> _layouts = <String>{"Vertical", "Horizontal"};
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
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MirrorDatePage(
          title: 'Mirror Dates of year ${DateTime.now().year}',
          mirrorDates: _mirrorDates,
          layouts: _layouts),
    );
  }
}

class MirrorDatePage extends StatefulWidget {
  const MirrorDatePage(
      {super.key,
      required this.title,
      required this.mirrorDates,
      required this.layouts});
  final String title;
  final Map<String, DateTime> mirrorDates;
  final Set<String> layouts;

  @override
  State<MirrorDatePage> createState() => _MirrorDatePageState();
}

class _MirrorDatePageState extends State<MirrorDatePage> {
  bool _vertical = true;
  List<DropdownMenuItem> _items = [];
  String _selectedEvent = "";
  String _layout = "";
  final TextEditingController _tec = TextEditingController();
  late CustomPainter _timeLine;

  @override
  void initState() {
    _items = [];

    for (String element in widget.mirrorDates.keys) {
      _items.add(DropdownMenuItem<String>(
        value: element,
        child: Text(
          element,
          style: const TextStyle(
            fontFamily: "Roboto",
            decoration: TextDecoration.none,
            color: Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.normal,
          ),
        ),
      ));
    }
    _vertical = ("Vertical" == widget.layouts.first);
    _selectedEvent = widget.mirrorDates.keys.first;
    _layout = widget.layouts.first;
    _tec.text = (widget.mirrorDates.values.first).format();
    _timeLine = VerticalTimelinePainter(
        eventLabel: widget.mirrorDates.keys.first, mirrorLabel: "", dayDiff: 0);
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    _timeLine = _vertical
        ? VerticalTimeline(_selectedEvent, widget.mirrorDates)
        : HorizontalTimeline(_selectedEvent, widget.mirrorDates);

    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(widget.title),
            centerTitle: true,
            actions: <Widget>[
              PopupMenuButton<String>(itemBuilder: (context) {
                return [
                  CheckedPopupMenuItem<String>(
                    checked: _vertical,
                    enabled: true,
                    value: widget.layouts.first,
                    child: Text(widget.layouts.first),
                  ),
                  CheckedPopupMenuItem<String>(
                    checked: !_vertical,
                    enabled: true,
                    value: widget.layouts.last,
                    child: Text(widget.layouts.last),
                  ),
                ];
              }, onSelected: (String value) {
                _vertical = !_vertical;
                setState(() {});
              })
            ]),
        body: Align(
          alignment: Alignment.topCenter,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const SizedBox(width: 20),
                    DropdownButton(
                      items: _items,
                      style: const TextStyle(
                        fontFamily: "Roboto",
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                      value: _selectedEvent,
                      onChanged: (value) {
                        _selectedEvent = value!;
                        _tec.text =
                            (widget.mirrorDates[_selectedEvent]!).format();
                        setState(() {});
                      },
                    ),
                    Expanded(
                        child: TextField(
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontFamily: "Roboto",
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                      controller: _tec,
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                      readOnly: true,
                    )),
                  ]),
              const SizedBox(
                height: 20,
              ),
              CustomPaint(
                size: Size(MediaQuery.of(context).size.width,
                    MediaQuery.of(context).size.height / 1.5),
                painter: _timeLine,
              )
            ],
          ),
        ));
  }
}

CustomPainter HorizontalTimeline(
    String selectedEvent, Map<String, DateTime> mirrorDates) {
  final int dayDiff =
      mirrorDates[selectedEvent]!.difference(DateTime.now()).inDays;

  return HorizontalTimelinePainter(
      eventLabel: '$selectedEvent\n${(mirrorDates[selectedEvent]!).format()}',
      mirrorLabel:
          'Mirror Date\n${(mirrorDates[selectedEvent]!).add(Duration(days: dayDiff)).format()}',
      dayDiff: dayDiff);
}

CustomPainter VerticalTimeline(
    String selectedEvent, Map<String, DateTime> mirrorDates) {
  final int dayDiff =
      mirrorDates[selectedEvent]!.difference(DateTime.now()).inDays;

  return VerticalTimelinePainter(
      eventLabel: '$selectedEvent\n${(mirrorDates[selectedEvent]!).format()}',
      mirrorLabel:
          'Mirror Date\n${(mirrorDates[selectedEvent]!).add(Duration(days: dayDiff)).format()}}',
      dayDiff: dayDiff);
}
