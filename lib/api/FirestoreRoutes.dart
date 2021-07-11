import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

CollectionReference routes = FirebaseFirestore.instance.collection('routes');
CollectionReference chat = FirebaseFirestore.instance.collection('chat');
CollectionReference passengers =
    FirebaseFirestore.instance.collection('passengers');

String imageUrl = 'void';
String passengerName = 'void';
String passengerId = 'void';
String cpf = 'void';

Future<String> _loadCurrentUser() async {
  final _auth = FirebaseAuth.instance;

  final currentUser = _auth.currentUser;

  return currentUser!.uid;
}

Future<void> getMyInfo() async {
  passengerId = await _loadCurrentUser();

  await passengers.doc(passengerId).get().then((value) {
    passengerName = value["name"];
    imageUrl = value["imageUrl"];
    cpf = value["cpf"];
  });
}

Future<String> addMeToRoute(routeId, myAddress) async {
  List passengersList = await getPassengerList(routeId);

  await getMyInfo();

  if (passengersList.length < 4) {
    passengersList.add({
      "myAddress": myAddress,
      "imageUrl": imageUrl,
      "name": passengerName,
      "uid": passengerId,
      "cpf": cpf,
    });

    try {
      await routes.doc(routeId).update({'passengersList': passengersList});

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
