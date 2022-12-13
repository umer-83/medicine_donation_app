import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medicine_donation_app/widgets/medicine_donation_camp_card.dart';

class InProgressDonationCamps extends StatefulWidget {
  const InProgressDonationCamps({Key? key}) : super(key: key);

  @override
  State<InProgressDonationCamps> createState() =>
      _InProgressDonationCampsState();
}

class _InProgressDonationCampsState extends State<InProgressDonationCamps> {
  Stream medsStream =
      FirebaseFirestore.instance.collection('medcamp').snapshots();
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
                    // Icon(
                    //   Icons.chevron_right,
                    //   size: 30,
                    //   color: Color(0xff8C52FF),
                    // ),
                    Text(
                      'Medicines Request List',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Divider(
                  height: 1.5,
                  color: Colors.grey.shade900,
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: MedDonCard(medsStream),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget MedDonCard(medsStream) {
  return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
    stream: medsStream,
    builder: (BuildContext context, snapshot) {
      if (snapshot.hasError) {
        print('Something went Wrong');
      }
      if (snapshot.data == null) {
        print('yo');
      }
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      return ListView.builder(
        itemCount: snapshot.data?.docs.length,
        itemBuilder: (context, index) {
          final DocumentSnapshot documentSnap = snapshot.data!.docs[index];

          return (MedicineDonationCampCard(
            orgName: documentSnap['name'].toString(),
            address: documentSnap['address'].toString(),
            contactNumber: documentSnap['phone'].toString(),
            description: documentSnap['desc'].toString(),
          ));
        },
      );
    },
  );
}
