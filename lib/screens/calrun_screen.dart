import 'package:flutter/material.dart';
import 'dart:developer' as dev;
import '../models/settings.dart';
import '../models/expr_generator.dart';
import '../models/time_point.dart';
import '../widgets/time_input.dart';
import '../widgets/settings_panel.dart';
import '../widgets/calrun_init.dart';
import '../widgets/calrun_finished.dart';
import 'package:audioplayers/audioplayers.dart';

enum CalrunState {
	init,
	solving,
	finished
}

class Calrun extends StatelessWidget {
	const Calrun({super.key});

	@override
	Widget build(BuildContext context) {
		return MaterialApp(
			home: Scaffold(
				appBar: AppBar(
					backgroundColor: const Color.fromARGB(255, 116, 154, 185),
					foregroundColor: Colors.white,
					title: Text("Calrun")
				),
				drawer: const Drawer(
					shape: ContinuousRectangleBorder(),
					child: SettingsPanel()
				),
				body: Container(
					decoration: BoxDecoration(
						gradient: LinearGradient(
							begin: Alignment.topLeft,
							end: Alignment.bottomRight,
							colors: [
								Color.fromARGB(255, 116, 154, 185),
								Theme.of(context).scaffoldBackgroundColor
							],
							stops: [0.0, 0.8],
						),
					),
					child: const Center(child: CalrunWidget()),
				),
			),
		);
	}
}

class CalrunWidget extends StatefulWidget {
	const CalrunWidget({super.key});

	@override
	CalrunMathState createState() => CalrunMathState();
}

class CalrunMathState extends State<CalrunWidget> {
  final AudioPlayer audio = AudioPlayer();

	ExprGenerator generator = ExprGenerator();
	int mistakeCount = 0;

	CalrunState state = CalrunState.init;
	final Stopwatch stopwatch = Stopwatch();
	int totalMs = 0;
	int answerCount = 0;

	@override
	void initState() {
		super.initState();
		AudioCache.instance.loadAll(["sounds/impressive.wav"]);
	}

	void start() {
		setState(() {
			dev.log("====================== Started ======================");
			state = CalrunState.solving;
			mistakeCount = 0;
			totalMs = 0;
			answerCount = 0;
			generator.generate();
			stopwatch
				..reset()
				..start();
		});
	}

	double get averageTimeMs {
		if (answerCount == 0) return 0;
		return totalMs / answerCount;
	}
	
	@override
	void dispose() {
		stopwatch.stop();
    	audio.dispose();
		super.dispose();
	}

	void tryReward(int elapsedMs, bool isValid) {
		if (!isValid) return;

		if (elapsedMs < 10000) {
			audio.play(AssetSource("sounds/impressive.wav"));
		}
	}

	@override
	Widget build(BuildContext context) {
		switch (state) {
			case CalrunState.init: return CalrunInit(onPressed: start);
			
			case CalrunState.finished: return CalrunFinished(
				mistakeCount: mistakeCount, 
				averageMs: averageTimeMs,
				onPressed: start
			);

			case CalrunState.solving:
			return Column(
				children: [
					Padding(
						padding: const EdgeInsets.only(top: 16),
						child: Text(
							"Solved: $answerCount/${Settings.taskCount.value}",
							style: const TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
						),
					),
					Expanded(
						child: Center(
							child: Column(
								mainAxisSize: MainAxisSize.min,
								children: [
									Row(
										mainAxisAlignment: MainAxisAlignment.center,
										children: [
											Text("Average TPA: ${(averageTimeMs / 1000.0).toStringAsPrecision(Settings.tpaPrecision.value)}s"),
											const SizedBox(width: 16),
											Text(
												"Mistakes: $mistakeCount",
												style: TextStyle(color: Color.fromARGB(255, 255, 0, 0))
											),
										]
									),
									const SizedBox(height: 16),
									Text(
										"${generator.timePoint} + ${generator.plusSeconds}s",
										style: TextStyle(fontSize: 24)
									),
									const SizedBox(height: 16),
									TimeInput(
										onComplete: (int m, int s) {
											stopwatch.stop();
											final elapsedMs = stopwatch.elapsedMilliseconds;

											TimePoint answer = TimePoint(m, s);
											bool isValid = generator.compareToRight(answer);

											dev.log("Answer: $answer, right: ${generator.right}, ($isValid), took: $elapsedMs");

											setState(() {
												if (!isValid) mistakeCount++;
												totalMs += elapsedMs;
												answerCount++;

												if (answerCount >= Settings.taskCount.value) {
													state = CalrunState.finished;
												}

												generator.generate();
											});

											stopwatch.reset();
											tryReward(elapsedMs, isValid);

											if (state == CalrunState.solving) { stopwatch.start(); }
											else { stopwatch.stop(); }
										}
									)
								],
							),
						),
					),
				],
			);
		}
	}
}