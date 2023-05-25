import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CalendarioPage extends StatefulWidget {
  @override
  _CalendarioPageState createState() => _CalendarioPageState();
}

class _CalendarioPageState extends State<CalendarioPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  Map<DateTime, List<dynamic>> _events = {};
  TextEditingController _eventController = TextEditingController();

  @override
  void dispose() {
    _eventController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
    });
  }

  void guardarEvento(DateTime fecha, String evento) {
    FirebaseFirestore.instance
        .collection('eventos')
        .add({
      'fecha': fecha,
      'evento': evento,
    })
        .then((value) => print('Evento guardado correctamente'))
        .catchError((error) => print('Error al guardar el evento: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendario'),
      ),
      body: Column(
        children: [
          TableCalendar(
            calendarFormat: _calendarFormat,
            focusedDay: _focusedDay,
            firstDay: DateTime.utc(2022, 1, 1),
            lastDay: DateTime.utc(2022, 12, 31),
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
            ),
            onDaySelected: _onDaySelected,
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: _eventController,
              decoration: InputDecoration(
                labelText: 'Evento',
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    guardarEvento(_selectedDay, _eventController.text);
                    _eventController.clear();
                    setState(() {});
                  },
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('eventos').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }

                List<Widget> eventWidgets = [];
                final eventos = snapshot.data!.docs;
                for (var evento in eventos) {
                  final fecha = evento['fecha'].toDate();
                  final descripcion = evento['evento'];

                  if (_events.containsKey(fecha)) {
                    _events[fecha]!.add(descripcion);
                  } else {
                    _events[fecha] = [descripcion];
                  }
                }

                _events.forEach((key, value) {
                  eventWidgets.add(Column(
                    children: [
                      Text(key.toString()),
                      SizedBox(height: 8),
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: value.length,
                        itemBuilder: (context, index) {
                          return Text(value[index]);
                        },
                      ),
                      SizedBox(height: 20),
                    ],
                  ));
                });

                return ListView(children: eventWidgets);
              },
            ),
          ),
        ],
      ),
    );
  }
}
