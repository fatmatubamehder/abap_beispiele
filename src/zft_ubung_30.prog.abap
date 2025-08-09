*&---------------------------------------------------------------------*
*& Report ZFT_UBUNG_30
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zft_ubung_30.


*Erstellen Sie einen neuen Report und erfassen Sie vom Benutzer in einer einzigen Zelle einen Text.
*Erstellen Sie außerdem zwei Parameter mit den Bezeichnungen „Von oben nach unten“ und „Von rechts nach links“.
*Im Report soll der vom Benutzer eingegebene Text entweder untereinander (bei Auswahl „Von oben nach unten“)
*oder nebeneinander von rechts nach links (bei Auswahl „Von rechts nach links“) ausgegeben werden.


PARAMETERS: p_text  TYPE string,
            p_right RADIOBUTTON GROUP abc,
            p_oben  RADIOBUTTON GROUP abc.

DATA: gv_length TYPE i.
DATA: gv_number TYPE i.
DATA: gv_text_2 TYPE string.


START-OF-SELECTION.

  gv_length = strlen( p_text ).

  IF p_right = abap_true.
    gv_number = gv_length.

    DO gv_length TIMES.
      gv_number = gv_number - 1.

      CONCATENATE gv_text_2 p_text+gv_number(1) INTO gv_text_2.
    ENDDO.
    WRITE: gv_text_2.

  ELSE.

    DO gv_length TIMES.
      gv_text_2 = p_text+gv_number(1).
      gv_number = gv_number + 1.
      WRITE: gv_text_2.
      SKIP.
      clear: gv_text_2.
    ENDDO.

  ENDIF. 
