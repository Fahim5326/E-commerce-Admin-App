import 'package:ecom_admin/auth/auth_service.dart';
import 'package:ecom_admin/customwidegets/dashboard_item_view.dart';
import 'package:ecom_admin/models/dashboard_item.dart';
import 'package:ecom_admin/pages/launcher_screen.dart';
import 'package:ecom_admin/providers/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatelessWidget {
  static const String routeName = '/dashboard';

  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<ProductProvider>(context, listen: false).getAllCategories();
    Provider.of<ProductProvider>(context, listen: false).getAllProducts();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          IconButton(
              onPressed: () {
                AuthService.logout().then((value) =>
                    Navigator.pushReplacementNamed(context, LauncherScreen.routeName));
              }, 
              icon: const Icon(Icons.logout),
          )
        ],
      ),
      body: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
          ),
          itemCount: DashboardItem.dashboardItemList.length,
          itemBuilder: (context, index) {
            final item = DashboardItem.dashboardItemList[index];
            return DashboardItemView(item: item);
          },
      ),
    );
  }
}
