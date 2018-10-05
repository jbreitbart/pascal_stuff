{
  Das gro�e Buch zu Borland Pascal 7.0:
               DDE-Server
}

PROGRAM SERVER;            {SERVER.PAS}

{
  Resource-File SERVER.RES in SERVER.EXE einbinden:
}

{$R SERVER.RES}

USES OWindows, WinTypes, WinProcs, Strings,
     ODialogs;

{
  Es folgen die Konstanten u. A. der Objekte, die in der Resource
  definiert wurden:
}

const   id_DDE_link    = 101;
        id_DDE_hotlink = 106;
        id_DDE_name    = 102;
        id_DDE_nummer  = 103;

{
  Ableiten unserer Applikation von TApplication:
}

TYPE TServerApp = OBJECT (TApplication)
       PROCEDURE InitMainWindow; virtual;
     END;

{
  Als Hauptenster f�r unser Programm laden wir eine
  Dialogbox aus dem Resource-File.
}

     PServerWin = ^TServerWin;

     TServerWin = OBJECT (TDlgWindow)
       Partner     : HWnd;
       link        : Boolean;
       hotlink     : (keiner, Name, Telefon);
       MsgText     : ARRAY [0..80] of Char;

       CONSTRUCTOR Init;
       FUNCTION    CanClose : Boolean;
                   virtual;
       FUNCTION    GetClassName : PChar; virtual;
       PROCEDURE   GetWindowClass (VAR AWndClass : TWndClass);
                   virtual;
       PROCEDURE   ChgName (VAR Msg : TMessage);
                   virtual id_first + id_DDE_name;
       PROCEDURE   ChgNummer (VAR Msg : TMessage);
                   virtual id_first + id_DDE_nummer;
       PROCEDURE   WMDDEInitiate (VAR Msg : TMessage);
                   virtual wm_first + WM_DDE_Initiate;
       PROCEDURE   WMDDERequest (VAR Msg : TMessage);
                   virtual wm_first + WM_DDE_Request;
       PROCEDURE   WMDDEPoke (VAR Msg : TMessage);
                   virtual wm_first + WM_DDE_Poke;
       PROCEDURE   WMDDEAdvise (VAR Msg : TMessage);
                   virtual wm_first + WM_DDE_Advise;
       PROCEDURE   WMDDEUnadvise (VAR Msg : TMessage);
                   virtual wm_first + WM_DDE_Unadvise;
       PROCEDURE   WMDDETerminate (VAR Msg : TMessage);
                   virtual wm_first + WM_DDE_Terminate;
       PROCEDURE   SendData (ToWnd : HWnd; ItemA : TAtom;
                             Requested : Boolean);
       PROCEDURE   Message (Txt : PChar);
     END;

PROCEDURE TServerApp.InitMainWindow;
BEGIN
  MainWindow := New (PServerWin, Init);
END;

{
  Nun die Methoden unseres Server-Fensters:
}

CONSTRUCTOR TServerWin.Init;
BEGIN
  TDlgWindow.Init (nil, 'SERVERDLG');
  link    := false;
  hotlink := keiner;
END;


{
  Bevor das Server-Programm beendet werden kann, m�ssen wir
  eine Terminate-Nachricht an den Client schicken, damit dieser
  wei�, das ab sofort keine Verbindung mehr existiert:
}

FUNCTION TServerWin.CanClose : Boolean;
BEGIN
  IF link THEN
    SendMessage (Partner, WM_DDE_Terminate, HWindow, 0);
  CanClose := true;
END;


FUNCTION TServerWin.GetClassName : PChar;
BEGIN
  GetClassName := 'SERVERDLG';
END;


PROCEDURE TServerWin.GetWindowClass (VAR AWndClass : TWndClass);
BEGIN
  TDlgWindow.GetWindowClass (AWndClass);
  AWndClass.hIcon := LoadIcon (HInstance, 'SERVER');
END;


{
  Die beiden folgenden Methoden werden aufgerufen, wenn
  die Datenfelder beschrieben werden. Falls ein Hotlink aktiv
  ist, wird ein entsprechendes Datenpaket gesendet:
}

