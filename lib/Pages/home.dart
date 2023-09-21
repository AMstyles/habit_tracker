import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:habit_tracker/Models/dark_light.dart';
import 'package:habit_tracker/Models/habit.dart';
import 'package:habit_tracker/Models/task.dart';
import 'package:habit_tracker/Widgets/habitsWidg.dart';
import 'package:habit_tracker/Widgets/light_night_experiment.dart';
import 'package:habit_tracker/Widgets/task_widget.dart';
import 'package:habit_tracker/database/database.dart';
import 'package:habit_tracker/formatters/date_time_formatters.dart';
import 'package:provider/provider.dart';
import 'package:rive/rive.dart' as Rive;
import 'package:sticky_headers/sticky_headers/widget.dart';
import '../sheets/add_task_sheet.dart';
import 'add_taskPage.dart';
import 'focusPage.dart';
import 'habits_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {

  late String time;
  late Rive.RiveAnimationController stateController;

  late Rive.StateMachineController? _controller;
  late Rive.SMIInput<bool>? isDark;

  void onStart(Rive.Artboard artboard) {
    var controller =
        Rive.StateMachineController.fromArtboard(artboard, 'MyStateMachine');
    if (controller != null) {
      artboard.addController(controller);
      isDark = controller.findInput('isDark');

      var brightness = SchedulerBinding.instance.window.platformBrightness;
      bool isDarkMode = brightness == Brightness.dark;

      isDark!.value = Provider.of<ThemeController>(context, listen: false).isDark;
    }
  }

  @override
  void initState() {
    super.initState();

    time = TimeHelper.getPartOfDay();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // floatingActionButton:Builder(builder: (BuildContext context) =>
      //    SpeedDial(
      //     animationDuration: const Duration(milliseconds: 150),
      //     animationCurve: Curves.easeInOutCubic,
      //     overlayColor: Colors.black,
      //     backgroundColor: CupertinoColors.activeBlue,
      //     activeBackgroundColor: CupertinoColors.destructiveRed,
      //     activeIcon: CupertinoIcons.clear,
      //     icon: CupertinoIcons.add,
      //     spacing: 10,
      //     children: [
      //       SpeedDialChild(
      //           onTap: (){
      //             Scaffold.of(context).showBottomSheet(
      // backgroundColor: Colors.transparent,
      //                     enableDrag: true,
      //                     (context) => const AddTaskSheet()
      //
      //             );
      //           },
      //           child: const Icon(CupertinoIcons.calendar_badge_plus),
      //           label: 'Task'),
      //       SpeedDialChild(
      //           onTap: () {},
      //           child: const Icon(CupertinoIcons.clock),
      //           label: 'Timed Habit'),
      //       SpeedDialChild(
      //           onTap: (() {
      //             Navigator.of(context)
      //                 .push(MaterialPageRoute(builder: (context) => FocusPage()));
      //           }),
      //           child: const Hero(
      //               tag: 'focus', child: Icon(Icons.self_improvement_rounded)),
      //           label: 'Start focus period'),
      //     ],
      //   ),
      //),
      floatingActionButton: FloatingActionButton(onPressed: () {  },
        child: Text("add"),
      ),



      body:Builder(builder: (BuildContext context) {
     return CustomScrollView(
        slivers: [
          //The top row name and shit
          SliverAppBar(
            backgroundColor: Colors.blue,
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
                         // Scaffold.of(context).showBottomSheet((context) => Container(height: 300,));
                        })
                  ],
                ),
              ),
              content: FutureBuilder(
                future: Database.getAllTasks(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if(snapshot.hasData){
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, int index) {
                        return TaskWidget(
                          task: snapshot.data[index],
                        );
                      });
                  }
                  return const Center(child: CircularProgressIndicator.adaptive(),);
                },

              )
            ),
          )
        ],
      );
      },),
    );
  }

}
