import 'package:softify/model/TopicResponse.dart';
import 'package:softify/networking/ApiBaseHelper.dart';
import 'package:softify/networking/Endpoints.dart';

class TopicRepository {
  ApiBaseHelper _helper = ApiBaseHelper();

  Future<TopicResponse> fetchTopicBySystemName(String systemName) async {
    final response =
        await _helper.get('${Endpoints.topicBySystemName}/$systemName');
    return TopicResponse.fromJson(response);
  }

  Future<TopicResponse> fetchTopicById(num topicId) async {
    final response = await _helper.get('${Endpoints.topicById}/$topicId');
    return TopicResponse.fromJson(response);
  }
}
