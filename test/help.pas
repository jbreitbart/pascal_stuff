PROGRAM HelpDemonstration;        {HELP.PAS}

{$R HELP.RES}

USES WinTypes, WinProcs, OWindows;

CONST ID_Punkt1 = 101;     { IDs der einzelnen Menüpunkte }
      ID_Punkt2 = 102;
      ID_Help   = 200;

      HelpErzeuge  = 1;  { IDs der Kontextstrings, wie sie in der }
      HelpAnwenden = 2;  { Projektdatei HELP.HPJ festgelegt wurden }

TYPE THelpApp = OBJECT (TApplication)
       PROCEDURE InitMainWindow; virtual;
     END;

     PMainWin = ^TMainWin;

     TMainWin = OBJECT (TWindow)
       cmHelp  : Boolean;   { Flag für kontextabhängige Hilfe }

       CONSTRUCTOR Init (AParent : PWindowsObject;
                         ATitle : PChar);
       PROCEDURE   Punkt1 (VAR Msg : TMessage);
                   virtual CM_First + ID_Punkt1;
       PROCEDURE   Punkt2 (VAR Msg : TMessage);
                   virtual CM_First + ID_Punkt2;
       PROCEDURE   Hilfe (VAR Msg : TMessage);
                   virtual CM_First + ID_Help;
       PROCEDURE   WMEnterIdle (VAR Msg : TMessage);
                   virtual WM_First + WM_EnterIdle;
       PROCEDURE   WMCommand (VAR Msg : TMessage);
                   virtual WM_First + WM_Command;
     END;


CONSTRUCTOR TMainWin.Init (AParent : PWindowsObject;
                           ATitle : PChar);
BEGIN
  TWindow.Init (AParent, ATitle);
  CmHelp := false;

  {
    Lade das Menü MENUE aus dem Resource-File und benutze
    es als Menü für dieses Fenster:
  }

  Attr.Menu := LoadMenu (HInstance, 'MENUE');
END;


{
  Nun folgen die drei Methoden zur Behandlung der Menüpunkte.
  Dabei werden in den beiden ersten Fällen nur Message-Boxen
  mit einem kurzen Hinweis ausgegeben. Im dritten Fall dagegen
  wird die API-Funktion WinHelp aufgerufen, um den Hilfe-Index
  anzeigen zu lassen. Als Parameter wird dabei auch der Name
  der Hilfedatei angegeben.
}

PROCEDURE TMainWin.Punkt1 (VAR Msg : TMessage);
BEGIN
  MessageBox (HWindow, 'Menüpunkt 1', 'Auswahl:', mb_OK);
END;


PROCEDURE TMainWin.Punkt2 (VAR Msg : TMessage);
BEGIN
  MessageBox (HWindow, 'Menüpunkt 2', 'Auswahl:', mb_OK);
END;


PROCEDURE TMainWin.Hilfe (VAR Msg : TMessage);
BEGIN
  WinHelp (HWindow, 'HELP.HLP', Help_Index, 0);
END;


{
  Dir folgende Methode, EnterIdle, wird von Windows aufgerufen,
  wenn wärend der Darstellung einer Dialogbox oder eines Menüs
  nichts mehr zu tun ist, das System also in "Leerlaufstellung"
  (Idle) arbeitet. Sollte während dieser Zeit die F1-Taste gedrückt
  werden, so merken wir uns das und simulieren das Drücken der
  Return-Taste (Auslösen des Menübefehls). Windows wird dann eine
  WM_Command-Message an das Fenster senden, und die fangen wir ab,
  um dann den entsprechenden Hilfs-Text anzeigen zu lassen.
}

PROCEDURE TMainWin.WMEnterIdle (VAR Msg : TMessage);
BEGIN
  IF (Msg.WParam = Msgf_Menu) AND
     (GetKeyState (VK_F1) AND $8000 <> 0) THEN
  BEGIN
    CmHelp := true; { merke Dir: das nächste Kommando bringt Hilfe }
    PostMessage (HWindow, WM_KeyDown, VK_Return, 0);
  END;
END;


{
  In die folgende Methode kommen wir nun, sobald eine Command-Nachricht
  oder eine Nachricht bezüglich eines Kind-Fensters eintrifft. Unter
  anderem kommen wir hier auch dann hin, wenn wir in obiger Methode
  das Drücken der Return-Taste simuliert haben, um scheinbar einen
  Menüpunkt auszulösen:
}

PROCEDURE TMainWin.WMCommand (VAR Msg : TMessage);
VAR HelpID : Word;
BEGIN
  IF not cmHelp
    THEN TWindow.WMCommand (Msg)
    ELSE BEGIN
      {
        Überprüfen, ob ein Menüpunkt ausgewählt wurde, zu dem
        ein Hilfetext existiert:
      }

      HelpID := 0;

      CASE Msg.WParam of
        ID_Punkt1 : HelpID := HelpErzeuge;
        ID_Punkt2 : HelpID := HelpAnwenden;
      END;

      IF HelpID = 0
        THEN MessageBox (HWindow,
                         'Zu diesem Menüpunkt gibt es keine Hilfe!',
                         'Hilfe:', mb_IconExclamation)
        ELSE WinHelp (HWindow, 'HELP.HLP', Help_Context, HelpID);

      cmHelp := false;
    END;
END;


PROCEDURE THelpApp.InitMainWindow;
BEGIN
  MainWindow := New (PMainWin, Init (nil,
                     'Fenster mit Menüzeile'));
END;


VAR HelpApp : THelpApp;

BEGIN
  HelpApp.Init ('HILFEDEMO');
  HelpApp.Run;
  HelpApp.Done;
END.
