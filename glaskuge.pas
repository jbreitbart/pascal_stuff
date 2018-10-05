PROGRAM Glaskugel;

{---------------------------------------------------------------------------
  Programm "Spiegelkugel" aus
  -  c't  1/86 S. 108
  -  c't 11/87 S. 100
  -  c't  9/88 S. 130   Abgetippt im Schwei·e meiner FÅ·e !
                        B. Kunrath  September 1988

  Es zeichnet eine Kugel, die Åber einer FlÑche schwebt.

  Beispielparameter:
  ------------------

  Kugel.........: 0/ 0/ 1.3     *  0/ 3/ 0.2            *  0/ 0/ 2.2
  Radius........: 1             *  0.2                  *  1
  Lampe.........: 28/-28/20     *  30/-40/10            *  0/-20/10
  Kamera........: 3.5/-10/4.5   *  -3/0/1.5             *  5/-15/1.3
  Blickvektor...: -3.2/8.5/-2.8 *  2.1/2/-0.8           *  -3/12/0.5
  ôffnungswinkel: 10.8/7.5      *  7/ 5                 *  10.8/7.5

  Brechungsindex:
  ---------------

  Glaskugel.....: 1.4
  Luftblasen....: 0.8
  Seifenblasen..: 1.008
 ---------------------------------------------------------------------------}

USES CRT, GRAPH;

  TYPE txtfeldtyp = ARRAY [1..10,1..10] OF BOOLEAN;
  CONST i_ = TRUE;
        FF = FALSE;
        textfeld : txtfeldtyp =
          (( FF, FF, FF, FF, FF, FF, FF, FF, FF, FF ),
           ( FF, FF, FF, i_, i_, i_, i_, FF, FF, FF ),
           ( FF, FF, i_, FF, FF, FF, FF, i_, FF, FF ),
           ( FF, FF, FF, i_, FF, FF, i_, FF, FF, FF ),
           ( FF, FF, FF, FF, FF, FF, FF, i_, i_, FF ),
           ( FF, FF, FF, FF, FF, FF, i_, FF, FF, FF ),
           ( FF, FF, FF, i_, i_, i_, i_, i_, i_, FF ),
           ( FF, FF, i_, FF, FF, FF, i_, FF, FF, FF ),
           ( FF, FF, FF, FF, FF, FF, FF, FF, FF, FF ),
           ( FF, FF, FF, FF, FF, FF, FF, FF, FF, FF ));

  CONST deg_to_rad        = 0.017453295;
  TYPE  vektor  = RECORD
                    x, y, z : REAL
                  END;
  VAR   oeffwkl_h, oeffwkl_v,           { ôffnungswinkel horiz./vert.   }
        SM_nv_lampe,                    { Skalarmultiplikation          }
        v, w, x, ma, mb, mc,            { Gleichungskoeffizienten       }
        a, b, c, d, e, f, p, q, n, o, r, u, k, y, g, h, i, l, m,
        Brechungsindex : REAL;
        Farbe, x_max, y_max,            { Max. Pixelanz. von der Mitte  }
        y_abs,                          { Abs. Bildzeilenposition       }
        Kug_li, Kug_re,                 { Linke und rechte Kugelrandpos.}
        Sch_li, Sch_re,                 { L. und R. Schattenrandpos.    }
        Kug_li_alt, Kug_re_alt : INTEGER;
        Radius, Radius_1, Radius2,       { Radius mit Kehrwert und Quad. }
        Brechungsindex2 : REAL;         { Quadrat des Brechungsindex    }
        av, bv, cv, Kugelmitte,         { konstante Vektoren            }
        mv, Kamera, nv, Lampe : vektor;
        Taste : CHAR;
        Kugeltreffer,           { Flag, ob Kugel in der akt. Zeile vorh.}
        Kug_clip_li,            { Flag, ob Kugel den L. Rand schneidet  }
        Kug_clip_re,            { Flag, ob Kugel den R. Rand schneidet  }
        KugMitte_unten,         { Flag fÅr Startbed., Kugel Åber unt. R.}
        KugAnf_unten,           { Flag, ob Kugel in der untersten Zeile }
        Schatten : BOOLEAN;     { Flag, ob Schatten in der Zeile vorh.  }
        GrTrb, GrMod : INTEGER; { Grafiktreiber und -modus              }

