
 class MyMain
 {
 public:
     static void main()
     {
         std::vector<std::function<void()>> completionHandlers;
         void someFunctionWithEscapingClosure(std::function<void()> completionHandler)
         {
             completionHandlers.push_back(completionHandler);
         }
 
         for (auto h : completionHandlers) 
         {
             h();
         }
     }
 };