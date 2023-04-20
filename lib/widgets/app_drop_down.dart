import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/helpers/constants.dart';
import 'package:flutter_chatgpt/models/models_response.dart';
import 'package:flutter_chatgpt/provider/models_provider.dart';
import 'package:flutter_chatgpt/services/api_services.dart';
import 'package:provider/provider.dart';

class AppDropDown extends StatefulWidget {
  const AppDropDown({super.key});

  @override
  State<AppDropDown> createState() => _AppDropDownState();
}

class _AppDropDownState extends State<AppDropDown> {
  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    final modelsProvider = Provider.of<ModelsProvider>(context, listen: false);
    selectedItem = modelsProvider.getCurrentModel;

    return FutureBuilder(
      future: modelsProvider.getAllModels(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        return snapshot.data == null || snapshot.data!.isEmpty
            ? const SizedBox.shrink()
            : DropdownButton(
                value: selectedItem,
                dropdownColor: scaffoldBackgroundColor,
                iconEnabledColor: Colors.white,
                items: _getItemList(snapshot.data),
                onChanged: (value) {
                  setState(() {
                    selectedItem = value.toString();
                  });
                  modelsProvider.setCurrentModel(
                      newModel: selectedItem.toString());
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
