import 'package:avatar_glow/avatar_glow.dart';
import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:speech_to_text/speech_recognition_result.dart';

class SpeechToTextView extends StatefulWidget {
  const SpeechToTextView({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: SpeechToTextView());

  @override
  State<SpeechToTextView> createState() => _SpeechToTextViewState();
}

class _SpeechToTextViewState extends State<SpeechToTextView> {
  late stt.SpeechToText _speech;
  bool _speechEnabled = false;
  String _lastWords = '';

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  Future _showModalSheet(context, speechEnabled) async {
    if (speechEnabled) {
      await showModalBottomSheet(
          context: context,
          builder: (_) {
            return Column(
              children: [
                Center(
                  child: Text(_lastWords
                      // If listening isn't active but could be tell the user
                      // how to start it, otherwise indicate that speech
                      // recognition is not yet ready or not supported on
                      // the target device

                      ),
                ),
                TextButton(onPressed: () {}, child: const Text('Save?'))
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    print(_speechEnabled);
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Colors.grey,
        width: MediaQuery.of(context).size.width * .5,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(children: [
            IconButton(
                onPressed: () {
                  //BlocProvider.of<AuthCubit>(context).logOut();
                },
                icon: const Icon(Icons.exit_to_app))
          ]),
        ),
      ),
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      floatingActionButton: AvatarGlow(
        animate: _speechEnabled,
        duration: const Duration(milliseconds: 2000),
        repeatPauseDuration: const Duration(milliseconds: 100),
        glowColor: Colors.red,
        endRadius: 70.0,
        child: FloatingActionButton(
          onPressed:
              // If not yet listening for speech start, otherwise stop
              () {
            _listen();
          },
          tooltip: 'Listen',
          child: Icon(_speechEnabled == false ? Icons.mic_off : Icons.mic),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Container(
              padding: const EdgeInsets.only(top: 10),
              child: const Text(
                'Notes',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Bubble(
                alignment: Alignment.topRight,
                color: Colors.yellow,
                stick: true,
                nip: BubbleNip.rightTop,
                nipHeight: 10,
                child: Text(
                  // If listening is active show the recognized words
                  _speechEnabled
                      ? _lastWords
                      // If listening isn't active but could be tell the user
                      // how to start it, otherwise indicate that speech
                      // recognition is not yet ready or not supported on
                      // the target device
                      : _speechEnabled
                          ? 'Tap the microphone to start listening...'
                          : 'Speech not available',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }



  void _listen() async {
    if (!_speechEnabled) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _speechEnabled = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _lastWords = val.recognizedWords;
          }),
        );
      }
    } else {
      setState(() => _speechEnabled = false);
      _speech.stop();
      _showModalSheet(context, _speechEnabled);
    }
  }
}
