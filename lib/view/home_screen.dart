import 'package:flutter/material.dart';
import 'package:mvvm/data/response/status.dart';
import 'package:mvvm/repository/auth_repository.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view_model/auth_view_model.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final userPrefrence = Provider.of<UserViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('TEXT'),
        actions: [
          IconButton(
            onPressed: () {
              userPrefrence.remove().then((value) {
                Navigator.pushNamed(context, RoutesName.login);
              });
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Consumer<AuthViewModel>(
        builder: (context, userData, child) {
          switch (userData.userData.status) {
            case Status.LOGING:
              return Center(child: CircularProgressIndicator());
            case Status.ERROR:
              return Center(child: Text(userData.userData.message.toString()));
            case Status.COMPLATED:
              return ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(userData.userData.data!.data!.first.firstName
                        .toString()),
                  );
                },
                itemCount: userData.userData.data?.data?.length,
              );

            default:
          }

          return Container();
        },
      ),
    );
  }
}