{------
  Funktionen
       ------}
FUNCTION tan(winkel : REAL): REAL;
BEGIN { TAN }
  tan := SIN(winkel) / COS(winkel)
END; { TAN }

FUNCTION sign(arg : INTEGER): INTEGER;
BEGIN { SIGN }
  IF (arg = 0) THEN
    sign := 0
  ELSE
    IF (arg < 0) THEN
      sign := -1
    ELSE
      sign := 1
END; { SIGN }

FUNCTION sqrt_sign(arg, sign : REAL): REAL;
BEGIN { SQRT_SIGN }
  IF (sign = 0.0) THEN
    sqrt_sign := 0.0
  ELSE
    IF (sign < 0.0) THEN
      sqrt_sign := -SQRT(arg)
    ELSE
      sqrt_sign := SQRT(arg)
END; { SQRT_SIGN }

FUNCTION limited_round(v : REAL): INTEGER;
  CONST minint = - MAXINT;
  VAR   temp : INTEGER;
BEGIN { LIMITED_ROUND }
  IF (v > maxint) THEN
    limited_round := MAXINT
  ELSE
    IF (v < minint) THEN
      limited_round := MININT
    ELSE
      IF (v < 0) THEN
        limited_round := trunc(v) - 1
      ELSE
        limited_round := trunc(v)
END; { LIMITED_ROUND }

PROCEDURE Schattenlinie(xa, y, xe : INTEGER);
  VAR  lauf : INTEGER;
BEGIN { SCHATTENLINIE }
  FOR lauf := xa + x_max to xe + x_max DO
    IF ((lauf AND 1) = (y AND 1)) THEN
      PutPixel(lauf, y, Farbe)
END; { SCHATTENLINIE }

FUNCTION v3_square(VAR vektor1 : vektor): REAL;
BEGIN { V3_SQUARE }
  WITH vektor1 DO v3_square := SQR(x) + SQR(y) + SQR(z)
END; { V3_SQUARE }

PROCEDURE v3_add(VAR vektor1, vektor2, ergebnis : vektor);
BEGIN { V3_ADD }
  WITH ergebnis DO
  BEGIN
    x := vektor1.x + vektor2.x;
    y := vektor1.y + vektor2.y;
    z := vektor1.z + vektor2.z
  END
END; { V3_ADD }

PROCEDURE v3_sub(VAR vektor1, vektor2, ergebnis : vektor);
BEGIN { V3_SUB }
  WITH ergebnis DO
  BEGIN
    x := vektor1.x - vektor2.x;
    y := vektor1.y - vektor2.y;
    z := vektor1.z - vektor2.z
  END
END; { V3_SUB }

PROCEDURE v3_r_mult(VAR vektor1 : vektor; faktor : REAL);
BEGIN { V3_R_MULT }
  WITH vektor1 DO
  BEGIN
    x := x * faktor;
    y := y * faktor;
    z := z * faktor
  END
END; { V3_R_MULT }

FUNCTION v3_skalarmult(VAR vektor1, vektor2 : vektor): REAL;
BEGIN { V3_SKALARMULT }
  WITH vektor1 DO
    v3_skalarmult := x * vektor2.x + y * vektor2.y + z * vektor2.z
END; { V3_SKALARMULT }

PROCEDURE Muster(s : INTEGER; x, y : REAL);
  VAR xi, yi : INTEGER;
BEGIN { MUSTER }
  xi := limited_ROUND(x);
  yi := limited_ROUND(y);
  IF (ODD(xi) = ODD(yi)) THEN
    PutPixel(s + x_max, y_abs, Farbe)
  ELSE
    IF (yi = 3) THEN
      IF (xi = 0) THEN
        IF textfeld[trunc(x * 10) + 1, trunc((y - 3.0) * 10) + 1] THEN
          PutPixel(s + x_max, y_abs, Farbe)
END; { MUSTER }

PROCEDURE Kugelrand(zeile : INTEGER);
  VAR di, temp1, temp2, Kug_li_real, Kug_re_real : REAL;
