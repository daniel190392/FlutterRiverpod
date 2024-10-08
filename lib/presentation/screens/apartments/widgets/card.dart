import 'package:flutter/material.dart';

class ApartmentCard extends StatelessWidget {
  const ApartmentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: const EdgeInsets.all(8),
      clipBehavior: Clip.antiAlias,
      color: Colors.grey,
      child: Row(
        children: [
          Image.asset(
            'assets/images/android.png',
            height: 100,
            fit: BoxFit.cover,
          ),
          const AparmentDescription()
        ],
      ),
    );
  }
}

class AparmentDescription extends StatelessWidget {
  const AparmentDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              textAlign: TextAlign.center,
              'Los sauces, Torre A - 801 2',
              softWrap: true,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 8, 73, 126),
                fontSize: 18,
              ),
            ),
            Text(
              'Chorrillos',
              style: TextStyle(
                color: Color.fromARGB(255, 8, 73, 126),
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
