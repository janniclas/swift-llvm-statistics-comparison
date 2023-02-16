
struct MyMain {
    static void main(){
       
          vector<std::function<void()>>completionHandlers;

          //The following function with Escaping Closure
          auto someFunctionWithEscapingClosure = [&completionHandlers] (std::function<void ()> completionHandler) 
          {
            completionHandlers.push_back(completionHandler);
          };

          // Loop over all Completion Handlers
          for(auto h : completionHandlers){
            h();
          }
        
    }
};