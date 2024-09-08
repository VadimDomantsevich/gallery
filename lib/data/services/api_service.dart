import 'dart:convert';
import 'package:gallery_test/data/model/instruction_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  /// Get data based on [searchText] and [currentPage]
  Future<Instruction> getData({
    String? searchText,
    required int currentPage,
  }) async {
    const String apiKey = "45866912-9917e6b980d5a9235462cf1af";
    const int size = 50;

    /// Gets only photos cause of header part [&image_type=photo]
    final response = await http.get(Uri.parse(
        "https://pixabay.com/api/?key=$apiKey&q=${searchText ?? ''}&image_type=photo&page=$currentPage&per_page=$size"));
    var decodedResponse =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
    Instruction instruction = Instruction.fromJson(decodedResponse);
    return instruction;
  }
}
