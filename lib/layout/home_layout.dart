import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflit_app/moduols/componants/componants.dart';
import 'package:sqflit_app/shear/cubit/App_Cubit.dart';
import 'package:sqflit_app/shear/cubit/App_State.dart';

class Home_layout extends StatelessWidget {
  const Home_layout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<App_Cubit, App_State>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        App_Cubit cubit = App_Cubit.git(context);
        return Scaffold(
          appBar: AppBar(
            title: Text("${cubit.whatisScreen[cubit.currentindex]}"),
          ),
          body: Form(
            key: cubit.formkey,
            child: Scaffold(
              key: cubit.scaffoldkey,
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  if (cubit.isnotopen) {
                    cubit.scaffoldkey.currentState!
                        .showBottomSheet((context) {
                          return bottomsheet();
                        })
                        .closed
                        .then((value) {
                          cubit.isopen_change();
                          cubit.UpdateDatabase(status: "done", id: 1);


                        });
                    cubit.isopen_change();
                  } else {
                    if (cubit.formkey.currentState!.validate()) {
                      Navigator.pop(context);
                      cubit.insartinDatabase();
                      cubit.isopen_change(index: false);

                    }
                  }
                },
                child: Icon(!cubit.isnotopen ? Icons.add : Icons.edit),
              ),

              bottomNavigationBar: BottomNavigationBar(
                currentIndex: cubit.currentindex,
                onTap: (index) {
                  cubit.currentindex_change(index);
                },
                items: cubit.items,
              ),
              body: cubit.Screens[cubit.currentindex],
            ),
          ),
        );
      },
    );
  }
}
