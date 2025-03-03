// Move existing model classes here 

class Template {
  final Trigger trigger;
  final Content content;
  final String id;
  final String name;
  final String type;
  final String position;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  Template({
    required this.trigger,
    required this.content,
    required this.id,
    required this.name,
    required this.type,
    required this.position,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Template.fromJson(Map<String, dynamic> json) {
    return Template(
      trigger: Trigger.fromJson(json['trigger']),
      content: Content.fromJson(json['content']),
      id: json['_id'],
      name: json['name'],
      type: json['type'],
      position: json['position'],
      isActive: json['isActive'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }
}

class Trigger {
  final String type;
  final String screenName;

  Trigger({required this.type, required this.screenName});

  factory Trigger.fromJson(Map<String, dynamic> json) {
    return Trigger(
      type: json['type'],
      screenName: json['screenName'] ?? '',
    );
  }
}

class Content {
  final String type;
  final dynamic data;
  final List<CarouselItem>? carouselItems;

  Content({
    required this.type, 
    required this.data,
    this.carouselItems,
  });

  factory Content.fromJson(Map<String, dynamic> json) {
    List<CarouselItem>? carouselItems;
    if (json['type'] == 'carousel' && json['carouselItems'] != null) {
      carouselItems = (json['carouselItems'] as List)
          .map((item) => CarouselItem.fromJson(item))
          .toList();
    }

    return Content(
      type: json['type'],
      data: json['data'],
      carouselItems: carouselItems,
    );
  }

  bool get isImage => type == 'image';
  bool get isHtml => type == 'html';
  bool get isCarousel => type == 'carousel';
}

class CarouselItem {
  final String type;
  final String data;

  CarouselItem({
    required this.type,
    required this.data,
  });

  factory CarouselItem.fromJson(Map<String, dynamic> json) {
    return CarouselItem(
      type: json['type'],
      data: json['data'],
    );
  }

  bool get isImage => type == 'image';
  bool get isHtml => type == 'html';
} 