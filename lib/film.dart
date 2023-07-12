// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class Film extends StatefulWidget {
  const Film({Key? key}) : super(key: key);

  @override
  _FilmState createState() => _FilmState();
}

class _FilmState extends State<Film> {
  final List<String> entries = <String>['Fast and Furious', 'Ivanna' ];
  final List<String> images = <String>[
    'assets/image/fast.png',
    'assets/image/ivanna.png',
  ];
  final List<int> colorCodes = <int>[100, 200];

  final List<String> schedules = <String>[
    '10:00 AM - 12:00 PM',
    '1:00 PM - 3:00 PM',
  ];

  List<int> availableSeats = <int>[50, 60];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Film"),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              _showScheduleDialog(context, index);
            },
            child: Container(
              height: 100,
              color: Colors.blue[colorCodes[index]],
              child: Row(
                children: [
                  SizedBox(
                    width: 100,
                    child: GestureDetector(
                      child: Image.network(images[index]),
                      onTap: () {
                        _showScheduleDialog(context, index);
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        entries[index],
                        style: const TextStyle(fontSize: 20),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        'Available Seats: ${availableSeats[index]}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: availableSeats[index] > 0 ? () => _buyTicket(context, index) : null,
                    child: const Text('Buy Ticket'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showScheduleDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(entries[index]),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Schedule: ${schedules[index]}'),
              const SizedBox(height: 10),
              Text('Available Seats: ${availableSeats[index]}'),
            ],
          ),
          actions: <Widget>[
            ElevatedButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _buyTicket(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        int selectedSeats = 1;

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Buy Ticket'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Film:'),
                  Text(entries[index]),
                  const SizedBox(height: 10),
                  const Text('Number of Tickets:'),
                  const SizedBox(height: 5),
                  TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        selectedSeats = int.tryParse(value) ?? 1;
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: 'Enter the number of tickets',
                    ),
                  ),
                ],
              ),
              actions: <Widget>[
                ElevatedButton(
                  child: const Text('Buy'),
                  onPressed: () {
                    setState(() {
                      availableSeats[index] -= selectedSeats;
                    });
                    Navigator.of(context).pop();
                    _showSuccessDialog(context, selectedSeats);
                  },
                ),
                ElevatedButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _showSuccessDialog(BuildContext context, int selectedSeats) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Payment Successful'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 48,
              ),
              const SizedBox(height: 10),
              const Text('Congratulations! Your payment was successful.'),
              Text('Number of Tickets: $selectedSeats'),
              const SizedBox(height: 10),
              ElevatedButton(
                child: const Text('Generate Ticket'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _generateTicket(context, selectedSeats);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _generateTicket(BuildContext context, int selectedSeats) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TicketScreen(selectedSeats: selectedSeats),
      ),
    );
  }
}

class TicketScreen extends StatelessWidget {
  final int selectedSeats;

  const TicketScreen({Key? key, required this.selectedSeats}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ticket'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.confirmation_number,
              size: 48,
            ),
            const SizedBox(height: 10),
            const Text(
              'Ticket(s) Successfully Generated',
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 10),
            Text('Number of Tickets: $selectedSeats'),
          ],
        ),
      ),
    );
  }
}
