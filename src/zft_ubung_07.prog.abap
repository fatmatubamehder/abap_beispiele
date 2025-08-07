*&---------------------------------------------------------------------*
*& Report ZFT_UBUNG_07
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zft_ubung_07.


*Schreiben Sie eine neue Funktion. Diese soll vom Benutzer ein Rechenzeichen (Operationssymbol) und zwei Zahlen entgegennehmen.
*
*Entsprechend dem übergebenen Symbol soll die Funktion die passende mathematische Operation ausführen und das Ergebnis dem Benutzer zurückgeben.
*
*Wenn kein Rechenzeichen übergeben wird, soll eine Exception ausgelöst werden.
*Wird ein ungültiges Rechenzeichen eingegeben, soll ebenfalls eine separate Exception ausgelöst werden.
*
*Alle Rechenoperationen sollen in eigenen Form-Routinen innerhalb der Funktion implementiert werden.
*
*Verwenden Sie diese Funktion in einem neuen Bericht (Report) und geben Sie das Ergebnis auf dem Bildschirm aus.


PARAMETERS: p_numm_1 TYPE i,
            p_numm_2 TYPE i,
            p_symb   TYPE c LENGTH 1.


DATA: gv_result TYPE i.

START-OF-SELECTION.


  CALL FUNCTION 'ZFT_FM_14'
    EXPORTING
      iv_symb           = p_symb
      iv_nummer_1       = p_numm_1
      iv_nummer_2       = p_numm_2
    IMPORTING
      ev_result         = gv_result
    EXCEPTIONS
      leeres_symbolk    = 1
      ungultiges_symbol = 2
      zero_division     = 3
      OTHERS            = 4.

  .
  IF sy-subrc = 1.
    MESSAGE 'Sie haben kein Symbol eingegeben' TYPE 'S' DISPLAY LIKE 'E'.

  ELSEIF sy-subrc = 2.

    MESSAGE 'Ungültiges Symbol' TYPE 'S' DISPLAY LIKE 'E'.

  ELSEIF sy-subrc = 3.

    MESSAGE 'Der Divisor darf nicht 0 sein' TYPE 'S' DISPLAY LIKE 'E'.

  ENDIF.

*BREAK-POINT.



*der inhalt von der Funktion

*  FUNCTION zft_fm_14.
**"----------------------------------------------------------------------
**"*"Lokale Schnittstelle:
**"  IMPORTING
**"     REFERENCE(IV_SYMB) TYPE  XFELD
**"     REFERENCE(IV_NUMMER_1) TYPE  INT4
**"     REFERENCE(IV_NUMMER_2) TYPE  INT4
**"  EXPORTING
**"     REFERENCE(EV_RESULT) TYPE  INT4
**"  EXCEPTIONS
**"      LEERES_SYMBOLK
**"      UNGULTIGES_SYMBOL
**"      ZERO_DIVISION
**"----------------------------------------------------------------------
*
*
*    IF iv_symb = '/' AND iv_nummer_2 = 0.
*
*      RAISE zero_division.
*
*    ENDIF.
*
*    IF iv_symb IS INITIAL.
*
*      RAISE leeres_symbolk.
*
*    ENDIF.
*
*    IF iv_symb = '+'.
*
*      ev_result = iv_nummer_1 + iv_nummer_2.
*
*    ELSEIF iv_symb = '-'.
*
*      ev_result = iv_nummer_1 - iv_nummer_2.
*
*    ELSEIF iv_symb = '*'.
*
*      ev_result = iv_nummer_1 * iv_nummer_2.
*
*    ELSEIF iv_symb = '/'.
*
*      ev_result = iv_nummer_1 / iv_nummer_2.
*
*    ELSE.
*
*      RAISE ungultiges_symbol.
*
*    ENDIF.
*
*    WRITE: 'Ergebnis =', ev_result.
*
*  ENDFUNCTION.
