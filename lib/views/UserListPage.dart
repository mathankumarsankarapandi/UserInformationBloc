import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_infromation_bloc/model/UserModel.dart';
import 'package:user_infromation_bloc/viewModel/GetUserInformation.dart';
import 'package:user_infromation_bloc/viewModel/LoadedState.dart';
import 'package:user_infromation_bloc/viewModel/LoadingEvent.dart';
import 'package:user_infromation_bloc/viewModel/UserBlocService.dart';
import 'package:user_infromation_bloc/views/UserDetailsPage.dart';


class UserListPage extends StatelessWidget {
  const UserListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBlocService>(
          create: (BuildContext context) => UserBlocService(GetUserInformation(), 0),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blue,
            centerTitle: true,
            title: const Text('Users')),
        body: userListWidget(),
      ),
    );
  }

  Widget userListWidget() {
    return BlocProvider(
      create: (context) => UserBlocService(
        GetUserInformation(),0
      )..add(LoadingEvent()),
      child: BlocBuilder<UserBlocService, UserState>(
        builder: (context, state) {
          if (state is UserLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.deepPurple,
              ),
            );
          }
          if (state is UserLoadedListState) {
            List<UserModel> userList = state.users;
            return userListViewWidget(context, userList);
          }
          if (state is UserErrorState) {
            return const Center(
              child: Text("Error"),
            );
          }
          return Container();
        },
      ),
    );

  }

  Widget userListViewWidget(BuildContext context, List<UserModel> userModelList) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purple, Colors.blue],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: ListView.builder(
          itemCount: userModelList.length,
          itemBuilder: (BuildContext, index) {
            return GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => UserDetailsPage(userID: userModelList[index].id ?? 0)));
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                  decoration:  BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Colors.purple, Colors.blue],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border: Border.all(color: Colors.white,width: 2),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: ListTile(
                      title: Text(
                        '${userModelList[index].firstName}  ${userModelList[index].lastName}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      subtitle: Text(
                        '${userModelList[index].email}',
                        style: const TextStyle(color: Colors.white),
                      ),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                            userModelList[index].avatar.toString()),
                      ))),
            );
          }),
    );
  }
}