import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:habit_tracker/Models/colors.dart';
import 'package:intl/intl.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  @override
  Widget build(BuildContext context) {
    ValueNotifier<Color> myColor = ValueNotifier<Color>(Colors.red);
    final TextEditingController nameController = TextEditingController();
    final TextEditingController noteController = TextEditingController();

    ValueNotifier<String> name = ValueNotifier<String>('New Task');
    late DateTime date;
    String? description;
    Color remColor = Colors.blue;
    bool playBool = true;

    return Scaffold(
      //!App bar thingy
      appBar: AppBar(
        title: const Text(
          'Add Task',
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          CupertinoButton(
              onPressed: () {},
              child: const Text(
                'Add',
                style: TextStyle(color: CupertinoColors.activeBlue),
              ))
        ],
      ),

      body: ListView(
        children: [
          //!The preview
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //!check box
                ValueListenableBuilder(
                    valueListenable: myColor,
                    builder: (BuildContext context, value, Widget? child) {
                      return Checkbox(
                        fillColor:
                            MaterialStateProperty.all<Color>(myColor.value),
                        shape: const CircleBorder(side: BorderSide.none),
                        value: playBool,
                        onChanged: (val) {},
                        checkColor: CupertinoColors.white,
                      );
                    }),

                //!title / note

                ValueListenableBuilder(
                  valueListenable: name,
                  builder:
                      (BuildContext context, dynamic value, Widget? child) {
                    return Text(
                      overflow: TextOverflow.ellipsis,
                      name.value,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    );
                  },
                ),

                //!time /  date
                Text(DateFormat('hh:mm').format(DateTime.now()))
              ],
            ),
          ),
          //!Text widgets
          Container(
            margin: const EdgeInsets.all(8),
            padding: const EdgeInsets.all(8),
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            //!list of everything
            child: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextField(
                    decoration: const InputDecoration(
                      helperText: '*Reqiered',
                      helperStyle: TextStyle(color: Colors.red),
                    ),
                    textInputAction: TextInputAction.next,
                    enabled: true,
                    showCursor: true,
                    onChanged: (value) {
                      setState(() {
                        name.value = value;
                      });
                    },
                    controller: nameController,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextField(
                    textInputAction: TextInputAction.done,
                    controller: noteController,
                    minLines: null,
                    maxLines: null,
                  ),
                ),
                //!the cool stuff Row
                //!Button text combos
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Container(
                    padding: EdgeInsets.only(left: 8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "08:20",
                          style: TextStyle(fontSize: 20, color: Colors.pink),
                        ),
                        CupertinoButton(
                          onPressed: pickTime,
                          child: const CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.blue,
                            child: Icon(CupertinoIcons.clock,
                                size: 35, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Container(
                    padding: const EdgeInsets.only(left: 8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "20 - 08 -2022",
                          style: TextStyle(fontSize: 20, color: Colors.pink),
                        ),
                        CupertinoButton(
                          onPressed: pickDate,
                          child: const CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.blue,
                            child: Icon(
                              CupertinoIcons.calendar,
                              size: 35,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Container(
                    padding: const EdgeInsets.only(left: 8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Notifications?",
                          style: TextStyle(fontSize: 20, color: Colors.pink),
                        ),
                        CupertinoButton(
                          onPressed: () {},
                          child: const CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.blue,
                            child: Icon(CupertinoIcons.bell,
                                size: 35, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Container(
                    padding: const EdgeInsets.only(left: 8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).backgroundColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Pick Color",
                          style: TextStyle(fontSize: 20, color: Colors.pink),
                        ),
                        CupertinoButton(
                          onPressed: showColorPicke,
                          child: const CircleAvatar(
                            radius: 30,
                            backgroundColor: Colors.blue,
                            child: Icon(CupertinoIcons.bell,
                                size: 35, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CupertinoButton(
                      onPressed: () {},
                      child: AnimatedContainer(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        width: MediaQuery.of(context).size.width * .3,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.lightBlue.shade200,
                                  spreadRadius: 1,
                                  blurRadius: 5)
                            ],
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(colors: [
                              Colors.pink,
                              Colors.pink.shade400,
                              Colors.pink.shade200
                            ])),
                        duration: const Duration(milliseconds: 500),
                        child: const Icon(
                          CupertinoIcons.check_mark,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  ValueNotifier<Color> myColor = ValueNotifier<Color>(Colors.red);
  Color _color = Colors.red;

  //! functions and sheet widgets
  void showColorPicke() {
    showDialog(
        context: context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: AlertDialog(
              actionsAlignment: MainAxisAlignment.end,
              actions: [
                CupertinoButton(
                    color: myColor.value,
                    disabledColor: Colors.green,
                    child: const Text('done'),
                    onPressed: () => Navigator.pop(context))
              ],
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text('pick color'),
                  CupertinoButton(
                      onPressed: showMoreColors,
                      child: const Text(
                        'more',
                        style: TextStyle(color: Colors.blue),
                      ))
                ],
              ),
              content: BlockPicker(
                  availableColors: colors,
                  pickerColor: _color,
                  onColorChanged: (color) {
                    setState(() {
                      myColor.value = color;
                    });
                  }),
            ),
          );
        });
  }

  void pickTime() {
    showTimePicker(context: context, initialTime: TimeOfDay.now());
  }

  void pickDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime(DateTime.now().year + 1),
    );
  }

  void showMoreColors() {
    Navigator.pop(context);
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const Text('select color'),
                CupertinoButton(
                  onPressed: showColorPicke,
                  child: const Text(
                    'less',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
            actions: [
              CupertinoButton(
                  color: _color,
                  child: const Text('done'),
                  onPressed: () => Navigator.pop(context))
            ],
            content: ColorPicker(
              colorPickerWidth: MediaQuery.of(context).size.width,
              pickerAreaHeightPercent: 1,
              onColorChanged: (value) {},
              pickerColor: _color,
              enableAlpha: false,
            ),
          );
        });
  }
}
