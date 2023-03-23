import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MedicineRequestStatus extends StatefulWidget {
  final DocumentSnapshot documentSnapshot;

  const MedicineRequestStatus({
    Key? key,
    required this.documentSnapshot,
  }) : super(key: key);

  @override
  _MedicineRequestStatusState createState() => _MedicineRequestStatusState();
}

class _MedicineRequestStatusState extends State<MedicineRequestStatus> {
  @override
  Widget build(BuildContext context) {
    var docId = widget.documentSnapshot.reference.id.toString();

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: const Color(0xff8C52FF),
          title: const Text(
            'Camp Status ',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          elevation: 4,
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 50),
                    const Text("Change Med Request Status",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 15),
                    const Text(
                        'Press this button if you have got the desired medicine which you have requested, Its time to make it unavailable from inprogress medicine request list',
                        maxLines: 5,
                        style: TextStyle(fontSize: 16)),
                    const SizedBox(height: 15),
                    widget.documentSnapshot['avail'] == true
                        ? Container(
                            width: double.maxFinite,
                            height: 50,
                            child: ElevatedButton(
                                style: ButtonStyle(
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
                                            const EdgeInsets.all(10)),
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            const Color(0xff8C52FF)),
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30.0),
                                            side: const BorderSide(
                                                color: Color(0xff8C52FF))))),
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection('medsreq')
                                      .doc(docId)
                                      .update({'avail': false});
                                },
                                child: const Text(
                                  'Press!',
                                  style: TextStyle(fontSize: 20),
                                )),
                          )
                        : const Center(
                            child: Text(
                              'Thank you for updating medicine request status!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 22,
                                color: Color(0xff8C52FF),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
