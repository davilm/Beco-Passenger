import 'package:cloud_firestore/cloud_firestore.dart';

CollectionReference routes = FirebaseFirestore.instance.collection('routes');
CollectionReference chat = FirebaseFirestore.instance.collection('chat');

String driverUid = "pNKw0MEwouc2ajzaXeYd";
String passengerUid = "JIbVoYwhRGVQs5AaEuOOBDBQU3J2";

Future<String> addMeToRoute(routeId) async {
  List passengersQuantity = await getPassengerList(routeId);

  if (passengersQuantity.length < 4) {
    passengersQuantity.add({"teste": "deu certo"});

    try {
      await routes.doc(routeId).update({'passengersList': passengersQuantity});

      return 'sucesso';
    } catch (e) {
      return 'Ocorreu um erro: $e';
    }
  }
  return 'esgotado';
}

Future<List> getPassengerList(routeId) async {
  List myList = [];
  try {
    await routes
        .doc(routeId)
        .get()
        .then((value) => {
              myList = value['passengersList'],
            })
        .catchError((onError) {
      print("Adding first passenger");
    });
    return myList;
  } catch (e) {
    return myList;
  }
}