BEGIN { KUGELRAND }
  temp1 := d + c * zeile;
  di := SQR(temp1) - a * (zeile * (zeile * b + e) + f);
  IF (di < 0.0) THEN
    Kugeltreffer := FALSE
  ELSE
    BEGIN
      temp2 := sqrt_sign(di, a);
      Kug_li_real := (temp1 - temp2) / a;
      Kug_re_real := (temp1 + temp2) / a;
      Kug_clip_li := (Kug_li_real * ma + zeile * mb + mc) <= 0.0;
      Kug_clip_re := (Kug_re_real * ma + zeile * mb + mc) <= 0.0;
      Kug_li := limited_ROUND(Kug_li_real);
      Kug_re := limited_ROUND(Kug_re_real);
      IF NOT (Kug_clip_li OR Kug_clip_re) THEN
        IF ((Kug_li > x_max) OR (Kug_re < -x_max)) THEN
          Kugeltreffer := FALSE
        ELSE
        BEGIN
          IF (Kug_li < -x_max) THEN
          BEGIN
            Kug_li := -x_max;
            Kug_clip_li := TRUE
          END;
          IF (Kug_re > x_max) THEN
          BEGIN
            Kug_re := x_max;
            Kug_clip_re := TRUE
          END;
          Kugeltreffer := TRUE
        END
      ELSE
        IF NOT Kug_clip_li THEN
          IF (Kug_li < -x_max) THEN
            Kugeltreffer := FALSE
          ELSE
          BEGIN
            Kug_clip_re := (Kug_li > x_max);
            IF NOT Kug_clip_re THEN
            BEGIN
              Kug_re := Kug_li;
              Kug_li := -x_max
            END
            ELSE
            BEGIN
              Kug_li := -x_max;
              Kug_re := x_max
            END;
            Kug_clip_li := TRUE;
            Kugeltreffer := TRUE
          END
        ELSE
          IF Kug_clip_re THEN
            Kugeltreffer := FALSE
          ELSE
            IF (Kug_re > x_max) THEN
              Kugeltreffer := FALSE
            ELSE
            BEGIN
              Kug_clip_li := (Kug_re < -x_max);
              IF NOT Kug_clip_li THEN
              BEGIN
               Kug_li := Kug_re;
               Kug_re := x_max
              END;
              BEGIN
               Kug_li := -x_max;
               Kug_re := x_max
              END;
              Kug_clip_re := TRUE;
              Kugeltreffer := TRUE
            END
    END
END; { KUGELRAND }

PROCEDURE Schattenrand(zeile : INTEGER);
  VAR   di, temp1, temp2, Sch_li_real, Sch_re_real : REAL;
BEGIN { SCHATTENRAND }
  temp1 := q + zeile * p;
  di := SQR(temp1) - n * (zeile * (zeile * o + r) + u);
  IF (di < 0.0) THEN
    Schatten := FALSE
  ELSE
  BEGIN
    temp2 := sqrt_sign(di, n);
    Sch_li_real := (temp1 - temp2) / n;
    Sch_re_real := (temp1 + temp2) / n;
    Kug_clip_li := (Sch_li_real * v + zeile * w + x) >= 0.0;
    Kug_clip_re := (Sch_re_real * v + zeile * w + x) >= 0.0;
    Sch_li := limited_ROUND(Sch_li_real);
    Sch_re := limited_ROUND(Sch_re_real);
    IF NOT (Kug_clip_li OR Kug_clip_re) THEN
    BEGIN
      IF ((Sch_li > x_max) OR (Sch_re < -x_max)) THEN
        Schatten := FALSE
      ELSE
      BEGIN
        IF (Sch_li < -x_max) THEN
          Sch_li := -x_max;
        IF (Sch_re > x_max) THEN
          Sch_re := x_max;
        Schatten := TRUE
      END
    END
    ELSE
    IF NOT Kug_clip_li THEN
    BEGIN
      Schatten := (Sch_li >= -x_max);
      IF Schatten THEN
      BEGIN
        IF (Sch_li > x_max) THEN
          Sch_re := x_max
        ELSE
          Sch_re := Sch_li;
        Sch_li := -x_max;
      END
    END
    ELSE
    BEGIN
      Schatten := NOT Kug_clip_re;
      IF NOT Kug_clip_re THEN
        IF (Sch_re > x_max) THEN
          Schatten := FALSE
      ELSE
      BEGIN
        IF (Sch_re < -x_max) THEN
          Sch_li := -x_max
        ELSE
          Sch_li := Sch_re;
        Sch_re := x_max;
      END
    END
  END
