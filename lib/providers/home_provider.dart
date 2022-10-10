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
