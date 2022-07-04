import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sqflit_app/moduols/componants/componants.dart';
import 'package:sqflit_app/shear/cubit/App_Cubit.dart';
import 'package:sqflit_app/shear/cubit/App_State.dart';

class Tasks_Screen extends StatelessWidget {
  const Tasks_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<App_Cubit,App_State>(

        listener: (BuildContext context, state) {  },
        builder: (BuildContext context, Object? state) {

          App_Cubit cubit=App_Cubit.git(context);
          var list=cubit.task;
          return list.length>0?ListView.builder(itemBuilder: (context,index)=>builditems(
            modle: list[index],
          ), itemCount: list.length):Container(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.menu,color: Colors.grey,
                  size: 160,),
                  Flexible(
                    child: Container(
                      child: Text("NO Tasks YET, Please Add Some Tasks",
                      style: TextStyle(fontSize: 18,color: Colors.grey[700]

                      ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );}

    );
        }

}