END; { SCHATTENRAND }

PROCEDURE Zeichnung;
  VAR zeile : INTEGER;

  PROCEDURE Kugelinneres;
    LABEL 99;
    VAR s: INTEGER;
        wurz_bruch, j, SM_rv_bv, temp1, temp2, temp3 : REAL;
        pv, rv, zv : vektor;
  BEGIN { KUGELINNERES }
    FOR s := Kug_li + 1 TO Kug_re - 1 DO
    BEGIN
      zv := bv;
      v3_r_mult(zv, zeile);
      v3_add(zv, cv, zv);
      zv.x := zv.x + s * av.x;
      zv.y := zv.y + s * av.y;
      temp1 := v3_square(zv);
      temp2 := v3_skalarmult(mv, zv);
      j := (temp2 - SQRT(SQR(temp2) - temp1 * y)) / temp1;
      pv := zv;
      v3_r_mult(pv, j);
      v3_add(pv, Kamera, pv);
  {-- Kugeleintritt --}
      v3_sub(Kugelmitte, pv, rv);
      v3_r_mult(zv, Radius/SQRT(temp1));
      SM_rv_bv := v3_skalarmult(rv, zv)/Radius2;
      temp3 := Brechungsindex2 + SQR(SM_rv_bv) - 1.0;
      IF temp3 < 0.0 THEN
      BEGIN    { kein Strahleintritt, Totalreflexion }
        v3_r_mult(rv, 2.0 * SM_rv_bv);
        v3_sub(zv, rv, zv);
        zv.z := 1.0;         {  dadurch wird strahl nach oben gelenkt  }
      END
      ELSE
      BEGIN    { Brechung durch Kugel }
        v3_sub(rv, zv, zv);
        wurz_bruch := 1.0/(SQRT(temp3) - SM_rv_bv + 1.0);
        v3_r_mult(zv, wurz_bruch);
        v3_sub(rv, zv, zv);
  {-- hinteren Kugeltreffpunkt berechnen --}
        v3_r_mult(zv, 2.0 * v3_skalarmult(rv, zv)/
          SQR(wurz_bruch * Brechungsindex * Radius));
        v3_add(pv, zv, pv);
  {-- Kugelaustritt --}
        v3_sub(pv, Kugelmitte, rv);
        v3_r_mult(zv, Radius/SQRT(v3_square(zv)));
        SM_rv_bv := v3_skalarmult(rv,zv)/Radius2;
        v3_sub(rv, zv, zv);
        temp3 := 1.0/Brechungsindex2 + SQR(SM_rv_bv) - 1.0;
        IF temp3 < 0.0 THEN
          GOTO 99;                      {  kein Strahlaustritt   }
        v3_r_mult(zv, 1.0/(SQRT(temp3) - SM_rv_bv + 1.0));
        v3_sub(rv, zv, zv);
      END;
      IF (zv.z < 0.0) THEN
      BEGIN
        j := -pv.z /zv.z;
        pv.x := pv.x + j * zv.x;
        pv.y := pv.y + j * zv.y;
        IF ((pv.x * nv.x + pv.y * nv.y) < SM_nv_Lampe) THEN
          Muster(s, pv.x, pv.y)
        ELSE
          IF ((pv.x * (pv.x * g + k) + pv.y * (pv.y * h + l) +
               pv.x * pv.y * i + m) < 0.0) THEN
            Muster(s, pv.x, pv.y)
          ELSE
            Schattenlinie(s, y_abs, s);
      END;

  99: END
  END; { KUGELINNERES }

  PROCEDURE Ebene;
    VAR px_k1, px_k2, py_k1, py_k2, temp : REAL;

    PROCEDURE Ebenenmuster(von, bis : REAL);
      VAR s : INTEGER;

      BEGIN { EBENENMUSTER }
        FOR s := ROUND(von) TO ROUND(bis) DO
          Muster(s, s * px_k1 + px_k2, s * py_k1 + py_k2)
      END; { EBENENMUSTER }
  BEGIN { EBENE }
    temp := zeile * bv.z + cv.z;
    px_k1 := - Kamera.z * av.x / temp;
    px_k2 := (Kamera.x - Kamera.z * (zeile * bv.x + cv.x)/temp);
    py_k1 := - Kamera.z * av.y / temp;
    py_k2 := (Kamera.y - Kamera.z * (zeile * bv.y + cv.y)/temp);
    Schattenrand(zeile);
    IF NOT (Kugeltreffer OR Schatten) THEN
      Ebenenmuster(-x_max, x_max)
    ELSE
    BEGIN
      IF NOT Kugeltreffer THEN
      BEGIN
        IF (Sch_li > -x_max) THEN
          Ebenenmuster(-x_max, Sch_li - 1);
        IF (Sch_re < x_max) THEN
          Ebenenmuster(Sch_re+1, x_max);
        Schattenlinie(Sch_li, y_abs, Sch_re)
      END
      ELSE
        IF NOT Schatten THEN
        BEGIN
          IF (Kug_li > -x_max) THEN
            Ebenenmuster(-x_max, Kug_li - 1);
          IF (Kug_re < x_max) THEN
            Ebenenmuster(Kug_re+1, x_max);
        END
        ELSE
          IF (Sch_re < (Kug_li - 1)) THEN
          BEGIN
            IF (Sch_li > -x_max) THEN
              Ebenenmuster(-x_max, Sch_li-1);
            Ebenenmuster(Sch_re + 1, Kug_li - 1);
            IF (Kug_re < x_max) THEN
              Ebenenmuster(Kug_re + 1, x_max);
            Schattenlinie(Sch_li, y_abs, Sch_re)
          END
          ELSE
            IF (Sch_li > (Kug_re+1)) THEN
            BEGIN
              IF (Kug_li > -x_max) THEN
                Ebenenmuster(-x_max, Kug_li-1);
              Ebenenmuster(Kug_re + 1, Sch_li - 1);
              IF (Sch_re < x_max) THEN
                Ebenenmuster(Sch_re + 1, x_max);
              Schattenlinie(Sch_li, y_abs, Sch_re)
            END
            ELSE
            BEGIN
              IF (Kug_li > Sch_li) THEN
              BEGIN
                IF (Sch_li > -x_max) THEN
                  Ebenenmuster(-x_max, Sch_li - 1);
                Schattenlinie(Sch_li, y_abs, Kug_li)
              END
              ELSE
                IF (Kug_li > -x_max) THEN
                  Ebenenmuster(-x_max, Kug_li-1);
              IF (Sch_re > Kug_re) THEN
              BEGIN
                Schattenlinie(Kug_re, y_abs, Sch_re);
                IF (Sch_re < x_max) THEN
                  Ebenenmuster(Sch_re + 1, x_max)
              END
              ELSE
                IF (Kug_re < x_max) THEN
                  Ebenenmuster(Kug_re + 1, x_max)
            END
    END
  END; { EBENE }

