PROGRAM MenueDemo;                         { TESTMENU.PAS }

{$R TESTMENU.RES}

USES WinTypes, WinProcs, OWindows;

CONST ID_Punkt1 = 101;     { IDs der einzelnen Men�punkte }
      ID_Punkt2 = 102;     { Diese Werte sind willk�rlich }
      ID_Punkt3 = 103;     { gew�hlt, m�ssen aber mit den }
      ID_Punkt4 = 104;     { im Men�-Editor angegebenen   }
      ID_Punkt5 = 105;     { Werten �bereinstimmen.       }

TYPE TMenueApp = OBJECT (TApplication)
       PROCEDURE InitMainWindow; virtual;
       PROCEDURE InitInstance; virtual;     { neu}
     END;

     PMainWin = ^TMainWin;

     TMainWin = OBJECT (TWindow)
       CONSTRUCTOR Init (AParent : PWindowsObject;
                         ATitle : PChar);
       PROCEDURE   Punkt1 (VAR Msg : TMessage);
                   virtual CM_First + ID_Punkt1;
       PROCEDURE   Punkt2 (VAR Msg : TMessage);
                   virtual CM_First + ID_Punkt2;
       PROCEDURE   Punkt3 (VAR Msg : TMessage);
                   virtual CM_First + ID_Punkt3;
       PROCEDURE   Punkt4 (VAR Msg : TMessage);
                   virtual CM_First + ID_Punkt4;
       PROCEDURE   Punkt5 (VAR Msg : TMessage);
                   virtual CM_First + ID_Punkt5;
     END;


CONSTRUCTOR TMainWin.Init (AParent : PWindowsObject;
                           ATitle : PChar);
BEGIN

  TWindow.Init (AParent, ATitle);

  {
    Lade das Men� MENU_1 aus dem Resource-File und benutze
    es als Men� f�r dieses Fenster:
  }

  Attr.Menu := LoadMenu (HInstance, 'Menu_1');
END;


PROCEDURE TMainWin.Punkt1 (VAR Msg : TMessage);
BEGIN
  MessageBox (HWindow, 'Men�punkt 1', 'Auswahl:', mb_OK);
END;


PROCEDURE TMainWin.Punkt2 (VAR Msg : TMessage);
BEGIN
  MessageBox (HWindow, 'Men�punkt 2', 'Auswahl:', mb_OK);
END;


PROCEDURE TMainWin.Punkt3 (VAR Msg : TMessage);
BEGIN
  MessageBox (HWindow, 'Men�punkt 3', 'Auswahl:', mb_OK);
END;


PROCEDURE TMainWin.Punkt4 (VAR Msg : TMessage);
BEGIN
  MessageBox (HWindow, 'Men�punkt 4', 'Auswahl:', mb_OK);
END;

PROCEDURE TMainWin.Punkt5 (VAR Msg : TMessage);
BEGIN
  MessageBox (HWindow, 'Men�punkt 5', 'Auswahl:', mb_OK);
END;



PROCEDURE TMenueApp.InitMainWindow;
BEGIN
  MainWindow := New (PMainWin, Init (nil,
                     'Fenster mit Men�zeile'));
END;

PROCEDURE TMenueApp.InitInstance;
BEGIN
  {
    Erst den Vorg�nger aufrufen:
  }
  TApplication.InitInstance;
  {
    Dann die Acceleratortabelle laden, die den Namen
    ACCELERATOR_1 hat. Erster Parameter ist das
    Instanzenhandle des Moduls, dessen Ressourcen die
    Tabelle enthalten. Der zweite Parameter ist ein
    String, der die Accelerator-Tabelle identifiziert:
  }
  HAccTable:= LoadAccelerators (HInstance,'ACCELERATORS_1');
END;

VAR MenueApp : TMenueApp;

BEGIN
  MenueApp.Init ('MEN�DEMO');
  MenueApp.Run;
  MenueApp.Done;
END.
