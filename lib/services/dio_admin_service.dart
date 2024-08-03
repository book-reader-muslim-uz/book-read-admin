import 'package:dio/dio.dart';
import 'package:read_pdf/core/network/dio_client.dart';
import 'package:read_pdf/models/admin_model.dart';
import 'package:bcrypt/bcrypt.dart';

class DioAdminService {
  final _dioClient = DioClient();

  Future<List<AdminModel>> getAdmins() async {
    try {
      final response = await _dioClient.get(url: "/admins.json");

      final Map<String, dynamic> data = response.data;

      List<AdminModel> loadedData = [];

      data.forEach(
        (key, value) {
          value['id'] = key;
          loadedData.add(AdminModel.fromJson(value));
        },
      );

      // print(loadedData);

      return loadedData;
    } on DioException catch (e) {
      print("Admin dio error: $e");
      rethrow;
    } catch (e) {
      print("Catch error: $e");
      rethrow;
    }
  }

  Future<AdminModel> addAdmin(String name, String password) async {
    try {
      final hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

      Map<String, dynamic> adminData = {
        'name': name,
        'password': hashedPassword,
      };

      final response =
          await _dioClient.add(url: "/admins.json", data: adminData);

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Failed to add admin');
      }

      // print("Admin ID: ${response.data['name']}");

      adminData['id'] = response.data['name'];
      AdminModel adminModel = AdminModel.fromJson(adminData);
      return adminModel;
    } on DioException catch (e) {
      print("Dio admin add error: $e");
      rethrow;
    } catch (e) {
      print("Admin add catch error: $e");
      rethrow;
    }
  }

  Future<bool> verifyPassword(String inputPassword, String storedHash) async {
    try {
      return BCrypt.checkpw(inputPassword, storedHash);
    } catch (e) {
      print("Password verification error: $e");
      return false;
    }
  }
}

// void main(List<String> args) async {
//   DioAdminService dioAdminService = DioAdminService();

//   final res = await dioAdminService.getAdmins();

//   for (var element in res) {
//     print(element.id);
//     print(element.name);
//     print(element.password);
//   }
//   // final newAdmin = await dioAdminService.addAdmin("1", "1");

//   // print(newAdmin);

//   // final isPasswordCorrect =
//   //     await dioAdminService.verifyPassword("1", newAdmin.password);
//   // print("Password is correct: $isPasswordCorrect");
// }
