import "dart:math" as math;
import "time_point.dart";
import "settings.dart";

class ExprGenerator {
	TimePoint timePoint = TimePoint(0, 0);
	TimePoint right = TimePoint(0, 0);
	int plusSeconds = 0;

	ExprGenerator() {
		generate();
	}

	int rand(math.Random random, int min, int max) {
		return min + random.nextInt(max - min);
	}

	void generate() {
		math.Random random = math.Random();
		
		timePoint = TimePoint(
			rand(random, Settings.minMinutes.value, Settings.maxMinutes.value),
			random.nextInt(60)
		);
		
		plusSeconds = rand(random, Settings.minPlusSeconds.value, Settings.maxPlusSeconds.value);
		right = timePoint.add(plusSeconds);
	}

	bool compareToRight(TimePoint timePoint) {
		return right.minutes == timePoint.minutes && right.seconds == timePoint.seconds;
	}
}