import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:lottie/lottie.dart';

class AskAI extends StatefulWidget {
  const AskAI({super.key});

  @override
  State<AskAI> createState() => _AskAIState();
}

class _AskAIState extends State<AskAI> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final model = GenerativeModel(
    model: 'models/gemini-1.5-flash-latest',
    apiKey: 'AIzaSyB2yzEtrpRH4XOmnPzvYqKuWCSJS_WxcY4',
  );

  List<Map<String, dynamic>> messages = [];
  bool isLoading = false;

  void sendMessage() async {
    final userText = _controller.text.trim();
    if (userText.isEmpty) return;

    setState(() {
      messages.add({'text': userText, 'fromAI': false});
      isLoading = true;
      _controller.clear();
    });

    final prompt = '''
You are a smart assistant specialized in product recommendations inside a supermarket app.

Only answer questions related to products, offers, or shopping guidance.

If the user asks something unrelated (like sports, politics, or personal questions), politely respond with:
"I'm here to help you with products only 😊"

Now answer this question:
$userText
''';

    await Future.delayed(Duration(milliseconds: 300));
    _scrollToBottom();

    final content = [Content.text(prompt)];
    final response = await model.generateContent(content);

    setState(() {
      messages.add({
        'text': response.text ?? 'No response from AI.',
        'fromAI': true,
      });
      isLoading = false;
    });

    await Future.delayed(Duration(milliseconds: 300));
    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(Duration(milliseconds: 300), () {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 100,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  Widget messageBubble(String text, bool fromAI) {
    return Align(
      alignment: fromAI ? Alignment.centerLeft : Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        padding: EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: fromAI ? Colors.blue.shade100 : Colors.green.shade200,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F8FF),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text("AI Assistant",
            style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: Color(0xFF5D3FD3),
      ),
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/ai2_back.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  final message = messages[index];
                  return messageBubble(message['text'], message['fromAI']);
                },
              ),
            ),
            if (isLoading)
              Lottie.asset("assets/Gemini Google AI.json",
                  height: 150), // 👈 لودر Lottie
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: 'write some thing',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  IconButton(
                    onPressed: sendMessage,
                    icon: Icon(Icons.send, color: Color(0xFF5D3FD3)),
                  )
                ],
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
