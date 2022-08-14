class Habit {
  String name;
  bool isTime;
  int type; //1 = time, 2 = int progress, 3 = is done or not
  int prog;
  int goal;
  bool isGoing;
  int icon;
  int color;

  Habit(this.name, this.isTime, this.prog, this.goal, this.isGoing, this.type,
      this.icon, this.color);

  double getPercentD() {
    if (prog / goal > 1) {
      return 1;
    } else {
      return prog / goal;
    }
  }
}

List<Habit> habits = [
  Habit('Yoga', true, 3, 20, false, 1, 6, 5),
  Habit('Run', true, 17, 30, false, 1, 8, 19),
  Habit('Cycle', true, 30, 30, false, 1, 7, 23),
  Habit('Drink water', false, 500, 1500, false, 2, 9, 2),
  Habit('Study', true, 150, 270, false, 1, 1, 0),
  Habit('Code', true, 120, 130, false, 1, 3, 10),
  Habit('Cry', true, 0, 5, false, 1, 0, 3),
];
