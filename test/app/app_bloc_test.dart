import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_mocks/cloud_firestore_mocks.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uuid/uuid.dart';
import 'package:zapiti_desafio/app/modules/home/modules/init/model/message.dart';
import 'package:zapiti_desafio/app/modules/home/modules/init/model/news.dart';
import 'package:zapiti_desafio/app/modules/home/modules/init/model/user.dart';
import 'package:zapiti_desafio/app/teste/my_teste_page.dart';
import 'package:zapiti_desafio/app/utils/date_utils.dart';

const MessagesCollection = 'messages';

void main() {
  testWidgets('Mostrar mensagem', (WidgetTester tester) async {
    // Populate the mock database.
    final firestore = MockFirestoreInstance();
    await firestore.collection(MessagesCollection).add({
      'id': Uuid().v4(),
      'user': null,
      'message': {"content":"Teste"},
      'date':null,
    });

    // Render the widget.
    await tester.pumpWidget(MaterialApp(
        title: 'Exemplo de teste', home: MyTestePage(firestore: firestore)));
    // Let the snapshots stream fire a snapshot.
    await tester.idle();
    // Re-render.
    await tester.pump();
    // // Verify the output.
    print(findsOneWidget);

    expect(find.text('message'), findsOneWidget);
  });

  testWidgets('Teste de adicionar mensagem', (WidgetTester tester) async {
    // Instantiate the mock database.
    final firestore = MockFirestoreInstance();

    // Render the widget.
    await tester.pumpWidget(MaterialApp(
        title: 'Teste de adicionar mensagem', home: MyTestePage(firestore: firestore)));
    // Verify that there is no data.
    expect(find.text('Ola avaliador'), findsNothing);

    // Tap the Add button.
    await tester.tap(find.byType(FloatingActionButton));
    // Let the snapshots stream fire a snapshot.
    await tester.idle();
    // Re-render.
    await tester.pump();

    // Verify the output.
    expect(find.text('Ola avaliado'), findsOneWidget);
  });
}
