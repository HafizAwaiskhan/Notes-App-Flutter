import 'dart:convert';

MemesModel memesModelFromJson(String str) => MemesModel.fromJson(json.decode(str));

String memesModelToJson(MemesModel data) => json.encode(data.toJson());

class MemesModel {
    MemesModel({
        required this.count,
        required this.memes,
    });

    int count;
    List<Meme> memes;

    factory MemesModel.fromJson(Map<dynamic, dynamic> json) => MemesModel(
        count: json["count"],
        memes: List<Meme>.from(json["memes"].map((x) => Meme.fromJson(x))),
    );

    Map<dynamic, dynamic> toJson() => {
        "count": count,
        "memes": List<dynamic>.from(memes.map((x) => x.toJson())),
    };
}

class Meme {
    Meme({
        required this.preview,
        required this.postLink,
        required this.nsfw,
        required this.author,
        required this.ups,
        required this.spoiler,
        required this.title,
        required this.subreddit,
        required this.url,
    });

    List<String> preview;
    String postLink;
    bool nsfw;
    String author;
    int ups;
    bool spoiler;
    String title;
    String subreddit;
    String url;

    factory Meme.fromJson(Map<dynamic, dynamic> json) => Meme(
        preview: List<String>.from(json["preview"].map((x) => x)),
        postLink: json["postLink"],
        nsfw: json["nsfw"],
        author: json["author"],
        ups: json["ups"],
        spoiler: json["spoiler"],
        title: json["title"],
        subreddit: json["subreddit"],
        url: json["url"],
    );

    Map<dynamic, dynamic> toJson() => {
        "preview": List<dynamic>.from(preview.map((x) => x)),
        "postLink": postLink,
        "nsfw": nsfw,
        "author": author,
        "ups": ups,
        "spoiler": spoiler,
        "title": title,
        "subreddit": subreddit,
        "url": url,
    };
}