BEGIN { ZEICHNUNG }
  zeile := -y_max - 1;
  Kugelrand(zeile);
  KugMitte_unten := Kugeltreffer;
  KugAnf_unten := NOT Kugeltreffer;
  FOR zeile := -y_max TO y_max DO
  BEGIN
    y_abs := y_max - zeile;
    Kug_li_alt := Kug_li;
    Kug_re_alt := Kug_re;
    Kugelrand(zeile);
    IF NOT Kugeltreffer THEN
    BEGIN
      IF KugMitte_unten THEN
        Line(Kug_li_alt + x_max, y_abs, Kug_re_alt + x_max, y_abs)
    END
    ELSE
      IF KugAnf_unten THEN
      BEGIN
        Line(Kug_li + x_max, y_abs, Kug_re + x_max, y_abs);
        KugAnf_unten := FALSE
      END
      ELSE
      BEGIN
        IF (Kug_re - Kug_li) >= 2 THEN
          Kugelinneres;
        IF (Kug_li_alt <> Kug_li) THEN
          Line(Kug_li_alt + sign(Kug_li - Kug_li_alt) + x_max, y_abs,
               Kug_li + x_max, y_abs)
        ELSE
          IF NOT Kug_clip_li THEN
            PutPixel(Kug_li + x_max, y_abs, Farbe);
        IF (Kug_re_alt <> Kug_re) THEN
          Line(Kug_re_alt + sign(Kug_re - Kug_re_alt) + x_max, y_abs,
               Kug_re + x_max, y_abs)
        ELSE
          IF NOT Kug_clip_re THEN
            PutPixel(Kug_re + x_max, y_abs, Farbe)
      END;
      KugMitte_unten := Kugeltreffer;
      IF (zeile < (-cv.z/bv.z)) THEN
        Ebene
  END;
  Write(CHR(7), CHR(7));
  REPEAT UNTIL KEYPRESSED
