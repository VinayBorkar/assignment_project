// ignore_for_file: use_key_in_widget_constructors

import 'package:assignment_project/model/item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:date_format/date_format.dart';
import 'package:notification_permissions/notification_permissions.dart';

class InitialScreen extends StatefulWidget {
  @override
  _InitialScreenState createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  List<ItemModel> item = [
    ItemModel("Clients", false, null, false),
    ItemModel("Designer", false, null, false),
    ItemModel("Developer", false, null, false),
    ItemModel("Worker", false, null, false),
    ItemModel("Employee", false, null, false),
    ItemModel("Manager", false, null, false),
    ItemModel("Owner", false, null, false),
  ];

  bool newData = false;

  List<ItemModel> newItems = [];
  var newDataController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  String _hour = '', _minute = '', _time = '';

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  void reorderData(int oldindex, int newindex) {
    setState(() {
      if (newindex == item.length) {
        final items = item.removeAt(oldindex);
        item.insert(newindex - 1, ItemModel(items.title, true, null, false));
      } else {
        if (newindex > oldindex) {
          newindex -= 1;
        }
        final items = item.removeAt(oldindex);
        item.insert(newindex, items);
      }
    });
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null) {
      print(picked);
      _selectTime(context);
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
    }
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) {
      Future<PermissionStatus> permissionStatus =
          NotificationPermissions.getNotificationPermissionStatus();
      setState(() {
        var selectedItem = item[0];
        selectedItem.title = newDataController.text;
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _timeController.text = _time;
        _timeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
        final DateFormat formatter = DateFormat('yyyy-MM-dd');
        final String formatted = formatter.format(selectedDate);
        selectedItem.date = formatted + ' ' + _time;
      });
    }
  }

  void addNewTile() {
    setState(() {
      item.insert(0, ItemModel('', false, null, true));
      newData = true;
    });
  }

  void doNothing(BuildContext ctx) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Container(
          child: ReorderableListView(
            children: item
                .map(
                  (i) => Slidable(
                    key: UniqueKey(),
                    direction: Axis.horizontal,
                    startActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      dismissible: DismissiblePane(
                        onDismissed: () {
                          setState(() {
                            item.add(ItemModel(i.title, true, null, false));
                            item.remove(i);
                          });
                        },
                      ),
                      children: [
                        SlidableAction(
                          onPressed: doNothing,
                          icon: Icons.accessible_forward_sharp,
                          foregroundColor: Colors.green,
                          backgroundColor: Colors.black,
                        )
                      ],
                    ),
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: doNothing,
                          icon: Icons.cancel,
                          foregroundColor: Colors.red,
                          backgroundColor: Colors.black,
                        )
                      ],
                      dismissible: DismissiblePane(
                        onDismissed: () {
                          setState(() {
                            item.remove(i);
                          });
                        },
                      ),
                    ),
                    child: Card(
                      color: i.isComplete ? Colors.black45 : Colors.red,
                      key: UniqueKey(),
                      elevation: 2,
                      child: i.isNew
                          ? Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextField(
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Enter Title',
                                    ),
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                    controller: newDataController,
                                  ),
                                  GestureDetector(
                                    child: Text(
                                      i.date != null
                                          ? i.date.toString()
                                          : 'Add Date',
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    onTap: () {
                                      _selectDate(context);
                                    },
                                  ),
                                ],
                              ),
                            )
                          : ListTile(
                              title: Text(
                                i.title,
                                style: i.isComplete
                                    ? const TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                        color: Colors.grey)
                                    : const TextStyle(color: Colors.white),
                              ),
                            ),
                    ),
                  ),
                )
                .toList(),
            onReorder: reorderData,
          ),
        ),
      ),
      floatingActionButton: IconButton(
        onPressed: addNewTile,
        icon: const Icon(
          Icons.add,
          color: Colors.amber,
          size: 50,
        ),
      ),
    );
  }
}
