PROGRAM Welcome3;

USES WinTypes, WinProcs, OWindows;

TYPE TWelcomeApp = OBJECT (TApplication)
       PROCEDURE InitMainWindow; virtual;
     END;


     PWelcomeWin = ^TWelcomeWin;

     TWelcomeWin = OBJECT (TWindow)
       CONSTRUCTOR Init (AParent : PWindowsObject; ATitle : PChar);
       PROCEDURE   Paint (PaintDC : HDC; VAR PaintInfo : TPaintStruct);
                   virtual;
       FUNCTION    GetClassName : PChar; virtual;
       PROCEDURE   GetWindowClass (VAR AWindowClass : TWndClass);
                   virtual;
     END;


PROCEDURE TWelcomeApp.InitMainWindow;
BEGIN
  MainWindow := New (PWelcomeWin, Init (nil, 'WILLKOMMEN!'));
END;


CONSTRUCTOR TWelcomeWin.Init (AParent : PWindowsObject; ATitle : PChar);
BEGIN
  TWindow.Init (AParent, ATitle);
  Attr.Style := Attr.Style or ws_VScroll or ws_HScroll;
  Scroller := New (PScroller, Init (@self, 8, 15, 40, 15));
END;


PROCEDURE TWelcomeWin.Paint (PaintDC : HDC; VAR PaintInfo : TPaintStruct);
VAR hoch,
    breit,
    x, y,
    i      : Integer;
    ext    : LongInt;
BEGIN
  ext := GetTextExtent (PaintDC, 'Willkommen!', 11);

  {
    Höhe des Strings im Hi-, Breite im Low-Word von ext:
  }

  breit := ext and $FFFF;
  hoch  := ext shr 16;

  {
    Der Background-Modus wird auf Transparent gesetzt. Dies sieht
    bei unserem grauen Hintergrund schöner aus, denn ansonsten würde
    der Text in weißen Rechtecken auf dem grauen Grund erscheinen.
  }

  SetBkMode (PaintDC, Transparent);

  FOR i:=0 TO 30 DO BEGIN
    x := 10 + i * 20;
    y := 30 + i * 15;

    {
      Text nur ausgeben, wenn er ganz oder teilweise innerhalb
      des gerade angezeigten Fensterausschnitts liegt.
      Angabe der Koordinaten bei IsVisibleRect erfolgt in
      Scroll-Einheiten, daher DIV 8 bzw. DIV 15. Da dies die
      Berechnung etwas ungenau macht, genehmigen wir einen ´Rand´
      von jeweils 2 Scroll-Einheiten:
    }

    IF Scroller^.IsVisibleRect (x DIV 8 - 2, y DIV 15 - 2,
                                breit DIV 8 + 4, hoch DIV 15 + 4)
      THEN TextOut (PaintDC, x, y, 'Willkommen!', 11);
  END;
END;


FUNCTION TWelcomeWin.GetClassName : PChar;
BEGIN
  GetClassName := 'WELCOME';
END;


PROCEDURE TWelcomeWin.GetWindowClass (VAR AWindowClass : TWndClass);
BEGIN
  {
    Zunächst lassen wir den Vorgänger, TWindow, alle wichtigen
    Daten holen:
  }

  TWindow.GetWindowClass (AWindowClass);

  {
    Dann ändern wir unsere speziellen Wünsche ab:
    Farbe, Mauscursor und Ikone.
  }

  WITH AWindowClass DO BEGIN
    hbrBackground := color_BtnShadow+1;
    hCursor := LoadCursor (0, idc_Cross);
    hIcon := LoadIcon (0, idi_Exclamation);
  END;
END;


VAR WelcomeApp : TWelcomeApp;

BEGIN
  WelcomeApp.Init ('WILLKOMMEN');
  WelcomeApp.Run;
  WelcomeApp.Done;
END.