END; { ZEICHNUNG }

PROCEDURE Skizze;
  VAR akt_zeile, y_horizont : INTEGER;

BEGIN { SKIZZE }
  y_horizont := round(-cv.z/bv.z);
  IF (y_horizont < -y_max) THEN
    y_horizont := -y_max
  ELSE
  BEGIN
    IF (y_horizont > y_max) THEN
      y_horizont := y_max
    ELSE
      Line(0, y_max - y_horizont, GetMaxX, y_max - y_horizont);
    FOR akt_zeile := -y_max TO y_horizont DO
    BEGIN
      y_abs := y_max - akt_zeile;
      Kugelrand(akt_zeile);
      IF Kugeltreffer THEN
      BEGIN
        PutPixel(Kug_li + x_max, y_abs, Farbe);
        PutPixel(Kug_re + x_max, y_abs, Farbe)
      END;
      Schattenrand(akt_zeile);
      IF Schatten THEN
      BEGIN
        PutPixel(Sch_li + x_max, y_abs, Farbe);
        PutPixel(Sch_re + x_max, y_abs, Farbe)
      END;
    END;
  END;
  FOR akt_zeile := y_horizont TO y_max DO
  BEGIN
    y_abs := y_max - akt_zeile;
    Kugelrand(akt_zeile);
    IF Kugeltreffer THEN
    BEGIN
      PutPixel(Kug_li + x_max, y_abs, Farbe);
      PutPixel(Kug_re + x_max, y_abs, Farbe)
    END
  END;
  REPEAT UNTIL KEYPRESSED
END; { SKIZZE }

PROCEDURE hole_Parameter;
  VAR Fehler : INTEGER;

  PROCEDURE v3_READ(VAR vektor : vektor);
  BEGIN
    with vektor DO READLN(x, y, z)
  END;
BEGIN { HOLE_PARAMETER }
  GrTrb := 0;
  InitGraph(GrTrb, GrMod, '');
  Fehler := GraphResult;
  IF (Fehler <> 0) THEN
  BEGIN
    WRITELN('*** Grafik - Fehler Nr. ', Fehler);
    HALT;
  END;
  CASE GrTrb OF
    CGA :             GrMod := CGAHi;
    MCGA :            GrMod := MCGAHi;
    EGA, EGA64 :      GrMod := EGAHi;
    EGAMono, ATT400 : GrMod := EGAMonoHi;
    HercMono :        GrMod := HercMonoHi;
    VGA :             GrMod := VGAHi;
  END;
  TextMode(C80);
  Farbe := 2;
  SetColor(Farbe);
  SetBKColor(0);
  ClrScr;
  x_max := GetMaxX - ((GetMaxX+1) DIV 2);
  y_max := GetMaxY - ((GetMaxY+1) DIV 2);
  WRITELN('Kugelparameter:');
  WRITE('Der Mittelpunkt (xyz): ');
  v3_READ(Kugelmitte);
  WRITE('Der Radius ..........: ');
  READLN(Radius);
  Radius2 := SQR(Radius);
  Radius_1 := 1.0/Radius;
  WRITELN;
  WRITE('Koordinaten der Lampe  (xyz): ');
  v3_READ(Lampe);
  WRITE('Koordinaten der Kamera (xyz): ');
  v3_READ(Kamera);
  WRITE('Der Blickvektor (xyz) ......: ');
  v3_READ(cv);
  WRITE('Die ôffnungswinkel (hv) ....: ');
  READLN(oeffwkl_h, oeffwkl_v);
  WRITE('Brechungsindex n ...........: ');
  READLN(Brechungsindex);
END; { HOLE_PARAMETER }

