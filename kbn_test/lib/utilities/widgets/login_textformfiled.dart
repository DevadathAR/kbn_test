import 'package:flutter/material.dart';
import 'package:kbn_test/utilities/colors.dart';

Widget LoginTextForm({label, hintlabel,numb=1,controller}) {
  return Column(
    children: [
      TextFormField(maxLines: numb,
      controller: controller,
    
        decoration: InputDecoration(
          
            label: Text(label),
            hintText: hintlabel,
            border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(4),
                ),
                borderSide: BorderSide(width: .4, color: black)),
                filled: true,
            fillColor: logintextbox),
      ),
            SizedBox(height: 20,)

    ],
  );
}
