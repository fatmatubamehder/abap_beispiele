*&---------------------------------------------------------------------*
*& Report ZFT_UBUNG_08
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZFT_UBUNG_08.

*Schreiben Sie eine neue Funktion. Diese soll vom Benutzer einen Wochentag (als Text) und eine Zahl entgegennehmen.
*
*Die Funktion soll berechnen, welcher Wochentag es sein wird, wenn man so viele Tage zum eingegebenen Tag hinzuzählt, wie vom Benutzer angegeben wurde.
*
*Geben Sie das Ergebnis an den Benutzer zurück.
*
*Verwenden Sie diese Funktion in einem neuen Bericht (Report) und geben Sie das Ergebnis auf dem Bildschirm aus.



SELECTION-SCREEN BEGIN OF BLOCK A1 WITH FRAME TITLE TEXT-001 NO INTERVALS.
PARAMETERS: p_tag TYPE c LENGTH 20.
PARAMETERS: p_nummer TYPE i.
SELECTION-SCREEN END OF BLOCK A1.

data: gv_tag2 TYPE c LENGTH 20.

TRANSLATE p_tag TO UPPER CASE.

CALL FUNCTION 'ZFT_FM_15'
  EXPORTING
    iv_tag              = p_tag
    iv_nummer           = p_nummer
 IMPORTING
   EV_TAG              = gv_tag2
 EXCEPTIONS
   GECERSIZ_VERI       = 1
   OTHERS              = 2
          .
IF sy-subrc <> 0.
 MESSAGE 'Gecersiz veri girdiniz' TYPE 'S' DISPLAY LIKE 'E'.
ENDIF.


*BREAK-POINT.

*der Inhalt von der Funktion


*FUNCTION ZFT_FM_15.
*"----------------------------------------------------------------------
*"*"Lokale Schnittstelle:
*"  IMPORTING
*"     REFERENCE(IV_TAG) TYPE  CHAR20
*"     REFERENCE(IV_NUMMER) TYPE  INT4
*"  EXPORTING
*"     REFERENCE(EV_TAG) TYPE  CHAR20
*"  EXCEPTIONS
*"      GECERSIZ_VERI
*"----------------------------------------------------------------------


*data: gv_tagnm TYPE i,
*      gv_tagnm2 TYPE i.
*
*CASE IV_TAG.
*  WHEN 'SONNTAG'.
*    gv_tagnm = 0.
*  WHEN 'MONTAG'.
*    gv_tagnm = 1.
*  WHEN 'DIENSTAG'.
*    gv_tagnm = 2.
*  WHEN 'MITTWOCH'.
*    gv_tagnm = 3.
*  WHEN 'DONNERSTAG'.
*    gv_tagnm = 4.
*   WHEN 'FREITAG'.
*    gv_tagnm = 5.
*   WHEN 'SAMSTAG'.
*    gv_tagnm = 6.
*  WHEN OTHERS.
*    RAISE GECERSIZ_VERI.
*ENDCASE.
*
*
*gv_tagnm2 = gv_tagnm + IV_NUMMER.
*
*gv_tagnm2 = gv_tagnm2 mod 7.
*
*CASE gv_tagnm2.
*  WHEN 0.
*    EV_TAG = 'SONNTAG'.
*  WHEN 1.
*    EV_TAG = 'MONTAG'.
*  WHEN 2.
*    EV_TAG = 'DIENSTAG'.
*   WHEN 3.
*    EV_TAG = 'MITTWOCH'.
*    WHEN 4.
*    EV_TAG = 'DONNERSTAG'.
*    WHEN 5.
*    EV_TAG = 'FREITAG'.
*    WHEN 6.
*    EV_TAG = 'SAMSTAG'.
*  WHEN OTHERS.
*    RAISE GECERSIZ_VERI.
*ENDCASE.
*
*
*write: EV_TAG.
*
*ENDFUNCTION.