PROCEDURE TServerWin.ChgName (VAR Msg : TMessage);
VAR ItemA : TAtom;
BEGIN
  IF hotlink = Name THEN BEGIN
    ItemA := GlobalAddAtom ('NAME');
    SendData (Partner, ItemA, false);
  END;
END;


PROCEDURE TServerWin.ChgNummer (VAR Msg : TMessage);
VAR ItemA : TAtom;
BEGIN
  IF hotlink = Telefon THEN BEGIN
    ItemA := GlobalAddAtom ('TELEFON');
    SendData (Partner, ItemA, false);
  END;
END;


{
  Reaktion auf den Versuch, eine Verbindung herzustellen:
  Wenn die fragende Station den SERVER verlangt und das gew�nschte
  Topic (Thema) DATA als Atom �bergeben wurde, gehen wir auf
  die Verbindung ein, d.h. wir merken uns, wer die WM_DDE_Initiate
  Nachricht geschickt hat, setzen in der Server Dialogbox die
  Checkbox und schicken eine Acknowledge-Message zur�ck, damit
  auch der Client wei�, da� wir mit ihm reden m�chten.
}

PROCEDURE TServerWin.WMDDEInitiate (VAR Msg : TMessage);
VAR App,
    Topic : ARRAY [0..30] of Char;

BEGIN
  GlobalGetAtomName (Msg.LParamLo, App, 30);
  GlobalGetAtomName (Msg.LParamHi, Topic, 30);

  IF (StrComp (App, 'SERVER') = 0) AND
     (StrComp (Topic, 'DATA') = 0)
  THEN BEGIN
    Partner := Msg.WParam;    { Window-Handle der des rufenden }
    link := true;                                  { Programms }
    SendDlgItemMessage (HWindow, id_DDE_link, bm_setcheck, 1, 0);
    SendMessage (Partner, WM_DDE_Ack, HWindow, 0);
    {
      Die Message-Methode, deren Programmtext weiter unten steht,
      wird vom Server benutzt, um Informationen in einem daf�r
      vorgesehenen Bereich der Client-Dialogbox darzustellen:
    }
    Message ('Server best�tigt Aufbau der DDE-Verbindung.');
  END
END;


{
  Der Client m�chte den Inhalt eines Datenobjektes zur�ckerhalten
  und hat deshalb eine Request-Nachricht geschickt. Falls wir das
  gew�nschte Format (cf_text, also reiner ANSI-Text) liefern k�nnen,
  tun wir dies.
}

PROCEDURE TServerWin.WMDDERequest (VAR Msg : TMessage);
BEGIN
  IF Msg.LParamLo = cf_text THEN
    SendData (Partner, Msg.LParamHi, true);
  Message ('Server hat die Request Meldung erhalten.');
END;


{
  Da wir an mehreren Stellen Datenpakete senden m�ssen,
  wurde diese Routine "ausgelagert". Zu �bergeben sind
  der vorgesehene Empf�nger und das Atom, das das Datenfeld
  (Item) beschreibt, in unserem Falle also NAME oder TELEFON:
}

PROCEDURE TServerWin.SendData (ToWnd : HWnd; ItemA : TAtom;
                               Requested : Boolean);
VAR Item       : ARRAY [0..30] of Char;
    Data       : ^TDDEData;
    DataHandle : Word;
    Daten      : ARRAY [0..80] of Char;
