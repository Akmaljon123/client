import 'dart:convert';
import 'dart:io';

class HttpService {
  static Future<String?> getData() async {
    HttpClient httpClient = HttpClient();
    try {
      Uri url = Uri.parse("https://65cbb766efec34d9ed87fe33.mockapi.io/users");
      HttpClientRequest request = await httpClient.getUrl(url);
      HttpClientResponse response = await request.close();

      if (response.statusCode == HttpStatus.ok) {
        String result = await response.transform(utf8.decoder).join();

        return result;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception("Error at $e");
    } finally {
      httpClient.close();
    }
  }

  static Future<String?> post({required Map<String, Object?> data}) async {
    HttpClient httpClient = HttpClient();

    try {
      Uri url = Uri.parse("https://65cbb766efec34d9ed87fe33.mockapi.io/users");
      HttpClientRequest request = await httpClient.postUrl(url);
      request.headers.set("Content-Type", "application/json");
      request.add(utf8.encode(jsonEncode(data)));
      HttpClientResponse response = await request.close();

      if (response.statusCode == HttpStatus.ok ||
          response.statusCode == HttpStatus.created) {
        String data = await response.transform(utf8.decoder).join();

        return data;
      } else {
        return null;
      }
    } catch (e) {
      throw Exception("Error at $e");
    } finally {
      httpClient.close();
    }
  }

  static Future<bool> put(
      {required int index, required Map<String, Object?> data}) async {
    HttpClient httpClient = HttpClient();

    try {
      Uri url = Uri.parse(
          "https://65cbb766efec34d9ed87fe33.mockapi.io/users/$index");
      HttpClientRequest request = await httpClient.putUrl(url);
      request.headers.set("Content-Type", "application/json");
      request.add(utf8.encode(jsonEncode(data)));
      HttpClientResponse response = await request.close();

      if (response.statusCode == HttpStatus.ok ||
          response.statusCode == HttpStatus.created) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception("Error at $e");
    } finally {
      httpClient.close();
    }
  }


  static Future<bool> delete({required int index}) async {
    // dart io kutubxonasidagi HttpClient classidan object olinayabdi
    HttpClient httpClient = HttpClient();

    try {
      // url yasab olinayabdi
      Uri url = Uri.parse(
          'https://65cbb766efec34d9ed87fe33.mockapi.io/users/$index');

      // delete methodi orqali so'rov jo'natilayabdi
      HttpClientRequest request = await httpClient.deleteUrl(url);


      // jo'natilgan so'rov close qilib yopilayabdi
      HttpClientResponse response = await request.close();


      String responseBody = await response.transform(utf8.decoder).join();


      if (response.statusCode == HttpStatus.noContent ||
          response.statusCode == HttpStatus.ok) {
        return true;
      } else {
        throw Exception(
            'Failed to delete resource: ${response.statusCode}, $responseBody');
      }
    } finally {
      httpClient.close();
    }


    // static Future<bool> delete({required int index})async{
    //   HttpClient httpClient = HttpClient();
    //   try{
    //     Uri url = Uri.parse("https://65cbb766efec34d9ed87fe33.mockapi.io/users/$index");
    //     HttpClientRequest request = await httpClient.deleteUrl(url);
    //     HttpClientResponse response = await request.close();
    //
    //
    //     if(response.statusCode <= 205){
    //       return true;
    //     }else{
    //       return false;
    //     }
    //   }catch (e){
    //     throw Exception("Error at $e");
    //   }finally{
    //     httpClient.close();
    //   }
    // }
  }
}