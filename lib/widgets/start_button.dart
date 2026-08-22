import 'package:flutter/material.dart';

class StartButton extends StatelessWidget {
	final void Function() onPressed;

	const StartButton({super.key, required this.onPressed});

	@override
	Widget build(BuildContext context) {
		return Center(
			child: ElevatedButton(
				onPressed: onPressed,
				style: ElevatedButton.styleFrom(
					backgroundColor: const Color.fromARGB(255, 116, 154, 185),
					foregroundColor: Colors.white,
					padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
					textStyle: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
					shape: ContinuousRectangleBorder(),
				),
				child: const Text("Start"),
			)
		);
	} 
}