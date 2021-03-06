
/**
* Mock UI Provider for Unit Testing
*/
class MockUIProvider implements IOProvider
{
  final StringInputStream textStream;
  
  final List<String> inputs = const [
                                     'look at the mailbox'
                                     ];
  
  final List<String> output;
  
  int index = 0;
  
  MockUIProvider()
  :
    output = new List<String>(),
    textStream = new StringInputStream(stdin);
  
  void PrimaryOutput(String text) {
    output.add(text);
    DebugOutput(text);
  }
  
  void DebugOutput(String text) => print(text);
  
  Future<String> getLine(){
    Completer c = new Completer();
    
    if (index < inputs.length){
      c.complete(inputs[index++]);
    }else{
      textStream.onLine = () => c.complete(textStream.readLine());  
    }
    
    return c.future;
  }
  
  void callAsync(func(timer)){
    new Timer(0, func);
  }
}
