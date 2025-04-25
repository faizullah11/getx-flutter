import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_app/view_models/controllers/home/home_view_model.dart';

class UserListWidget extends StatelessWidget{

  UserListWidget({super.key});
  
  final homeViewModel = Get.put(HomeViewModel());

  
  @override
  Widget build(BuildContext context) {
      return ListView.builder(
              itemCount: homeViewModel.userListModel.value.data!.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        homeViewModel.userListModel.value.data![index].avatar
                            .toString(),
                      ),
                    ),
                    title: Text(homeViewModel.userListModel.value.data![index].firstName.toString()),
                    subtitle:Text(homeViewModel.userListModel.value.data![index].email.toString()) ,
                  ),
                );
              },
            );
  }
}