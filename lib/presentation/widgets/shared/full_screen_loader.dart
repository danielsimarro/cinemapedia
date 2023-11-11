import 'package:flutter/material.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({super.key});

  Stream<String> gerLoadingMessages() {
    final messages = <String>[
      'Cargando películas',
      'Comprando palomitas de maíz',
      'Cargando populares'
    ];
    return Stream.periodic(const Duration(microseconds: 1200), (step) {
      return messages[step];
    }).take(messages.length);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('Espere por favor'),
          const SizedBox(
            height: 10,
          ),
          const CircularProgressIndicator(
            strokeWidth: 2,
          ),
          const SizedBox(
            height: 10,
          ),
          StreamBuilder(
              stream: gerLoadingMessages(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Text('Cargando ...');

                return Text(snapshot.data!);
              })
        ],
      ),
    );
  }
}
