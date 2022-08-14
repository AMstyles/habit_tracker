import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:habit_tracker/Models/habit.dart';
import 'package:habit_tracker/Models/reminder.dart';
import 'package:habit_tracker/Pages/add_taskPage.dart';
import 'package:habit_tracker/Pages/focusPage.dart';
import 'package:habit_tracker/Pages/remiders_page.dart';
import 'package:habit_tracker/Pages/weather.dart';
import 'package:habit_tracker/Widgets/habitsWidg.dart';
import 'package:habit_tracker/Widgets/home_task_tile.dart';
import 'package:habit_tracker/Widgets/light_night_experiment.dart';
import 'package:rive/rive.dart' as Rive;
import 'package:sticky_headers/sticky_headers/widget.dart';
import 'habits_page.dart';
import 'package:animated_page_transition/animated_page_transition.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  int currIndex = 0;
  late String time;
  late Rive.RiveAnimationController statecontroller;

  late Rive.StateMachineController? _controller;
  late Rive.SMIInput<bool>? isDark;

  void onStart(Rive.Artboard artboard) {
    var controller =
        Rive.StateMachineController.fromArtboard(artboard, 'MyStateMachine');
    if (controller != null) {
      artboard.addController(controller);
      isDark = controller.findInput('isDark');
      isDark!.value = false;
    }
  }

  @override
  void initState() {
    super.initState();

    int now = TimeOfDay.now().hour;

    if (now >= 5 && now < 12) {
      time = 'Good Morning,';
    } else if (now >= 12 && now < 18) {
      time = 'Good Afternoon';
    } else if (now >= 18 && now < 24) {
      time = 'Good evening,';
    } else {
      time = "Late night,";
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  final Color _color = Colors.red;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /*drawer: SafeArea(
        child: Container(
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30),
                  bottomRight: Radius.circular(30))),
          child: Drawer(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                DrawerHeader(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset('lib/Assets/XTlabel.png'),
                        const Text(
                          "E X P E R I M E N T A L",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      'ThemeMode',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                    ),
                    Switcher(),
                  ],
                ),
              ],
            ),
          ),
        ),
      )*/
      floatingActionButton: SpeedDial(
        animationDuration: const Duration(milliseconds: 150),
        animationCurve: Curves.easeInOutCubic,
        overlayColor: Colors.black,
        backgroundColor: CupertinoColors.activeBlue,
        activeBackgroundColor: CupertinoColors.destructiveRed,
        activeIcon: CupertinoIcons.clear,
        icon: CupertinoIcons.add,
        spacing: 10,
        children: [
          SpeedDialChild(
              onTap: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => AddTaskPage())),
              child: const Icon(CupertinoIcons.calendar_badge_plus),
              label: 'Task'),
          SpeedDialChild(
              onTap: () {},
              child: Icon(CupertinoIcons.clock),
              label: 'Timed Habit'),
          SpeedDialChild(
              onTap: (() {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => FocusPage()));
              }),
              child: const Hero(
                  tag: 'focus', child: Icon(Icons.self_improvement_rounded)),
              label: 'Start focus period'),
        ],
      ),
      //backgroundColor: CupertinoColors.lightBackgroundGray,

      body: CustomScrollView(
        slivers: [
          //The top row name and shit

          SliverAppBar(
            backgroundColor: Theme.of(context).accentColor,
            collapsedHeight: 80,
            primary: true,
            actions: [
              SwitcherMini(
                callback: () => isDark!.value = !(isDark!.value),
              ),
            ],
            pinned: true,
            elevation: 0,
            bottom: PreferredSize(
                preferredSize: const Size.fromHeight(0),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  //height: 10,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(60),
                      topRight: Radius.circular(60),
                    ),
                  ),
                )),
            expandedHeight: 250,
            stretch: true,
            onStretchTrigger: () => HapticFeedback.lightImpact(),
            flexibleSpace: FlexibleSpaceBar(
              title: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(time),
                    const Text(
                      'Arinaho',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      ),
                    ),
                  ],
                ),
              ),
              centerTitle: true,
              background: DecoratedBox(
                position: DecorationPosition.foreground,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.center,
                    colors: [
                      Colors.black.withOpacity(.5),
                      Colors.black.withOpacity(0)
                    ],
                  ),
                ),
                child: Rive.RiveAnimation.asset(
                  'lib/Assets/new_file.riv',
                  fit: BoxFit.cover,
                  artboard: 'Artboard',
                  stateMachines: const ['MyStateMachine'],
                  onInit: onStart,
                ),
              ),
            ),
          ),
          //Habits text

          SliverToBoxAdapter(
            child: StickyHeader(
              header: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Habits',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: CupertinoColors.inactiveGray),
                    ),
                    CupertinoButton(
                        child: const Icon(Icons.arrow_forward_ios),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => Habits()));
                        })
                  ],
                ),
              ),
              content: Padding(
                padding: const EdgeInsets.only(top: 0, bottom: 10),
                child: SizedBox(
                  height: 150,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: habits.length,
                      itemBuilder: (context, int index) {
                        return HabitWidg(
                          habit: habits[index],
                          ind: index,
                        );
                      }),
                ),
              ),
            ),
          ),
          //ListViews of the actual habits

          //Tasks text and shit
          SliverToBoxAdapter(
            child: StickyHeader(
              overlapHeaders: true,
              header: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Tasks',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: CupertinoColors.inactiveGray),
                    ),
                    CupertinoButton(
                        child: const Icon(
                          Icons.arrow_forward_ios,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const HabitPage()));
                        })
                  ],
                ),
              ),
              content: ListView.builder(
                shrinkWrap: true,
                itemCount: reminders.length,
                physics: const ClampingScrollPhysics(),
                itemBuilder: ((context, index) {
                  return HomeTaskTile(
                    index: index,
                  );
                }),
              ),
            ),
          )
        ],
      ),
    );
  }

//! functions and sheet widgets

  void openAddTask() {}

  Widget buildSheet() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController noteController = TextEditingController();

    ValueNotifier<String> name = ValueNotifier<String>('New Task');
    late DateTime date;
    String? description;
    Color remColor = Colors.blue;

    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      builder: (_, scrollController) => Container(
          decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(15)),
          child: const Text('wtf')),
    );
  }

  bool? playBool = false;

  ValueNotifier<Color> myColor = ValueNotifier<Color>(Colors.blue);
}
