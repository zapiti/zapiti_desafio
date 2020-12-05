

import 'package:flutter/material.dart';


import 'package:transparent_image/transparent_image.dart';
import 'package:zapiti_desafio/app/component/chat/models/chat_user.dart';

/// Contêiner de avatar para a visualização do bate-papo usa um [CircleAvatar]
/// widget como padrão, que pode ser substituído fornecendo
 /// [avatarBuilder]
class AvatarContainer extends StatelessWidget {
  /// Um ​​objeto [ChatUser] usado para obter a url do usuário
  /// avatar
  final ChatUser user;

 /// [onPress] assume uma função com esta estrutura
  /// [Function (ChatUser)] será acionado quando o avatar
  /// está tocado
  final Function(ChatUser) onPress;

   /// [onLongPress] assume uma função com esta estrutura
  /// [Function (ChatUser)] será acionado quando o avatar
  /// é pressionado por muito tempo
  final Function(ChatUser) onLongPress;

   /// [avatarBuilder] assume uma função com esta estrutura
  /// [Função Widget (ChatUser)] para construir o avatar
  final Widget Function(ChatUser) avatarBuilder;


  final BoxConstraints constraints;

  final double avatarMaxSize;

  const AvatarContainer({
    @required this.user,
    this.onPress,
    this.onLongPress,
    this.avatarBuilder,
    this.constraints,
    this.avatarMaxSize,
  });

  @override
  Widget build(BuildContext context) {
    final constraints = this.constraints ??
        BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width);

    return GestureDetector(
      onTap: () => onPress != null ? onPress(user) : null,
      onLongPress: () => onLongPress != null ? onLongPress(user) : null,
      child: avatarBuilder != null
          ? avatarBuilder(user)
          : Stack(
              alignment: Alignment.center,
              children: <Widget>[
                ClipOval(
                  child: Container(
                    height: constraints.maxWidth * 0.08,
                    width: constraints.maxWidth * 0.08,
                    constraints: BoxConstraints(
                      maxWidth: avatarMaxSize,
                      maxHeight: avatarMaxSize,
                    ),
                    color: Colors.grey,
                    child: Center(
                        child: Text(user.name == null || user.name.isEmpty
                            ? ''
                            : user.name[0])),
                  ),
                ),
                user.avatar != null && user.avatar.length != 0
                    ? Center(
                        child: ClipOval(
                          child: FadeInImage.memoryNetwork(
                            image: user.avatar,
                            placeholder: kTransparentImage,
                            fit: BoxFit.cover,
                            height: constraints.maxWidth * 0.08,
                            width: constraints.maxWidth * 0.08,
                          ),
                        ),
                      )
                    : Container()
              ],
            ),
    );
  }
}
