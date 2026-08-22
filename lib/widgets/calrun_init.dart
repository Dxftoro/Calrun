import "package:flutter/material.dart";
import "start_button.dart";

class CalrunInit extends StatelessWidget {
	final void Function() onPressed;

	const CalrunInit({ super.key, required this.onPressed });

	@override
	Widget build(BuildContext context) {
		return StartButton(onPressed: onPressed);
	}
}