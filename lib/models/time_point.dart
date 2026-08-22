class TimePoint {
	int minutes = 0;
	int seconds = 0;

	TimePoint(this.minutes, this.seconds);

	TimePoint add(int seconds) {
		int totalSeconds = this.seconds + seconds;
		int minutes = this.minutes + totalSeconds ~/ 60;
		int remainingSeconds = totalSeconds % 60;
		return TimePoint(minutes, remainingSeconds);
	}

	@override
	String toString() {
		return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
	}
}