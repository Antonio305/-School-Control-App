

// // To parse this JSON data, do
// //
// //     final usersResponse = usersResponseFromJson(jsonString);

// import 'dart:convert';


// UsersResponse usersResponseFromJson(String str) => UsersResponse.fromJson(json.decode(str));

// String usersResponseToJson(UsersResponse data) => json.encode(data.toJson());

// class UsersResponse {
//     bool ok;
//     List<User> user;

//     UsersResponse({
//         required this.ok,
//         required this.user,
//     });

//     factory UsersResponse.fromJson(Map<String, dynamic> json) => UsersResponse(
//         ok: json["ok"],
//         user: List<User>.from(json["user"].map((x) => User.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "ok": ok,
//         "user": List<dynamic>.from(user.map((x) => x.toJson())),
//     };
// }
