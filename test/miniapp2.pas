PROGRAM MiniWindowsApp2;

USES OWindows, WinProcs, WinTypes;

TYPE TMyApp = OBJECT (TApplication)
       PROCEDURE InitMainWindow;
                 virtual;
     END;

     PMyWin = ^TMyWin;
     TMyWin = OBJECT (TWindow)
       PROCEDURE WMKeyDown (VAR Msg : TMessage); virtual wm_First + WM_KeyDown;
     END;

PROCEDURE TMyApp.InitMainWindow;
BEGIN
  MainWindow := New (PMyWin, Init (nil, 'Mini-Applikation'));
END;

PROCEDURE TMyWin.WMKeyDown (VAR Msg : TMessage);
BEGIN
  MessageBox (HWindow, 'Sie haben eine Taste gedrückt!', 'Hinweis:',
              mb_OK);
END;

VAR  MiniApp : TMyApp;

BEGIN
  MiniApp.Init ('TEST');
  MiniApp.Run;
  MiniApp.Done;
END.
