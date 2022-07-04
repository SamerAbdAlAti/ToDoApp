import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:sqflit_app/shear/cubit/App_Cubit.dart';
import 'package:sqflit_app/shear/cubit/App_State.dart';

class bottomsheet extends StatelessWidget {
  const bottomsheet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<App_Cubit, App_State>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        App_Cubit cubit = App_Cubit.git(context);

        return Container(
          color: Colors.grey[200],
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "This is required";
                    }
                  },
                  controller: cubit.titelcontrolar,
                  decoration: InputDecoration(
                    hintText: "Titel",
                    prefixIcon: Icon(Icons.title),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.none,
                  controller: cubit.Timecontrolar,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "This is required";
                    }
                  },
                  onTap: () {
                    showTimePicker(
                            context: context, initialTime: TimeOfDay.now())
                        .then((value) {
                      cubit.Timecontrolar.text = value!.format(context);
                      print(value.format(context).toString());
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Time",
                    prefixIcon: Icon(Icons.watch_later_outlined),
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  keyboardType: TextInputType.none,
                  controller: cubit.Datelcontrolar,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "This is required";
                    }
                  },
                  onTap: () {
                    showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime.parse("2025-07-04"))
                        .then((value) {
                      cubit.Datelcontrolar.text =
                          DateFormat.yMMMd().format(value!);
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Date",
                    prefixIcon: Icon(Icons.calendar_month),
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget builditems({
  modle,
}) =>
    BlocConsumer<App_Cubit, App_State>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        App_Cubit cubit = App_Cubit.git(context);
        return Dismissible(
          key: GlobalKey(debugLabel: "${modle['id']}"),
          onDismissed: (value) {
            cubit.DeletefromDatabase(id: modle['id']);
          },
          child: Card(
            child: Container(
                child: Padding(
              padding: const EdgeInsets.only(
                  top: 20, left: 10, right: 5, bottom: 20),
              child: Row(
                children: [
                  Container(
                      height: 100,
                      width: 100,
                      child: Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          SvgPicture.asset("assets/images/watch.svg"),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text("${modle['time']}"),
                          )
                        ],
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Stack(
                    alignment: AlignmentDirectional.centerEnd,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            child: Flexible(
                                child: Container(
                                    height: 70,
                                    width:
                                        MediaQuery.of(context).size.width - 140,
                                    child: Text(
                                      "${modle['name']}",
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      style: TextStyle(
                                          fontSize: 21,
                                          fontWeight: FontWeight.w500),
                                    ))),
                          ),
                          Text(
                            "${modle['date']}",
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                cubit.UpdateDatabase(
                                    status: "done", id: modle['id']);
                              },
                              icon: Icon(
                                Icons.done_outline,
                                color: Colors.green,
                              )),
                          SizedBox(
                            width: 5,
                          ),
                          IconButton(
                              onPressed: () {
                                cubit.UpdateDatabase(
                                    status: "archive", id: modle['id']);
                              },
                              icon: Icon(
                                Icons.archive,
                                color: Colors.grey,
                              )),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            )),
          ),
        );
      },
    );
