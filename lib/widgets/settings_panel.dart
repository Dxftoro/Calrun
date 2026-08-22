import 'package:flutter/material.dart';
import "../models/settings.dart";
import "settings_field.dart";

class SettingsPanel extends StatelessWidget {
	const SettingsPanel({super.key});

	@override
	Widget build(BuildContext context) {
		return SafeArea(
			child: Padding(
				padding: const EdgeInsets.all(16),
				child: Column(
					children: [
						SettingsField(title: "Task count", parameter: Settings.taskCount),
						SettingsField(title: "Average TPA precision", parameter: Settings.tpaPrecision),
						SettingsField(title: "Min. minutes", parameter: Settings.minMinutes),
						SettingsField(title: "Max. minutes", parameter: Settings.maxMinutes),
						SettingsField(title: "Min. addition seconds", parameter: Settings.minPlusSeconds),
						SettingsField(title: "Max. addition seconds", parameter: Settings.maxPlusSeconds),
					],
				),
			)
		);
	}
}