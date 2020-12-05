import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_parsed_text/flutter_parsed_text.dart';
import 'package:intl/intl.dart';

import 'chat_input_toolbar.dart';
import 'message_listview.dart';
import 'models/chat_message.dart';
import 'models/chat_user.dart';
import 'models/reply.dart';
import 'models/scroll_to_bottom_style.dart';
import 'widgets/quick_reply.dart';
import 'widgets/scroll_to_bottom.dart';

class ChaView extends StatefulWidget {
  final int messageContainerFlex;

  final bool readOnly;

  final double height;

  final double width;

  final List<ChatMessage> messages;

  final TextEditingController textController;

  final FocusNode focusNode;

  final TextDirection inputTextDirection;

  final String text;

  final Function(String) onTextChange;

  final bool inputDisabled;

  final InputDecoration inputDecoration;

  final TextCapitalization textCapitalization;

  final String Function() messageIdGenerator;

  final ChatUser user;

  final Function(ChatMessage) onSend;

  final bool alwaysShowSend;

  final bool sendOnEnter;

  final TextInputAction textInputAction;

  /// [DateFormat] objeto para data de formatação para mostrar em [MessageListView]
  /// padroniza para `aaaa-MM-dd`.
  final DateFormat dateFormat;

  /// [DateFormat] objeto para formatar hora para mostrar em [MessageContainer]
  /// padroniza para `HH: mm: ss`.
  final DateFormat timeFormat;

  /// Caso o avatar do usuário seja mostrado, o padrão é falso e não
  /// mostra o avatar do usuário.
  final bool showUserAvatar;

  /// avatarBuilder irá substituir o avatar padrão que usa
  /// [CircleAvatar].
  final Widget Function(ChatUser) avatarBuilder;

  /// O avatar deve ser mostrado para cada mensagem, o padrão é falso.
  final bool showAvatarForEveryMessage;

  /// [onPressAvatar] assume uma função com esta estrutura
  /// [Function (ChatUser)] será acionado quando o avatar
  /// está tocado
  final Function(ChatUser) onPressAvatar;

  /// [onLongPress Avatar] assume uma função com esta estrutura
  /// [Function (ChatUser)] irá disparar quando o avatar /// for pressionado por muito tempo
  final Function(ChatUser) onLongPressAvatar;

  /// [onLongPressMessage] função leva uma função com esta estrutura
  /// [Function (ChatMessage)] será acionado quando a mensagem
  /// é pressionado por muito tempo.
  final Function(ChatMessage) onLongPressMessage;

  /// As mensagens devem ser mostradas na ordem inversa.
  final bool inverted;

  /// messageBuilder substituirá o contêiner de bate-papo padrão que usa
  /// e você precisará construir um widget de mensagem completo, ele não aceitará
  /// e inclui quaisquer outras funções do construtor.
  final Widget Function(ChatMessage) messageBuilder;

  /// messageTextBuilder substituirá o texto da mensagem padrão.
  final Widget Function(String, [ChatMessage]) messageTextBuilder;

  /// messageImageBuilder substituirá a imagem padrão.
  final Widget Function(String url, [ChatMessage]) messageImageBuilder;

  /// messageTimeBuilder substituirá o texto padrão.
  final Widget Function(String url, [ChatMessage]) messageTimeBuilder;

  /// dateBuilder substituirá o texto de hora padrão.
  final Widget Function(String) dateBuilder;

  /// Um widget que será mostrado abaixo do [MessageListView] como você pode
  /// mostra um "empate ..." no final.
  final Widget Function() chatFooterBuilder;

  /// Comprimento de entrada principal dos padrões da caixa de texto de entrada sem limite.
  final int maxInputLength;

  /// Usado para analisar texto para torná-lo uso de texto vinculado
  /// [flutter_parsed_text] (https://pub.dev/packages/flutter_parsed_text)
  /// obtém uma lista de [MatchText] para analisar e-mail, telefone, links
  /// e também pode adicionar padrões personalizados usando regex
  final List<MatchText> parsePatterns;

