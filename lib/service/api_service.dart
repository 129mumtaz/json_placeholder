import 'package:http/http.dart' as http;
import 'package:json_placehlder/model/albums.dart';
import 'package:json_placehlder/model/comments.dart';
import 'package:json_placehlder/model/photos.dart';
import 'package:json_placehlder/model/posts.dart';
import 'package:json_placehlder/model/todos.dart';
import 'package:json_placehlder/model/users.dart';

class ApiService {
  static const String baseURL = 'https://jsonplaceholder.typicode.com/';

  static Future<List<Posts>> fetchPosts() async {
    final response = await http.get(Uri.parse('${baseURL}posts'));
    if (response.statusCode == 200) { 
      return postsFromJson(response.body);
    } else {
      throw Exception('Failed to load posts');
    }
  }

  static Future<List<Comments>> fetchComments() async {
    final response = await http.get(Uri.parse('${baseURL}comments'));
    if (response.statusCode == 200) {
      return commentsFromJson(response.body);
    } else {
      throw Exception('Failed to load comments');
    }
  }

  static Future<List<Albums>> fetchAlbums() async {
    final response = await http.get(Uri.parse('${baseURL}albums'));
    if (response.statusCode == 200) {
      return albumsFromJson(response.body);
    } else {
      throw Exception('Failed to load albums');
    }
  }

  static Future<List<Photos>> fetchPhotos() async {
    final response = await http.get(Uri.parse('${baseURL}photos'));
    if (response.statusCode == 200) {
      return photosFromJson(response.body);
    } else {
      throw Exception('Failed to load photos');
    }
  }

  static Future<List<Photos>> fetchPhotosByAlbum(int albumId) async {
    final response = await http.get(Uri.parse('${baseURL}photos?albumId=$albumId'));
    if (response.statusCode == 200) {
      return photosFromJson(response.body);
    } else {
      throw Exception('Failed to load photos');
    }
  }

  static Future<List<Todos>> fetchTodos() async {
    final response = await http.get(Uri.parse('${baseURL}todos'));
    if (response.statusCode == 200) {
      return todosFromJson(response.body);
    } else {
      throw Exception('Failed to load todos');
    }
  }

  static Future<List<Users>> fetchUsers() async {
    final response = await http.get(Uri.parse('${baseURL}users'));
    if (response.statusCode == 200) {
      return usersFromJson(response.body);
    } else {
      throw Exception('Failed to load users');
    }
  }
}
