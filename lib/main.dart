import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflit_app/layout/home_layout.dart';
import 'package:sqflit_app/shear/cubit/App_Cubit.dart';
import 'package:sqflit_app/shear/cubit/blocopserver.dart';
import 'package:sqflit_app/shear/style/style.dart';

void main() {
  BlocOverrides.runZoned(
    () {
      // Use cubits...
      App_Cubit();
      runApp(const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => App_Cubit()..createDatabase(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: App_Style.LightTheme,
        darkTheme: App_Style.DarkTheme,
        home: const Home_layout(),
      ),
    );
  }
}
