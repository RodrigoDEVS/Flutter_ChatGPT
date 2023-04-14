import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/helpers/constants.dart';
import 'package:flutter_chatgpt/models/models_response.dart';
import 'package:flutter_chatgpt/services/api_services.dart';

class AppDropDown extends StatefulWidget {
  const AppDropDown({super.key});

  @override
  State<AppDropDown> createState() => _AppDropDownState();
}

class _AppDropDownState extends State<AppDropDown> {
  String selectedItem = 'gpt-3.5-turbo';

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: ApiServices.getModels(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        return snapshot.data == null || snapshot.data!.data!.isEmpty
            ? const SizedBox.shrink()
            : DropdownButton(
                value: selectedItem,
                dropdownColor: scaffoldBackgroundColor,
                iconEnabledColor: Colors.white,
                items: _getItemList(snapshot.data?.data),
                onChanged: (value) {
                  setState(() {
                    selectedItem = value.toString();
                  });
                },
              );
      },
    );

    // return DropdownButton(
    //   value: selectedItem,
    //   dropdownColor: scaffoldBackgroundColor,
    //   iconEnabledColor: Colors.white,
    //   items: _getItemList(items),
    //   onChanged: (value) {
    //     setState(() {
    //       selectedItem = value.toString();
    //     });
    //   },
    // );
  }

  List<DropdownMenuItem<String>>? _getItemList(List<Datum>? itemList) {
    List<DropdownMenuItem<String>>? list = [];
    itemList?.forEach((element) {
      list.addAll([
        DropdownMenuItem<String>(
            value: element.id,
            child: Text(
              element.id!,
              style: const TextStyle(color: Colors.white),
            ))
      ]);
    });
    return list;
  }
}
