Program MiniWindowsApp;
uses OWindows;
var MiniApp: TApplication;
begin
  MiniApp.Init ('Test');
  MiniApp.Run;
  MiniApp.Done;
end.