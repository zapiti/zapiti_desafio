import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:zapiti_desafio/app/app_module.dart';
import 'package:zapiti_desafio/app/modules/home/modules/chat/chat_bloc.dart';
import 'package:zapiti_desafio/app/modules/home/modules/chat/chat_module.dart';

void main() {
  Modular.init(AppModule());
  Modular.bindModule(ChatModule());
  ChatBloc bloc;

  // setUp(() {
  //     bloc = ChatModule.to.get<ChatBloc>();
  // });

  // group('ChatBloc Test', () {
  //   test("First Test", () {
  //     expect(bloc, isInstanceOf<ChatBloc>());
  //   });
  // });
}
