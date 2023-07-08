import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_infromation_bloc/model/UserModel.dart';
import 'package:user_infromation_bloc/viewModel/GetUserInformation.dart';
import 'package:user_infromation_bloc/viewModel/LoadedState.dart';
import 'package:user_infromation_bloc/viewModel/LoadingEvent.dart';
import 'package:user_infromation_bloc/viewModel/UserBlocService.dart';
import 'package:user_infromation_bloc/views/UserListPage.dart';

class UserDetailsPage extends StatelessWidget {
  UserDetailsPage({super.key, required this.userID});
  int userID;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserBlocService>(
          create: (BuildContext context) => UserBlocService.details(GetUserInformation(),userID),
        ),
      ],
      child: WillPopScope(
        onWillPop: () => launchPreviousPage(context,const UserListPage()),
        child: Scaffold(
          // appBar: AppBar(title: const Text('User List')),
          body: userListWidget(),
        ),
      ),
    );
  }


  launchPreviousPage(BuildContext context, Widget builder) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => builder));
  }

  Widget userListWidget() {
    return BlocProvider(
      create: (context) => UserBlocService.details(
        GetUserInformation(),userID
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
          if (state is UserLoadedObjectState) {
            UserModel userList = state.users;
            return userDetailsWidget(context,userList);
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

  Widget userDetailsWidget(BuildContext context, UserModel userModel){
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: const BoxDecoration(
        color: Colors.white
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: MediaQuery.of(context).size.height * 0.25),
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.purple, Colors.blue],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white, width: 10)
                ),
              ),
              Positioned(
                bottom: 0,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.4,
                      width: MediaQuery.of(context).size.width * 0.7,
                      margin: const EdgeInsets.fromLTRB(20, 55, 20, 0),
                      padding: const EdgeInsets.only(top: 65),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.black12,width: 5),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          setTextWidget('${userModel.firstName} ${userModel.lastName}', Colors.black, Icons.person, Colors.deepPurple, 10),
                          setDividerLine(),
                          setTextWidget('${userModel.email}', Colors.black, Icons.email_outlined, Colors.deepPurple, 10),
                          setDividerLine(),
                          setTextWidget('17-05-1999', Colors.black, Icons.calendar_month_sharp, Colors.deepPurple, 10),
                          setDividerLine(),
                          setTextWidget('0000000${userModel.id}', Colors.black, Icons.person_pin_outlined, Colors.deepPurple, 10),
                        ],
                      ),
                    ),
                    Positioned(
                      top: -0,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white,width: 5),
                            borderRadius: BorderRadius.circular(75)
                        ),
                        child: CircleAvatar(
                          maxRadius: 55,
                          backgroundImage: NetworkImage(
                              userModel.avatar.toString()),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.65,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            margin: const EdgeInsets.symmetric(vertical: 0, horizontal: 30),
            decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.purple, Colors.blue],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
                borderRadius: BorderRadius.circular(25)
            ),
            child: setTextWidget('Edit Profile', Colors.white, Icons.mode_edit_outlined, Colors.white, 0),
          ),
          GestureDetector(
            onTap: () {
              launchPreviousPage(context, const UserListPage());
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Colors.purple, Colors.blue],
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                  ),
                  borderRadius: BorderRadius.circular(25)
              ),
              child: setTextWidget('Back To Home', Colors.white, Icons.arrow_back, Colors.white, 0),
            ),
          ),
        ],
      ),
    );
  }

  Widget setDividerLine() {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.black12,
            width: 1.5,
          ),
        )
      ),
    );
  }

  Widget setTextWidget(String text,Color color, IconData icon,Color iconColor, double padding) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:  [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Icon(
              icon,
              color: iconColor,
            ),
          ),
          Text(
              text, style: TextStyle(color: color, fontWeight: FontWeight.w700),
              textAlign: TextAlign.center
          ),
        ],
      ),
    );
  }
}