import 'package:fish_redux/fish_redux.dart';
import 'package:flutter/material.dart';

import 'action.dart';
import 'state.dart';

Widget buildView(DetailPageState state, Dispatch dispatch, ViewService viewService) {
  return Scaffold(
      backgroundColor: Colors.black38,
      body: Column(
        children: [
          GestureDetector(onTap: () => Navigator.of(viewService.context).pop(), child: Container(height: 100, color: Colors.transparent)),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                color: Theme.of(viewService.context).scaffoldBackgroundColor,
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(viewService.context).pop(),
                    child: Container(
                      height: 20,
                      width: double.infinity,
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(width: 60, height: 3, decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(10))),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ));
}
