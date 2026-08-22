import 'package:calrun/widgets/start_button.dart';
import 'package:flutter/material.dart';
import "../models/settings.dart";

class CalrunFinished extends StatelessWidget {
	final int mistakeCount;
	final double averageMs;
	final void Function() onPressed;

	const CalrunFinished({
		super.key,
		required this.mistakeCount,
		required this.averageMs,
		required this.onPressed
	});

	@override
	Widget build(BuildContext build) {
		return Center(
			child: Column(
				mainAxisSize: MainAxisSize.min,
				children: [
					Row(
						mainAxisAlignment: MainAxisAlignment.center,
						children: [
              Text(
								"Average TPA: ${(averageMs / 1000.0).toStringAsPrecision(Settings.tpaPrecision.value)}s",
								style: const TextStyle(fontSize: 24),
							),
              const SizedBox(width: 20),
							Text(
								"Mistakes: $mistakeCount",
								style: const TextStyle(fontSize: 24, color: Colors.red),
							),
						]
					),
					const SizedBox(height: 16),
					StartButton(onPressed: onPressed),
				]
			)
		);
	}

}