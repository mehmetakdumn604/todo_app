import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/core/extensions/context_extensions.dart';
import 'package:todo_app/firebase_options.dart';
import 'package:todo_app/providers/provider_data.dart';
import 'package:todo_app/services/api_service.dart';
import 'package:todo_app/view/home/todos_home/components/tasks_list_widget.dart';
import 'package:todo_app/view/home/todos_home/models/task_model.dart';
import 'package:todo_app/view/home/todos_home/models/task_modell.dart';
import 'package:todo_app/view/home/todos_home/todos_home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await StrApiService.strApiInit();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => ProviderData(),
      ),
      FutureProvider(
        updateShouldNotify: (previous, current) {
          return previous != current;
        },
        initialData: const [],
        create: (context) async {
          ProviderData data = Provider.of<ProviderData>(context, listen: false);
          Future<User> futureUser = StrApiService.getCurrentUser(data);

          data.currentUser = await futureUser;

          if (data.currentUser != null) {
            FlutterNativeSplash.remove();
          }
          return futureUser;
        },
        lazy: false,
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const TodosHome(),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  late Future<User> myFuture;
  @override
  void initState() {
    final ProviderData data = Provider.of(context, listen: false);
    myFuture = StrApiService.getCurrentUser(data);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ProviderData data = context.watch();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: FutureBuilder<User>(
                future: myFuture,
                builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data?.tasks.length,
                      itemBuilder: (context, index) {
                        TaskModel? task = snapshot.data?.tasks[index];

                        return Padding(
                          key: ValueKey(task?.id ?? "index"),
                          padding: const EdgeInsets.all(8.0),
                          child: Dismissible(
                            key: ValueKey(task?.id ?? ""),
                            confirmDismiss: (direction) async {
                              // if (direction == DismissDirection.endToStart) {
                              //   data.removeTask(task);
                              // }

                              return;
                            },
                            direction: DismissDirection.endToStart,
                            background: Container(
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: roundedRectangleBorder.borderRadius,
                              ),
                            ),
                            onDismissed: (direction) {},
                            child: CheckboxListTile(
                              checkboxShape: const CircleBorder(),
                              value: task?.isFinished,
                              activeColor: Colors.green,
                              onChanged: (value) {
                                // task.changeFinishedState();
                                // data.updateTaskLocation(task);
                              },
                              tileColor: Colors.black,
                              shape: roundedRectangleBorder,
                              title: Text(
                                task?.taskName ?? "",
                                style: context.textTheme.titleMedium!.copyWith(
                                  color: Colors.white,
                                  decoration: (task?.isFinished ?? false) ? TextDecoration.lineThrough : TextDecoration.none,
                                  decorationThickness: 3.2,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }

                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
            MaterialButton(
              onPressed: () {
                TaskModel taskModel =
                    TaskModel(taskName: "taskName", createdDate: DateTime.now().toIso8601String(), lastChangeDate: DateTime.now().toIso8601String());
                StrApiService.addTask(taskModel, data);
              },
              child: const Text("LOAD DATA"),
            )
          ],
        ),
      ),
    );
  }
}
