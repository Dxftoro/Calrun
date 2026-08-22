import 'package:flutter/material.dart';
import "../models/ref.dart";

class SettingsField extends StatelessWidget {
	final String title;
	final Ref<int> parameter;

	const SettingsField({
		super.key, 
		required this.title,
		required this.parameter
	});

	@override
	Widget build(BuildContext build) {
		return TextFormField(
			initialValue: parameter.value.toString(),
			keyboardType: TextInputType.number,
			decoration: InputDecoration(labelText: title),
			onChanged: (text) {
				final v = int.tryParse(text);
				if (v != null) parameter.value = v;
			},
		);
	}
}