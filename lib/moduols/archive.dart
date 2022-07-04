import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../shear/cubit/App_Cubit.dart';
import '../shear/cubit/App_State.dart';
import 'componants/componants.dart';

class Archive_Screen extends StatelessWidget {
  const Archive_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<App_Cubit,App_State>(

        listener: (BuildContext context, state) {  },
        builder: (BuildContext context, Object? state) {

          App_Cubit cubit=App_Cubit.git(context);
          var list=cubit.archive;
          return list.length>0?ListView.builder(itemBuilder: (context,index)=>builditems(
            modle: list[index],
          ), itemCount: list.length):Container(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.archive,color: Colors.grey,
                    size: 160,),
                  Flexible(
                    child: Container(
                      child: Text("There is no archive tasks",
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
