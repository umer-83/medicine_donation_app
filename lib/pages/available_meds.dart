import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../widgets/med_card.dart';

class AvailableMeds extends StatefulWidget {
  const AvailableMeds({Key? key}) : super(key: key);

  @override
  State<AvailableMeds> createState() => _AvailableMedsState();
}

class _AvailableMedsState extends State<AvailableMeds> {
  Stream medsStream = FirebaseFirestore.instance
      .collection('meds')
      .where("avail", isEqualTo: true)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
       
         return false; 
       },
      child: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: const [
                    Text(
                      'Grab free medicine here!',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            String searchKey = value;
                            medsStream = FirebaseFirestore.instance
                                .collection('meds')
                                .where('med_name',
                                    isGreaterThanOrEqualTo: searchKey)
                                .where('med_name', isLessThan: searchKey + 'z')
                                //.where('avail', isEqualTo: true)
                                .snapshots();
                          });
                        },
                        style: const TextStyle(fontSize: 13),
                        // ignore: prefer_const_constructors
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                          hintText: 'Search for Medicine',
                          border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide:
                                  const BorderSide(color: Colors.blue, width: 2)),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: MedCard(medsStream),
                  // child: availableMedicine(medsStream),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}