  /// Fornece um estilo personalizado para o contêiner de mensagem
  /// leva [BoxDecoration]
  final BoxDecoration messageContainerDecoration;

  /// [Lista] de [Widget] para mostrar antes do [TextField].
  final List<Widget> leading;

  /// [Lista] de [Widget] para mostrar após o [TextField]. Irá remover o
  /// botão enviar e terá que implementá-lo sozinho.
  final List<Widget> trailing;

  final Widget Function(Function) sendButtonBuilder;

  final TextStyle inputTextStyle;

  final BoxDecoration inputContainerStyle;

  final int inputMaxLines;

  final bool showInputCursor;

  final double inputCursorWidth;

  final Color inputCursorColor;

  final ScrollController scrollController;

  /// Um widget que será mostrado abaixo do [ChatInputToolbar] como você pode
  /// mostra uma lista de botões como imagem de arquivo, assim como no aplicativo Slack.
  final Widget Function() inputFooterBuilder;

  /// Preenchimento para [MessageListView].
  final EdgeInsetsGeometry messageContainerPadding;

  /// Método de retorno de chamada quando a resposta rápida foi tocada em
  /// passará [Responder] como um parâmetro para a função.
  final Function(Reply) onQuickReply;

  /// Preenchimento para a área de resposta rápida
  /// por padrão, o preenchimento é definido como 0,0
  final EdgeInsetsGeometry quickReplyPadding;

  /// Estilo de contêiner para o contêiner de resposta rápida [BoxDecoration].
  final BoxDecoration quickReplyStyle;

  /// [TextStyle] para o estilo de texto QuickReply.
  final TextStyle quickReplyTextStyle;

  /// Deve a resposta rápida ser rolável horizontalmente
  final Widget Function(Reply) quickReplyBuilder;

  /// Should quick reply be horizontally scrollable
  final bool quickReplyScroll;

  /// Os Widgets [trailling] devem ser mostrados antes do botão enviar
  /// Por padrão, será mostrado antes do botão enviar.
  final bool showTraillingBeforeSend;

  /// Deve o widget de rolagem para o fundo ser mostrado
  /// padrão para verdadeiro.
  final bool scrollToBottom;

  final bool shouldStartMessagesFromTop;

  /// Substitui o padrão [scrollToBottomWidget] por um widget personalizado
  final Widget Function() scrollToBottomWidget;

  final Function onScrollToBottomPress;

  final bool shouldShowLoadEarlier;

  /// Substituir o comportamento padrão do widget onScrollToBottom
  final Widget Function() showLoadEarlierWidget;

  /// Substituir o comportamento padrão do widget onLoadEarleir
  /// ou usado como um retorno de chamada quando o listView atinge o topo
  final Function onLoadEarlier;

  /// Preenchimento da barra de ferramentas de entrada padrão
  /// por padrão, o preenchimento é definido como 0,0
  final EdgeInsets inputToolbarPadding;

  /// Margem para a barra de ferramentas de entrada padrão
  /// por padrão, o preenchimento é definido como 0,0
  final EdgeInsets inputToolbarMargin;

  /// [messageButtonsBuilder] function takes a function with this
  /// structure [List<Widget> Function()] to render the buttons inside
  /// a row.
  final List<Widget> Function(ChatMessage) messageButtonsBuilder;

  /// Preenchimento da mensagem
  /// Padrão para EdgeInsets.all (8.0)
  final EdgeInsets messagePadding;

  /// Deve mostrar o texto antes da imagem no [MessageContainer]
  /// ou o oposto
  /// Padrão para `true` /// Deve mostrar o texto antes da imagem no [MessageContainer]
  /// ou o oposto
  /// Padrão para `true`
  final bool textBeforeImage;