BEGIN
  {
    Zun�chst �berpr�fen wir, wie das zu sendende Item hei�t. Wir
    k�nnen mit NAME, TELEFON und TEXT etwas anfangen. In letzterem
    Falle wird eine mit der Message-Methode zu sendende Information
    �bertragen. Der Client mu� wissen, was er damit anf�ngt.
  }
  GlobalGetAtomName (ItemA, @Item, 30);
  IF (Strcomp (@Item, 'NAME') <> 0) AND (Strcomp (@Item, 'TELEFON')
     <> 0) AND (StrComp (@Item, 'TEXT') <> 0)
  THEN BEGIN
    Message ('Unbekanntes Datenfeld wurde angefordert!');
  END ELSE BEGIN
    {
      Nun entscheiden wir, welche Information gesendet wird. Die
      Datenfelder lesen wir gegebenenfalls diekt aus der Dialogbox
      aus. Falls eine Nachricht an den Client zu �bertragen ist,
      finden wir den entsprechenden Text in der Variablen MsgText.
    }
    IF Strcomp (@Item, 'NAME') = 0
      THEN GetDlgItemText (HWindow, id_DDE_name, Daten, 30)
      ELSE IF Strcomp (@Item, 'TELEFON') = 0
        THEN GetDlgItemText (HWindow, id_DDE_nummer, Daten, 30)
        ELSE StrCopy (@Daten, MsgText);

    {
      Aus diesen Daten fertigen wir unser Datenpaket an. Das Flag
      gmem_DDEShare sorgt daf�r, da� der Empf�nger, wenn er erst
      einmal im Besitz des Speicher-Handles ist, auch auf die Daten
      zugreifen darf. Au�erdem verlangt der DDE Standard, da� wir
      dem Empf�nger mitteilen, ob er das Datenpaket explizit ange-
      fordert hat oder ob es etwa im Rahmen eines Hotlinks auto-
      matisch erzeugt wurde. In jedem Fall bitten wir den Empf�nger,
      den Speicher und die Atome selber wieder freizugeben
      (DDE_fRelease) und den Empfang nicht zu best�tigen.
    }
    DataHandle := GlobalAlloc (gmem_Moveable or gmem_DDEShare,
                    SizeOf (TDDEData) + StrLen (Daten));
    IF DataHandle <> 0 THEN BEGIN
      Data := GlobalLock (DataHandle);
      IF Data <> NIL THEN BEGIN
        Data^.cfFormat := cf_text;
        IF Requested THEN Data^.Flags := DDE_Response or
                                         DDE_Release
                     ELSE Data^.Flags := DDE_Release;
        Move (Daten, Data^.Value, StrLen (Daten)+1);
        GlobalUnlock (DataHandle);

        IF PostMessage (ToWnd, WM_DDE_Data, HWindow,
                        MakeLong (DataHandle, ItemA)) = false
        THEN BEGIN
          {
            Falls die �bertragung nicht geklappt hat, m�ssen wir
            den Speicher nat�rlich selber wieder freigeben:
          }
          GlobalFree (DataHandle);
          GlobalDeleteAtom (ItemA);
        END;
      END
      ELSE GlobalFree (DataHandle);
    END;
  END;
END;


{
  Der Client m�chte einen Hotlink einrichten:
}

PROCEDURE TServerWin.WMDDEAdvise (VAR Msg : TMessage);
VAR Data : ^TDDEData;
    Item : ARRAY [0..30] of Char;
BEGIN
  {
    Erst pr�fen wir, ob der Hotlink f�r ein g�ltiges Item
    (NAME oder TELEFON) einzurichten ist.
  }
  GlobalGetAtomName (Msg.LParamHi, Item, 30);
  IF (StrComp (@Item, 'NAME') <> 0) AND
     (StrComp (@Item, 'TELEFON') <> 0) THEN BEGIN
    {
      Negative Acknowledge zur�cksenden:
    }
    PostMessage (Msg.WParam, WM_DDE_Ack, HWindow, MakeLong
                 (0, Msg.LParamHi));
    Message ('Unbekanntes Datenfeld, Hotlink nicht m�glich.');
  END ELSE BEGIN
    {
      Dann merken wir uns, f�r welches Item der Hotlink
      angefordert wurde und pr�fen, ob wir den Hotlink
      best�tigen m�ssen und wer den Speicher freizugeben hat:
    }
    Data := GlobalLock (Msg.LParamLo);
    IF Data <> NIL THEN BEGIN
      IF StrComp (@Item, 'NAME') = 0
        THEN Hotlink := Name
        ELSE Hotlink := Telefon;

      SendDlgItemMessage (HWindow, id_DDE_hotlink, bm_SetCheck,
                          1, 0);

      IF (Data^.Flags and DDE_AckReq) <> 0
        THEN PostMessage (Partner, WM_DDE_Ack, HWindow, MakeLong
                      (DDE_AckReq, Msg.LParamHi));

      IF (Data^.Flags and DDE_Release) <> 0
        THEN BEGIN
          GlobalUnlock (Msg.LParamLo);
          GlobalFree (Msg.LParamLo);
        END;

      Message ('Server best�tigt Aufbau eines Hotlinks.');
    END;
  END;
  GlobalDeleteAtom (Msg.LParamHi);
