uses alles,crt;

type TForschung = record
      Name : String[28];
      Zeit : Word;
      Text1,text2,text3,text4 : String [41];
      Datei : string [8];
     end;

var Waffen,Gebaude,Fahrz,Ausr  : File of TForschung;
    Test : TForschung;
    akverz : String;

begin
 getdir(0,akverz);
 assign(Waffen,akverz+'\data\Waf.for');
 assign(Gebaude,akverz+'\data\Geb.for');
 assign(Fahrz,akverz+'\data\Fahr.for');
 assign(Ausr,akverz+'\data\Aus.for');
 rewrite(Waffen);
 rewrite(Gebaude);
 rewrite(Fahrz);
 rewrite(Ausr);
 Test.name:='Stein-Gewehr'; {H”here Angriffskraft}
 test.Zeit:=10;
 test.text1:='Verst„rkt die Angriffskraft deiner Truppen';
 test.text2:='Im Kampf gegen Feindliche Einheiten';
 test.text3:='und ist ein Technologischer Fortschritt';
 test.text4:='';
 test.datei:='stgewehr';
 write(Waffen,test);
 test.name:='Scheune'; {H”here Agraertr„ge}
 test.Zeit:=15;
 test.text1:='Mehr Nahrung kann gelagert werden';
 test.text2:='es vergammelt auch nicht so ';
 test.text3:='schnell, wie wenn man es imfreien';
 test.text4:='lagert';
 test.datei:='bauern';
 write(Gebaude,test);
 test.name:='Pferde'; {Schnellere Produktion}
 test.zeit:=12;
 test.text1:='Produktion wird beschleunigt';
 test.text2:='und arbeiter werden entlastet erfinden';
 test.text3:='sie dieses so werden ihre Leute zu-';
 test.text4:='frieden sein, mit ihnen';
 write(Fahrz,test);
 test.name:='Grab-Werkzeug'; {H”here Agraertr„ge}
 test.Zeit:=5;
 test.text1:='Feldbearbeitung wird beschleunigt, es';
 test.text2:='gibt h”here Ertr„ge';
 test.text3:='Auch hier werden die Bauern entlastet';
 test.text4:='';
 write(Ausr,test);
 Test.name:='Stein-Helm'; {H”here Verteidigungskraft}
 test.Zeit:=13;
 test.text1:='Verteidigung iher Truppen wird besser';
 test.text2:='Es gibt weniger tote und somit bessere';
 test.text3:='Moral';
 test.text4:='';
 write(Waffen,test);
 test.name:='Berg-Werk'; {Baumaterial}
 test.Zeit:=25;
 test.text1:='Materialgewinnung wird erh”ht';
 test.text2:='und ihr seid nicht mehr so';
 test.text3:='an H„ndler gebunden';
 test.text4:='';
 write(Gebaude,test);
 test.name:='Karawane'; {H„ndler}
 test.zeit:=26;
 test.text1:='Kontaktaufnahme mit H„ndler Herold';
 test.text2:='H„ndler Herold ist jemand der alls';
 test.text3:='hat was man braucht, berall wo er';
 test.text4:='ist sieht man in verhandeln';
 write(Fahrz,test);
 test.name:='Flaschenzug'; {H”here Produktivit„t}
 test.Zeit:=5;
 test.text1:='Geb„ude werden schneller fertiggestellt';
 test.text2:='und ihr Bauarbeiter werden entlastet';
 test.text3:='';
 test.text4:='';
 write(Ausr,test);
 Test.name:='Stein-Pistole'; {šberraschungseffekt}
 test.Zeit:=10;
 test.text1:='H”here Angriffskraft durch schnellere Fortbewegung der truppen';
 test.text2:='technischer Fortschritt';
 test.text3:='';
 test.text4:='';
 test.datei:='stpistol';
 write(Waffen,test);
 test.name:='Zentral-Brunnen'; {H”here Populationsrate}
 test.Zeit:=25;
 test.text1:='Bessere Wasserversorgung durch Zentralbrunnen';
 test.text2:='Ihre Leute brauchen nicht mehr so weit zu';
 test.text3:='laufen um Wasser zu holen';
 test.text4:='';
 write(Gebaude,test);
 test.name:='Pferde Fuhrwerk'; {Schnellere Produktion}
 test.zeit:=20;
 test.text1:='Erh”ht Produktion von allerlei Ger„tschaften';
 test.text2:='Die Ernte kann schneller eingeholt werden';
 test.text3:='';
 test.text4:='';
 write(Fahrz,test);
 test.name:='Eisenverarbeitung'; {Forschung}
 test.Zeit:=30;
 test.text1:='Erm”glicht Waffen oder Ausrstungsgegenst„nde ';
 test.text2:='aus Eisen zu bauen';
 test.text3:='';
 test.text4:='';
 write(Ausr,test);
 Test.name:='Brustschutz'; {H”here Verteidigung}
 test.Zeit:=39;
 test.text1:='Eure Einheiteb haben h”here šberlebenschancen,';
 test.text2:='bei einem Kampf mit Schuáwaffen';
 test.text3:='Doch die Angriffskraft wird schw„cher';
 test.text4:='';
 write(Waffen,test);
 test.name:='Bauernhof'; {H”here Agra, Eigenversorgung}
 test.Zeit:=40;
 test.text1:='Agraproduktionen werden besser und die ';
 test.text2:='Eigenversorgung wird besser';
 test.text3:='H„ndler Gerold wird entlastet';
 test.text4:='';
 write(Gebaude,test);
 test.name:='Schlitten'; {Transporte auch im Winter}
 test.zeit:=18;
 test.text1:='Schnellere Transporte auch im Winter';
 test.text2:='Toll';
 test.text3:='';
 test.text4:='';
 write(Fahrz,test);
 test.name:='Sense'; {H”here Agraprodukte}
 test.Zeit:=7;
 test.text1:='Ernte wird beschleunigt, erh”ht die Luxusrate der Bauern';
 test.text2:='Gevatter Tot dankt euch';
 test.text3:='';
 test.text4:='';
 write(Ausr,test);
 Test.name:='Schwarzpulver'; {Dient der Forschung}
 test.Zeit:=39;
 test.text1:='Wird weiter erforscht';
 test.text2:='';
 test.text3:='';
 test.text4:='';
 write(Waffen,test);
 test.name:='Hygienische-Einrichtung'; {Population}
 test.Zeit:=20;
 test.text1:='Weniger Krankheiten und sch”neres Aussehen der Kolonie';
 test.text2:='Keiner braucht mehr sein Gesch„ft auf der';
 test.text3:='Straáe zu verrichten';
 test.text4:='';
 write(Gebaude,test);
 test.name:='Lore'; {Transport von Gestein aus einer Miene}
 test.zeit:=18;
 test.text1:='Weniger Tote in den Berkwerken, schnellere Abbau';
 test.text2:='50 % Weniger Leute die sich an Erz totschleppen';
 test.text3:='30 % Besserer ertrag';
 test.text4:='';
 write(Fahrz,test);
 test.name:='Wetzstein'; {H”here Agraprodukte}
 test.Zeit:=7;
 test.text1:='Scharfe Gegenst„nde werden besser';
 test.text2:='Auch die Sense von Gevatter Tot';
 test.text3:='';
 test.text4:='';
 write(Ausr,test);
 Test.name:='Schwarzpulverbombe'; {Dient der Forschung}
 test.Zeit:=19;
 test.text1:='Schwere Besch„digungen treten auf, bei feinden';
 test.text2:='Auch hier dankt Gevatter Tot';
 test.text3:='';
 test.text4:='';
 write(Waffen,test);
 test.name:='Friedhof'; {Hygi„ne}
 test.Zeit:=20;
 test.text1:='Seuchen werden verhindert';
 test.text2:='Und das Volk findet sie Ehrenvoller';
 test.text3:='Und Gevatter Tot hat ein Zuhause';
 test.text4:='';
 write(Gebaude,test);
 test.name:='Erntewagen'; {Transport von Feldprodukten}
 test.zeit:=18;
 test.text1:='Schnellere Ernte und bessere Versorgung';
 test.text2:='Vom Feld kommte die Ernte schneller in';
 test.text3:='die Scheune';
 test.text4:='';
 write(Fahrz,test);
 test.name:='Handpumpe'; {H”here Agraprodukte}
 test.Zeit:=12;
 test.text1:='Erschlieáung neuer Brunnen';
 test.text2:='Jeder kann nun seinen eigenen Brunnen';
 test.text3:='haben';
 test.text4:='';
 write(Ausr,test);
 Test.name:='Erstes Schwarzpulvergewehr'; {Dient der Forschung}
 test.Zeit:=19;
 test.text1:='Die Angriffst„rke wird verdoppelt';
 test.text2:='Kampf mach 5 mal mehr spass';
 test.text3:='';
 test.text4:='';
 write(Waffen,test);
 test.name:='Kolonieverwaltungsgeb„ude'; {Hygi„ne}
 test.Zeit:=20;
 test.text1:='Statistiken k”nnen nun genauer erstellt werden';
 test.text2:='Todeslisten, Steuerlisten u.s.w.';
 test.text3:='';
 test.text4:='';
 write(Gebaude,test);
 test.name:='Auskunschafter'; {Transport von Feldprodukten}
 test.zeit:=18;
 test.text1:='Bessere Lanschaftsbersicht, schnelle Feinderkennung';
 test.text2:='';
 test.text3:='';
 test.text4:='';
 write(Fahrz,test);
 test.name:='Kartograph'; {H”here Agraprodukte}
 test.Zeit:=12;
 test.text1:='Landkarten k”nnen gezeichnet werden';
 test.text2:='';
 test.text3:='';
 test.text4:='';
 write(Ausr,test);
 close(Waffen);
 close(Gebaude);
 close(Fahrz);
 close(Ausr);
end.