import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';

class CronometerScreen extends StatefulWidget {
  const CronometerScreen({Key? key}) : super(key: key);

  @override
  State<CronometerScreen> createState() => ConometerScreenState();
}

class ConometerScreenState extends State<CronometerScreen> {
  late String compra;
  late String venta;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    const String _compra = '3.9580';
    const String _venta = '3.9980';
    /////
    setState(() {
      compra = _compra;
      venta = _venta;
    });

    await HomeWidget.saveWidgetData<String>('compra', _compra);
    await HomeWidget.saveWidgetData<String>('venta', _venta);
    await HomeWidget.updateWidget(
      name: 'AppWidgetProvider',
      iOSName: 'HomeWidget',
    );
    final dataGuardada = await HomeWidget.getWidgetData<String>('venta');
    print('DATA GUARDADA $dataGuardada');
  }

  Future<void> updateAppWidgetV1() async {
    // DATA NUEVA
    const String _compra = '3.5445';
    const String _venta = '3.9585';

    setState(() {
      compra = _compra;
      venta = _venta;
    });
    await HomeWidget.saveWidgetData<String>('compra', _compra);
    await HomeWidget.saveWidgetData<String>('venta', _venta);
    await HomeWidget.updateWidget(
      name: 'AppWidgetProvider',
      iOSName: 'HomeWidget',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Rextie',
                style: Theme.of(context).textTheme.headline4?.copyWith(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              Text(
                'Cambia dólares y soles online con el mejor tipo de cambio',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6?.copyWith(
                      color: Colors.blue,
                      fontWeight: FontWeight.w400,
                    ),
              ),
              const SizedBox(height: 20),
              Text(
                'Compra: $compra',
                style: Theme.of(context).textTheme.headline6?.copyWith(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 5),
              Text(
                'Venta: $venta',
                style: Theme.of(context).textTheme.headline6?.copyWith(
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 20),
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                color: Colors.blue,
                height: 50,
                onPressed: updateAppWidgetV1,
                child: Text(
                  'Actualizar Tipo de Cambio',
                  style: Theme.of(context).textTheme.headline6?.copyWith(
                        color: Colors.white,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