PROCEDURE berechne_Programmkonstanten;
  VAR t1, t2, t3, t4, t5, t6 : REAL;

  PROCEDURE berechne_Pixelvektoren_av_bv;
    VAR av_betrag, bv_betrag : REAL;
  BEGIN
    oeffwkl_h := oeffwkl_h * deg_to_rad;
    oeffwkl_v := oeffwkl_v * deg_to_rad;
    av.x := cv.y;
    av.y := -cv.x;
    bv.x := -cv.x * cv.z;
    bv.y := -cv.y * cv.z;
    bv.z := SQR(cv.y) + SQR(cv.x);
    av_betrag := SQRT(1.0 + SQR(cv.z)/bv.z)/((GetMaxX + 1) DIV 2) *
                 tan(oeffwkl_h);
    av.x := av_betrag * av.x;
    av.y := av_betrag * av.y;
    bv_betrag := 1.0/SQRT(bv.z)/((GetMaxY + 1) DIV 2) * tan(oeffwkl_v);
    v3_r_mult(bv, bv_betrag);
  END;

BEGIN { BERECHNE_PROGRAMMKONSTANTEN }
  Brechungsindex2 := SQR(Brechungsindex);
  berechne_Pixelvektoren_av_bv;
  v3_sub(Kugelmitte, Lampe, nv);
  SM_nv_Lampe := v3_skalarmult(nv, Lampe);
  t1 := v3_square(nv) - Radius2;
  g := nv.x * nv.x-t1;
  h := nv.y * nv.y-t1;
  i := 2.0 * nv.x * nv.y;
  k := 2.0 * (Lampe.x * t1 - SM_nv_Lampe * nv.x);
  l := 2.0 * (Lampe.y * t1 - SM_nv_Lampe * nv.y);
  m := SQR(SM_nv_Lampe) - t1 * v3_square(Lampe);
  t1 := -av.x * Kamera.z;
  t2 := bv.z * Kamera.x - bv.x * Kamera.z;
  t3 := cv.z * Kamera.x - cv.x * Kamera.z;
  t4 := -av.y * Kamera.z;
  t5 := bv.z * Kamera.y - bv.y * Kamera.z;
  t6 := cv.z * Kamera.y - cv.y * Kamera.z;
  n := g * SQR(t1) + h * SQR(t4) + i * t1 * t4;
  o := g * SQR(t2) + h * SQR(t5) + i * t2 * t5 + k * t2 * bv.z;
  p := 2.0 * (g * t1 * t2 + h * t4 * t5) + i * (t1 * t5 + t2 * t4) + k * t1 * bv.z;
  q := 2.0 * (g * t1 * t3 + h * t4 * t6) + i * (t1 * t6 + t3 * t4) + k * t1 * cv.z;
  r := 2.0 * (g * t2 * t3 + h * t5 * t6) + i * (t2 * t6 + t3 * t5) + k * (t2 * cv.z + t3 * bv.z);
  u := g * SQR(t3) + h * SQR(t6) + i * t3 * t6 + k * t3 * cv.z;
  o := o + l * t5 * bv.z + m * bv.z * bv.z;
  p := p + l * t4 * bv.z;
  q := q + l * t4 * cv.z;
  r := r + l * (t5 * cv.z * t6 * bv.z) + m * bv.z * cv.z * 2.0;
  u := u + (l * t6 + m * cv.z) * cv.z;
  p := -0.5 * p;
  q := -0.5 * q;
  v := t1 * nv.x + t4 * nv.y;
  w := t1 * nv.x + t5 * nv.y - bv.z * SM_nv_Lampe;
  x := t3 * nv.x + t6 * nv.y - cv.z * SM_nv_Lampe;
  v3_sub(Kugelmitte, Kamera, mv);
  ma := mv.x * av.x + mv.y * av.y;
  mb := v3_skalarmult(mv, bv);
  mc := v3_skalarmult(mv, cv);
  y := v3_square(mv) - Radius2;
  a := ma * ma - y * (SQR(av.x) + SQR(av.y));
  b := mb * mb - y * v3_square(bv);
  c := -ma * mb;
  d := -ma * mc;
  e := 2.0 * mb * mc;
  f := SQR(mc) -y * v3_square(cv)
END; { BERECHNE_PROGRAMMKONSTANTEN }

BEGIN { GLASKUGEL }
  hole_Parameter;
  berechne_Programmkonstanten;
  WRITELN;
  WRITE ('<S>kizze oder <Z>eichnung ? : ');
  Taste := Upcase(ReadKey);
  SetGraphMode(GrMod);
  IF (Taste = 'Z') THEN
    Zeichnung
  ELSE
    Skizze;
  TextMode(C80);
END. { GLASKUGEL }