  /// define o padrão [AvatarContainer] maxSize.
  ///
  /// O padrão é `30.0`
  final double avatarMaxSize;

  /// substitui a caixa de decoração da mensagem
  /// pode ser usado para substituir a cor ou personalizar o recipiente da mensagem
  /// params [ChatMessage] e [isUser]: boolean
  /// return BoxDecoration
  final BoxDecoration Function(ChatMessage, bool) messageDecorationBuilder;

  ScrollToBottomStyle scrollToBottomStyle;

  ChaView({
    Key key,
    ScrollToBottomStyle scrollToBottomStyle,
    this.avatarMaxSize = 30.0,
    this.inputTextDirection,
    this.inputToolbarMargin = const EdgeInsets.all(0.0),
    this.inputToolbarPadding = const EdgeInsets.all(0.0),
    this.shouldShowLoadEarlier = false,
    this.showLoadEarlierWidget,
    this.onLoadEarlier,
    this.sendOnEnter = false,
    this.textInputAction,
    this.scrollToBottom = true,
    this.scrollToBottomWidget,
    this.onScrollToBottomPress,
    this.onQuickReply,
    this.quickReplyPadding = const EdgeInsets.all(0.0),
    this.quickReplyStyle,
    this.quickReplyTextStyle,
    this.quickReplyBuilder,
    this.quickReplyScroll = false,
    this.messageContainerPadding = const EdgeInsets.only(
      left: 2.0,
      right: 2.0,
    ),
    this.scrollController,
    this.inputCursorColor,
    this.inputCursorWidth = 2.0,
    this.showInputCursor = true,
    this.inputMaxLines = 1,
    this.inputContainerStyle,
    this.inputTextStyle,
    this.leading = const <Widget>[],
    this.trailing = const <Widget>[],
    this.messageContainerDecoration,
    this.messageContainerFlex = 1,
    this.height,
    this.width,
    this.readOnly = false,
    @required this.messages,
    this.onTextChange,
    this.text,
    this.inputDisabled = false,
    this.textController,
    this.focusNode,
    this.inputDecoration,
    this.textCapitalization = TextCapitalization.none,
    this.alwaysShowSend = false,
    this.messageIdGenerator,
    this.dateFormat,
    this.timeFormat,
    @required this.user,
    @required this.onSend,
    this.onLongPressAvatar,
    this.onLongPressMessage,
    this.onPressAvatar,
    this.avatarBuilder,
    this.showAvatarForEveryMessage = false,
    this.showUserAvatar = false,
    this.inverted = false,
    this.maxInputLength,
    this.parsePatterns = const <MatchText>[],
    this.chatFooterBuilder,
    this.messageBuilder,
    this.inputFooterBuilder,
    this.sendButtonBuilder,
    this.dateBuilder,
    this.messageImageBuilder,
    this.messageTextBuilder,
    this.messageTimeBuilder,
    this.showTraillingBeforeSend = true,
    this.shouldStartMessagesFromTop = false,
    this.messageButtonsBuilder,
    this.messagePadding = const EdgeInsets.all(8.0),
    this.textBeforeImage = true,
    this.messageDecorationBuilder,
  }) : super(key: key) {
    this.scrollToBottomStyle = scrollToBottomStyle ?? new ScrollToBottomStyle();
  }

  String getVal() {
    return text;
  }

  @override
  MyChatState createState() => MyChatState();
}

class MyChatState extends State<ChaView> {
  FocusNode inputFocusNode;
  TextEditingController textController;
  ScrollController scrollController;
  String _text = "";
  bool visible = false;
  GlobalKey inputKey = GlobalKey();
  double height = 48.0;
  bool showLoadMore = false;

  String get messageInput => _text;
  bool _initialLoad = true;
  Timer _timer;

  void onTextChange(String text) {
    if (visible) {
      changeVisible(false);
    }
    setState(() {
      this._text = text;
    });
  }

