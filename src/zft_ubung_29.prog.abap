*&---------------------------------------------------------------------*
*& Report ZFT_UBUNG_29
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zft_ubung_29.

DATA: gv_random TYPE i.
DATA: gv_counter TYPE i VALUE 0.
DATA: gv_game_over TYPE c LENGTH 1 VALUE abap_false.
DATA: gv_gewinn TYPE c LENGTH 1 VALUE abap_false.
DATA: gv_neu TYPE c LENGTH 1 VALUE abap_false.
*DATA: gv_recht TYPE i.


SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001 NO INTERVALS.

PARAMETERS: p_input TYPE c LENGTH 3,
            p_guess TYPE c LENGTH 200,
            p_rest  TYPE i,
            p_recht TYPE i.

SELECTION-SCREEN END OF BLOCK a1.

SELECTION-SCREEN BEGIN OF BLOCK a2 WITH FRAME TITLE TEXT-002 NO INTERVALS.

SELECTION-SCREEN PUSHBUTTON 1(35) bt1 USER-COMMAND rate.
SELECTION-SCREEN PUSHBUTTON 37(50) bt2 USER-COMMAND neustarten.

SELECTION-SCREEN END OF BLOCK a2.

AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    IF screen-name = 'P_INPUT' OR screen-name = 'P_RECHT'.
      screen-color = 610.
      screen-intensified = 1.
      screen-required = 0.
      screen-input = 1.
      screen-active = 1.
      screen-required = 1.
      MODIFY SCREEN.
    ENDIF.



    IF p_guess IS INITIAL.
      IF screen-name = 'P_GUESS' OR screen-name = 'P_REST'.
        screen-input = '0'.
        screen-active = '0'.
        MODIFY SCREEN.
      ENDIF.

    ELSE.

      IF screen-name = 'P_GUESS' OR screen-name = 'P_REST'.
        screen-input = '0'.
        MODIFY SCREEN.
      ENDIF.

      IF screen-name = 'P_RECHT'.
        screen-input = '0'.
        screen-active = '0'.
        MODIFY SCREEN.
      ENDIF.

    ENDIF.

  ENDLOOP.


INITIALIZATION.

  PERFORM random.

  CALL FUNCTION 'ICON_CREATE'
    EXPORTING
      name                  = icon_search
      text                  = 'rate '
      info                  = 'um zu raten.'
*     ADD_STDINF            = 'X'
    IMPORTING
      result                = bt1
    EXCEPTIONS
      icon_not_found        = 1
      outputfield_too_short = 2
      OTHERS                = 3.
  IF sy-subrc <> 0.
    BREAK-POINT.
  ENDIF.

  CALL FUNCTION 'ICON_CREATE'
    EXPORTING
      name                  = icon_refresh
      text                  = 'Neu Starten '
      info                  = 'von Anfang'
*     ADD_STDINF            = 'X'
    IMPORTING
      result                = bt2
    EXCEPTIONS
      icon_not_found        = 1
      outputfield_too_short = 2
      OTHERS                = 3.
  IF sy-subrc <> 0.
    BREAK-POINT.
  ENDIF.



AT SELECTION-SCREEN.


  CASE sy-ucomm.
    WHEN 'RATE'.
      PERFORM rate.


    WHEN 'NEUSTARTEN'.

      gv_neu = abap_true.
      gv_counter   = 0.
      gv_game_over = abap_false.
      gv_gewinn    = abap_false.
      p_guess = ''.
*      p_rest = ' '.
      p_input = ''.
      p_recht = ''.

      PERFORM random.


  ENDCASE.

FORM rate.

  IF p_recht IS INITIAL.

    MESSAGE 'Bitte geben Sie an, wie viele Rechte Sie haben möchten.' TYPE 'S' DISPLAY LIKE 'E'.
    EXIT.

  ENDIF.

  ADD 1 TO gv_counter.

  p_rest = p_recht - gv_counter.

  IF p_input > 100.
    MESSAGE 'Bitte geben Sie eine Zahl zwischen 1 und 100 ein' TYPE 'S' DISPLAY LIKE 'E'.
    RETURN.
  ENDIF.

  IF gv_gewinn = abap_false.
    IF p_input = gv_random.
      IF gv_game_over = abap_false.
        MESSAGE 'Herzlichen Glückwunsch, Sie haben gewonnen.' TYPE 'I'.
        gv_gewinn = abap_true.
        RETURN.
      ELSE.
        MESSAGE 'Das Spiel ist vorbei, klicken Sie auf ‚Neu starten‘, um noch einmal zu versuchen.' TYPE 'I'.
      ENDIF.

    ENDIF.
  ELSE.
    MESSAGE 'Sie haben bereits gewonnen. Wenn Sie es noch einmal spielen möchten, drücken Sie den ‚Neu starten‘-Button.' TYPE 'I'.
  ENDIF.

  IF gv_gewinn = abap_false.
    IF p_input > gv_random.
      MESSAGE 'Geben Sie eine kleinere Zahl ein.' TYPE 'S'.
    ELSEIF p_input < gv_random.
      MESSAGE 'Geben Sie eine größere Zahl ein.' TYPE 'S'.
    ENDIF.
  ELSE.
    MESSAGE 'Sie haben bereits gewonnen. Wenn Sie es noch einmal spielen möchten, drücken Sie den ‚Neu starten‘-Button.' TYPE 'I'.
  ENDIF.

  IF gv_counter < p_recht.
    p_rest = p_recht - gv_counter.
    CONCATENATE p_input p_guess INTO p_guess SEPARATED BY ','.

  ELSEIF gv_counter >= p_recht.
    gv_game_over = abap_true.
    MESSAGE 'Leider haben Sie nicht gewonnen. Das Spiel ist vorbei. Drücken Sie die Schaltfläche ‚Neu starten‘, um es noch einmal zu versuchen.' TYPE 'I'.
    EXIT.
  ENDIF.

  IF p_recht < 0 AND gv_game_over = abap_true.
    MESSAGE 'Das Spiel ist vorbei' TYPE 'I'.
     endif.

ENDFORM.


FORM random.

  CALL FUNCTION 'GENERAL_GET_RANDOM_INT'
    EXPORTING
      range  = 100
    IMPORTING
      random = gv_random.


ENDFORM.