END;


{
  Der Hot-Link soll abgebrochen werden. Wir verzichten hier einmal
  darauf zu pr�fen, ob wir den Vorgang best�tigen m�ssen. Unser
  Demonstartions-Client verlangt dies nicht. Der Aufruf der Message-
  Methode stellt ja keine Best�tigung f�r das Client-Programm dar,
  sondern dient nur der Information des Anwenders.
}

PROCEDURE TServerWin.WMDDEUnadvise (VAR Msg : TMessage);
BEGIN
  GlobalDeleteAtom (Msg.LParamHi);  { Item, brauchen wir nicht }
  hotlink := keiner;
  SendDlgItemMessage (HWindow, id_DDE_hotlink, bm_SetCheck, 0, 0);
  Message ('Server best�tigt Ende des bestehenden Hotlinks.');
END;


{
  Der Client m�chte die Verbindung beenden. Wir best�tigen dies
  durch Versenden einer weiteren WM_DDE_Terminate Nachricht.
}

PROCEDURE TServerWin.WMDDETerminate (VAR Msg : TMessage);
BEGIN
  PostMessage (Partner, WM_DDE_Terminate, HWindow, 0);

  IF hotlink <> keiner THEN BEGIN
    SendDlgItemMessage (HWindow, id_DDE_hotlink, bm_SetCheck, 0, 0);
    hotlink := keiner;
  END;

  SendDlgItemMessage (HWindow, id_DDE_link, bm_SetCheck, 0, 0);
  link := false;
END;


{
  Der Client bittet, ein Feld mit einem neuen Inhalt zu versehen:
}

PROCEDURE TServerWin.WMDDEPoke (VAR Msg : TMessage);
VAR Data    : ^TDDEData;
    Item    : ARRAY [0..30] of Char;
    gesetzt : Boolean;
BEGIN
  gesetzt := true;
  Data := GlobalLock (Msg.LParamLo);
  IF Data <> nil THEN BEGIN
    {
      Hole das Item und �berpr�fe, ob ein g�ltiges Datenfeld
      gesetzt werden soll. Falls nicht, sende eine entsprechende
      Meldung an den Client zur�ck.
    }
    GlobalGetAtomName (Msg.LParamHi, Item, 30);
    IF StrComp (@Item, 'NAME') = 0
      THEN SetDlgItemText (HWindow, id_DDE_name, Data^.Value)
      ELSE IF StrComp (@Item, 'TELEFON') = 0
      THEN SetDlgItemText (HWindow, id_DDE_nummer, Data^.Value)
      ELSE gesetzt := false;

    IF gesetzt
      THEN Message ('Neuer Wert wurde �bernommen.')
      ELSE Message ('Ung�ltiges Datenfeld, kein Wert ge�ndert!');

    GlobalFree (Msg.LParamLo);
  END;
  GlobalDeleteAtom (Msg.LParamHi);
END;


{
  Meldung zum Client geben; sie soll dort ausgegeben werden.
  Wir speichern den Text zun�chst in der Variablen MsgText,
  wo er sp�ter von der SendData Methode gefunden wird. Das Item
  ist TEXT, der Client wird dies erkennen und den Text in der
  Server-Info-Box ausgeben.
}

PROCEDURE TServerWin.Message (Txt : PChar);
VAR Atom : TAtom;
BEGIN
  StrCopy (MsgText, Txt);
  Atom := GlobalAddAtom ('TEXT');
  SendData (Partner, Atom, false);
END;


{
  Als einzige globale Variable ist unsere Applikation zu deklarieren:
}

VAR ServerApp : TServerApp;

BEGIN
  ServerApp.Init ('SERVER');
  ServerApp.Run;
  ServerApp.Done;
END.
