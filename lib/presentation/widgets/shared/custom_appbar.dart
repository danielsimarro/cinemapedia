import 'package:flutter/material.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;
    return SafeArea(
        bottom: false,
        child: Container(
          color: Colors.grey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Icon(Icons.movie_outlined, color: colors.primary),
                    const SizedBox(width: 5),
                    Text(
                      'Cinemapedia',
                      style: titleStyle,
                    ),
                    // Toma el espacio y se mueve el search a la derecha
                    const Spacer(),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.search))
                  ],
                )),
          ),
        ));
  }
}
