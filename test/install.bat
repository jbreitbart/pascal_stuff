@CLS
@ECHO OFF
IF "%1" == "" GOTO FEHLER
ECHO ����������������������������������������������������������������������������ͻ
ECHO �                        I N S T A L L A T I O N                             �
ECHO �           Diskette zum Gro�en Buch zu Turbo & Borland Pascal 7.0           �
ECHO ����������������������������������������������������������������������������ͼ
ECHO Achtung: Diese Routine installiert die Diskette zum Gro�en Buch zu
ECHO Turbo & Borland Pascal 7.0 auf Ihrer Festplatte. Bitte stellen Sie sicher,
ECHO da� gen�gend Platz (ca. 1.6 MB ) zur Verf�gung steht.
ECHO Falls dies nicht der Fall ist bitte jetzt mit "Strg+C" unterbrechen.
ECHO Ansonsten weiter mit beliebiger Taste
PAUSE >NUL
ECHO Erstelle ben�tigte Verzeichnisse...
REM @MD %1 > NUL
MD %1\BP7DISK
MD %1\BP7DISK\BSPKAP
MD %1\BP7DISK\OOP
MD %1\BP7DISK\TVISION
MD %1\BP7DISK\UNITS
MD %1\BP7DISK\WINDOWS
ECHO Kopiere nun alle Dateien...
COPY BSPKAP.EXE %1\BP7DISK\BSPKAP\BSPKAP.EXE
COPY OOP.COM %1\BP7DISK\OOP\OOP.COM
COPY TVISION.EXE  %1\BP7DISK\TVISION\TVISION.EXE
COPY UNITS.COM %1\BP7DISK\UNITS\UNITS.COM
COPY WINDOWS.COM %1\BP7DISK\WINDOWS\WINDOWS.COM
ECHO Entpacke nun alle Dateien...
%1\
CD %1\BP7DISK
CD BSPKAP
BSPKAP.EXE
DEL BSPKAP.EXE
CD..
CD OOP
OOP.COM
DEL OOP.COM
CD..
CD TVISION
TVISION.EXE
DEL TVISION.EXE
CD..
CD UNITS
UNITS.COM
DEL UNITS.COM.*
CD..
CD WINDOWS
WINDOWS.COM
DEL WINDOWS.COM.*
CLS
CD..
ECHO Das Diskette zum Buch wurde erfolgreich auf Ihrem System installiert.
ECHO Bitte dr�cken Sie nun eine Taste.....
PAUSE >NUL
GOTO ENDE
:FEHLER
CLS
ECHO �
ECHO Achtung!
ECHO =======
ECHO �
ECHO F�r eine korrekte Installation mu� die korrekte Syntax beachtet werden!
ECHO �
ECHO "INSTALL  <ZIELLAUFWERK>"
ECHO �
ECHO Beispiel:
ECHO ���
ECHO �" INSTALL C: <Return>  "
:ENDE
