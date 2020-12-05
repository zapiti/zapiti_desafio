


import 'package:flutter/material.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:intl/intl.dart';

import 'package:transparent_image/transparent_image.dart';
import 'package:zapiti_desafio/app/component/chat/models/chat_message.dart';

/// MessageContainer é apenas um wrapper em torno de [Texto], [Imagem]
/// componente para apresentar a mensagem
class MessageContainer extends StatelessWidget {
  /// Objeto de mensagem que será renderizado
  /// Pega um objeto [ChatMessage]
  final ChatMessage message;

  /// [DateFormat] objeto para renderizar a data desejada
  /// formato, se nenhum formato for fornecido, ele usa
  /// o padrão `HH: mm: ss`
  final DateFormat timeFormat;

  /// [messageTextBuilder] função assume uma função com este
  /// estrutura [Widget Function (String)] para renderizar o texto dentro
  /// o contêiner.
  final Widget Function(String, [ChatMessage]) messageTextBuilder;

  /// [messageImageBuilder] assume uma função com este
  /// estrutura [Widget Function (String)] para renderizar a imagem dentro
  /// o contêiner.
  final Widget Function(String, [ChatMessage]) messageImageBuilder;

  /// [messageTimeBuilder] função assume uma função com este
  /// estrutura [Widget Function (String)] para renderizar o texto da hora dentro
  /// o contêiner.
  final Widget Function(String, [ChatMessage]) messageTimeBuilder;

  /// Fornece um estilo personalizado para o contêiner de mensagem
  /// leva [BoxDecoration]
  final BoxDecoration messageContainerDecoration;

  /// Usado para analisar texto para torná-lo uso de texto vinculado
  /// [flutter_parsed_text] (https://pub.dev/packages/flutter_parsed_text)
  /// obtém uma lista de [MatchText] para analisar e-mail, telefone, links
  /// e também pode adicionar padrões personalizados usando regex
  final List<MatchText> parsePatterns;

  /// Uma bandeira que é usada para atribuir estilos
  final bool isUser;

  /// Fornece uma lista de botões para permitir o uso de adicionar botões para
  /// parte inferior da mensagem
  final List<Widget> buttons;


  /// [messageButtonsBuilder] assume uma função com este
  /// estrutura [List <Widget> Function ()] para renderizar os botões dentro
  /// uma fila.
  final List<Widget> Function(ChatMessage) messageButtonsBuilder;

  /// Restrição a ser usada para construir o layout da mensagem
  final BoxConstraints constraints;


  /// Preenchimento da mensagem
  /// Padrão para EdgeInsets.all (8.0)
  final EdgeInsets messagePadding;

  /// Deve mostrar o texto antes da imagem no balão do chat
  /// ou o oposto
  /// Padrão para `true`
  final bool textBeforeImage;

  /// substitui a caixa de decoração da mensagem
  /// pode ser usado para substituir a cor ou personalizar o recipiente da mensagem
  /// params [ChatMessage] e [isUser]: boolean
  /// return BoxDecoration
  final BoxDecoration Function(ChatMessage, bool) messageDecorationBuilder;

  const MessageContainer({
    @required this.message,
    @required this.timeFormat,
    this.constraints,
    this.messageImageBuilder,
    this.messageTextBuilder,
    this.messageTimeBuilder,
    this.messageContainerDecoration,
    this.parsePatterns = const <MatchText>[],
    this.textBeforeImage = true,
    this.isUser,
    this.messageButtonsBuilder,
    this.buttons,
    this.messagePadding = const EdgeInsets.all(8.0),
    this.messageDecorationBuilder,
  });

  @override
  Widget build(BuildContext context) {
    final constraints = this.constraints ??
        BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height,
            maxWidth: MediaQuery.of(context).size.width);
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: constraints.maxWidth * 0.8,
      ),
      child: Container(
        decoration: messageDecorationBuilder != null
            ? messageDecorationBuilder(message, isUser)
            : messageContainerDecoration != null
                ? messageContainerDecoration.copyWith(
                    color: message.user.containerColor != null
                        ? message.user.containerColor
                        : messageContainerDecoration.color,
                  )
                : BoxDecoration(
                    color: message.user.containerColor != null
                        ? message.user.containerColor
                        : isUser
                            ? Theme.of(context).accentColor
                            : Color.fromRGBO(225, 225, 225, 1),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
        margin: EdgeInsets.only(
          bottom: 5.0,
        ),
        padding: messagePadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment:
              isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: <Widget>[
            if (this.textBeforeImage)
              _buildMessageText()
            else
              _buildMessageImage(),
            if (this.textBeforeImage)
              _buildMessageImage()
            else
              _buildMessageText(),
            if (buttons != null)
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment:
                    isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: buttons,
              )
            else if (messageButtonsBuilder != null)
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment:
                    isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
                children: messageButtonsBuilder(message),
                mainAxisSize: MainAxisSize.min,
              ),
            if (messageTimeBuilder != null)
              messageTimeBuilder(
                timeFormat != null
                    ? timeFormat.format(message.createdAt)
                    : DateFormat('HH:mm:ss').format(message.createdAt),
                message,
              )
            else
              Padding(
                padding: EdgeInsets.only(top: 5.0),
                child: Text(
                  timeFormat != null
                      ? timeFormat.format(message.createdAt)
                      : DateFormat('HH:mm:ss').format(message.createdAt),
                  style: TextStyle(
                    fontSize: 10.0,
                    color: message.user.color != null
                        ? message.user.color
                        : isUser ? Colors.white70 : Colors.black87,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget _buildMessageText() {
    if (messageTextBuilder != null)
      return messageTextBuilder(message.text, message);
    else
      return ParsedText(
        parse: parsePatterns,
        text: message.text,
        style: TextStyle(
          color: message.user.color != null
              ? message.user.color
              : isUser ? Colors.white70 : Colors.black87,
        ),
      );
  }

  Widget _buildMessageImage() {
    if (message.image != null) {
      if (messageImageBuilder != null)
        return messageImageBuilder(message.image, message);
      else
        return Padding(
          padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: FadeInImage.memoryNetwork(
            height: constraints.maxHeight * 0.3,
            width: constraints.maxWidth * 0.7,
            fit: BoxFit.contain,
            placeholder: kTransparentImage,
            image: message.image,
          ),
        );
    }
    return Container(width: 0, height: 0);
  }
}