  void changeVisible(bool value) {
    if (widget.scrollToBottom) {
      setState(() {
        visible = value;
      });
    }
  }

  void changeDefaultLoadMore(bool value) {
    setState(() {
      showLoadMore = value;
    });
  }

  @override
  void initState() {
    scrollController = widget.scrollController ?? ScrollController();
    textController = widget.textController ?? TextEditingController();
    inputFocusNode = widget.focusNode ?? FocusNode();
    WidgetsBinding.instance.addPostFrameCallback(widgetBuilt);
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void widgetBuilt(Duration d) {
    double initPos = widget.inverted
        ? 0.0
        : scrollController.position.maxScrollExtent + 25.0;

    scrollController
        .animateTo(
      initPos,
      duration: const Duration(milliseconds: 150),
      curve: Curves.easeInOut,
    )
        .whenComplete(() {
      _timer = Timer(Duration(milliseconds: 1000), () {
        if (this.mounted) {
          setState(() {
            _initialLoad = false;
          });
        }
      });
    });

    scrollController.addListener(() {
      bool topReached = widget.inverted
          ? scrollController.offset >=
                  scrollController.position.maxScrollExtent &&
              !scrollController.position.outOfRange
          : scrollController.offset <=
                  scrollController.position.minScrollExtent &&
              !scrollController.position.outOfRange;

      if (widget.shouldShowLoadEarlier) {
        if (topReached) {
          setState(() {
            showLoadMore = true;
          });
        } else {
          setState(() {
            showLoadMore = false;
          });
        }
      } else if (topReached) {
        widget.onLoadEarlier();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth == double.infinity
            ? MediaQuery.of(context).size.width
            : constraints.maxWidth;
        final maxHeight = constraints.maxWidth == double.infinity
            ? MediaQuery.of(context).size.height
            : constraints.maxHeight;
        return Container(
          height: widget.height != null ? widget.height : maxHeight,
          width: widget.width != null ? widget.width : maxWidth,
          child: Stack(
            children: <Widget>[
              Column(
                mainAxisAlignment: widget.shouldStartMessagesFromTop
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.end,
                children: <Widget>[
                  MessageListView(
                      avatarMaxSize: widget.avatarMaxSize,
                      messagePadding: widget.messagePadding,
                      constraints: constraints,
                      shouldShowLoadEarlier: widget.shouldShowLoadEarlier,
                      showLoadEarlierWidget: widget.showLoadEarlierWidget,
                      onLoadEarlier: widget.onLoadEarlier,
                      defaultLoadCallback: changeDefaultLoadMore,
                      messageContainerPadding: widget.messageContainerPadding,
                      scrollController: widget.scrollController != null
                          ? widget.scrollController
                          : scrollController,
                      user: widget.user,
                      messages: widget.messages,
                      showuserAvatar: widget.showUserAvatar,
                      dateFormat: widget.dateFormat,
                      timeFormat: widget.timeFormat,
                      inverted: widget.inverted,
                      showAvatarForEverMessage:
                          widget.showAvatarForEveryMessage,
                      onLongPressAvatar: widget.onLongPressAvatar,
                      onPressAvatar: widget.onPressAvatar,
                      onLongPressMessage: widget.onLongPressMessage,
                      avatarBuilder: widget.avatarBuilder,
                      messageBuilder: widget.messageBuilder,
                      messageTextBuilder: widget.messageTextBuilder,
                      messageImageBuilder: widget.messageImageBuilder,
                      messageTimeBuilder: widget.messageTimeBuilder,
                      dateBuilder: widget.dateBuilder,
                      messageContainerDecoration:
                          widget.messageContainerDecoration,
                      parsePatterns: widget.parsePatterns,
                      changeVisible: changeVisible,
                      visible: visible,
                      showLoadMore: showLoadMore,
                      messageButtonsBuilder: widget.messageButtonsBuilder,
                      messageDecorationBuilder:
                          widget.messageDecorationBuilder),
                  if (widget.messages.length != 0 &&
                      widget.messages.last.user.uid != widget.user.uid &&
                      widget.messages.last.quickReplies != null)
                    Container(
                      padding: widget.quickReplyPadding,
                      constraints: BoxConstraints(
                          maxHeight: widget.quickReplyScroll ? 50.0 : 100.0),
                      width: widget.quickReplyScroll ? null : maxWidth,
                      child: widget.quickReplyScroll
                          ? ListView(
                              scrollDirection: Axis.horizontal,
                              children: widget.messages.last.quickReplies.values
                                  .map(_mapReply)
                                  .toList(),
                            )
                          : Wrap(
                              children: <Widget>[
                                ...widget.messages.last.quickReplies.values
                                    .sublist(
                                        0,
                                        widget.messages.last.quickReplies.values
                                                    .length <=
                                                3
                                            ? widget.messages.last.quickReplies
                                                .values.length
                                            : 3)
                                    .map(_mapReply)
                                    .toList(),
                              ],
                            ),
                    ),
                  if (widget.chatFooterBuilder != null)
                    widget.chatFooterBuilder(),
                  if (!widget.readOnly)
                    SafeArea(
                      child: ChatInputToolbar(
                        key: inputKey,
                        sendOnEnter: widget.sendOnEnter,
                        textInputAction: widget.textInputAction,
                        inputToolbarPadding: widget.inputToolbarPadding,
                        inputToolbarMargin: widget.inputToolbarMargin,
                        showTraillingBeforeSend: widget.showTraillingBeforeSend,
                        inputMaxLines: widget.inputMaxLines,
                        controller: textController,
                        inputDecoration: widget.inputDecoration,
                        textCapitalization: widget.textCapitalization,
                        onSend: widget.onSend,
                        user: widget.user,
                        messageIdGenerator: widget.messageIdGenerator,
                        maxInputLength: widget.maxInputLength,
                        sendButtonBuilder: widget.sendButtonBuilder,
                        text: widget.text != null ? widget.text : _text,
                        onTextChange: widget.onTextChange != null
                            ? widget.onTextChange
                            : onTextChange,
                        inputDisabled: widget.inputDisabled,
                        leading: widget.leading,
                        trailling: widget.trailing,
                        inputContainerStyle: widget.inputContainerStyle,
                        inputTextStyle: widget.inputTextStyle,
                        inputFooterBuilder: widget.inputFooterBuilder,
                        inputCursorColor: widget.inputCursorColor,
                        inputCursorWidth: widget.inputCursorWidth,
                        showInputCursor: widget.showInputCursor,
                        alwaysShowSend: widget.alwaysShowSend,
                        scrollController: widget.scrollController != null
                            ? widget.scrollController
                            : scrollController,
                        focusNode: inputFocusNode,
                        reverse: widget.inverted,
                      ),
                    )
                ],
              ),
              if (visible && !_initialLoad)
                Positioned(
                  right: widget.scrollToBottomStyle.right,
                  left: widget.scrollToBottomStyle.left,
                  bottom: widget.scrollToBottomStyle.bottom,
                  top: widget.scrollToBottomStyle.top,
                  child: widget.scrollToBottomWidget != null
                      ? widget.scrollToBottomWidget()
                      : ScrollToBottom(
                          onScrollToBottomPress: widget.onScrollToBottomPress,
                          scrollToBottomStyle: widget.scrollToBottomStyle,
                          scrollController: scrollController,
                          inverted: widget.inverted,
                        ),
                ),
            ],
          ),
        );
      },
    );
  }

  QuickReply _mapReply(Reply reply) => QuickReply(
        reply: reply,
        onReply: widget.onQuickReply,
        quickReplyBuilder: widget.quickReplyBuilder,
        quickReplyStyle: widget.quickReplyStyle,
        quickReplyTextStyle: widget.quickReplyTextStyle,
      );
}
