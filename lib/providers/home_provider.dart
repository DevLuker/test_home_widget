import 'package:home_widget/home_widget.dart';
import 'package:intl/intl.dart';

void backgroundCallback(Uri? data) async {
  // COMUNICACIÓN CON CHANNEL ANDROID
  /* 
  if (data!.host == 'updatecounter') {    
    int _counter = 0;

    await HomeWidget.getWidgetData<int>('_counter', defaultValue: 0)
        .then((value) {
      _counter = value ?? 0;
      _counter++;
    });

    await HomeWidget.saveWidgetData<int>('_counter', _counter);
    await HomeWidget.updateWidget(
        name: 'AppWidgetProvider', iOSName: 'AppWidgetProvider');
  } */
}

Future<void> initHomeWidgetData() async {
  final time = DateFormat.Hms().add_jm().format(DateTime.now());
  final hour = time.split(' ')[1];
  final type = time.split(' ')[2];
  final hourType = '$hour $type';

  await HomeWidget.saveWidgetData<String>('buy', '3.025');
  await HomeWidget.saveWidgetData<String>('sell', '3.049');
  await HomeWidget.saveWidgetData<String>('hour', hourType);
  await HomeWidget.updateWidget(
    name: 'AppWidgetProvider',
    iOSName: 'HomeWidget',
  );
}
