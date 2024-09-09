import 'package:flutter/material.dart';

import '../../components/common_button.dart';
import '../../helper/colors_helper.dart';
import '../../helper/dimensn_helper.dart';
import '../../helper/font_helper.dart';
import '../../helper/string_helper.dart';
import '../../networkManager/repository.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController jobController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorsHelper.primaryColor,
        title: const Text(StringHelper.logIn),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            top: DimensnHelper.dimensn_20,
            left: DimensnHelper.dimensn_20,
            right: DimensnHelper.dimensn_20),
        child: Column(
          children: [
            TextFormField(
              controller: nameController,
              decoration:
                  const InputDecoration(hintText: StringHelper.enterName),
            ),
            const SizedBox(
              height: DimensnHelper.dimensn_10,
            ),
            TextFormField(
              controller: jobController,
              decoration:
                  const InputDecoration(hintText: StringHelper.enterJob),
            ),
            const SizedBox(
              height: DimensnHelper.dimensn_20,
            ),
            CommonButton(
              onPress: () {
                setState(() {
                  loading=true;
                });
                Map parems = {
                  "name": nameController.text,
                  "job":jobController.text

                };
                // Repository().responseInMap(parems).then((value){
                //   print('ID===>${value.id}');
                //   setState(() {
                //     loading=false;
                //   });
                // }).onError((error,stactTrace){
                //   print('ERROR===>${error..toString()}');
                // });

              },
              child: const Text(
                StringHelper.logIn,
                style: TextStyle(
                    color: ColorsHelper.whiteColor,
                    fontSize: FontHelper.dimensn_20
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
