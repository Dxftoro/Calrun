import 'package:flutter/material.dart';

class TimeInput extends StatefulWidget {
	final void Function(int minutes, int seconds)? onComplete;

	const TimeInput({
		super.key,
		this.onComplete
	});

	@override
	TimeInputState createState() => TimeInputState();
}

class TimeInputState extends State<TimeInput> {
	final TextEditingController contMinutes = TextEditingController();
	final TextEditingController contSeconds = TextEditingController();

	final FocusNode focMinutes = FocusNode();
	final FocusNode focSeconds = FocusNode();

	int minutes = 0;
	int seconds = 0;

	@override
	void dispose() {
		contMinutes.dispose();
		contSeconds.dispose();
		focMinutes.dispose();
		focSeconds.dispose();
		super.dispose();
	}

	void _notify() {
		//widget.onChanged(minutes, seconds);
	}

	@override
	Widget build(BuildContext context) {
		return Row(
			mainAxisAlignment: MainAxisAlignment.center,
			children: [
				SizedBox(
					width: 60,
					child: TextField(
						autofocus: true,
						controller: contMinutes,
						focusNode: focMinutes,
						keyboardType: TextInputType.number,
						textAlign: TextAlign.center,
						maxLength: 2,
						decoration: const InputDecoration(counterText: "", hintText: "mm"),
						onChanged: (text) {
							minutes = int.tryParse(text) ?? 0;
							_notify();

							if (text.length == 2) {
								focSeconds.requestFocus();
							}
						},
					)
				),
				const Padding(
					padding: EdgeInsets.symmetric(horizontal: 8),
					child: Text(":", style: TextStyle(fontSize: 24))
				),
				SizedBox(
					width: 60,
					child: TextField(
						controller: contSeconds,
						focusNode: focSeconds,
						keyboardType: TextInputType.number,
						textAlign: TextAlign.center,
						maxLength: 2,
						decoration: const InputDecoration(counterText: "", hintText: "ss"),
						onChanged: (text) {
							int value = int.tryParse(text) ?? 0;
							seconds = value > 59 ? 59 : value; 
							_notify();

							if (text.length == 2) {
								widget.onComplete?.call(minutes, seconds);
								focMinutes.requestFocus();
							}
						},
					)
				)
			],
		);
	}
}