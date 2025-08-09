*&---------------------------------------------------------------------*
*& Report ZFT_UBUNG_27
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zft_ubung_27.


" Erklärung der Ubung: Berechne die Gesamtsekunden basierend auf den über das Dropdown-Menü ausgewählten Stunden-, Minuten- und Sekundenwerten (mit SELECTION-SCREEN).

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001.
SELECTION-SCREEN BEGIN OF LINE.

SELECTION-SCREEN COMMENT 1(4) TEXT-002.
SELECTION-SCREEN POSITION 6.
PARAMETERS: p_stnd TYPE i AS LISTBOX VISIBLE LENGTH 5.

SELECTION-SCREEN COMMENT 22(5) TEXT-003.
SELECTION-SCREEN POSITION 27.
PARAMETERS: p_mnt TYPE i AS LISTBOX VISIBLE LENGTH 5.

SELECTION-SCREEN COMMENT 45(5) TEXT-004.
SELECTION-SCREEN POSITION 50.
PARAMETERS: p_sknd TYPE i AS LISTBOX VISIBLE LENGTH 5.

SELECTION-SCREEN PUSHBUTTON 67(45) bt1 USER-COMMAND rechnen.



SELECTION-SCREEN END OF LINE.
SELECTION-SCREEN END OF BLOCK a1.


SELECTION-SCREEN BEGIN OF BLOCK a2 WITH FRAME TITLE TEXT-005 NO INTERVALS.

PARAMETERS: p_result TYPE i.

SELECTION-SCREEN END OF BLOCK a2.



INITIALIZATION.

  CALL FUNCTION 'ICON_CREATE'
    EXPORTING
      name                  = icon_calculation
      text                  = 'rechnen'
      info                  = 'Berechnet die Gesamtsekunden.'
*     ADD_STDINF            = 'X'
    IMPORTING
      result                = bt1
    EXCEPTIONS
      icon_not_found        = 1
      outputfield_too_short = 2
      OTHERS                = 3.

  IF sy-subrc IS NOT INITIAL.
    BREAK-POINT.
  ENDIF.



  PERFORM value_rechnen USING 'P_STND' 24.
  PERFORM value_rechnen USING 'P_MNT' 59.
  PERFORM value_rechnen USING 'P_SKND' 59.



AT SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    IF p_result IS INITIAL.

      IF screen-name = 'P_RESULT'.
        screen-input = '0'.
        screen-active = '0'.
        MODIFY SCREEN.
      ENDIF.

    ELSE.

      IF screen-name = 'P_RESULT'.
        screen-input = '0'.
        MODIFY SCREEN.
      ENDIF.

    ENDIF.

  ENDLOOP.

at SELECTION-SCREEN.

  CASE sy-ucomm.
    WHEN 'RECHNEN'.

      p_result = ( p_stnd * 3600 ) + ( p_mnt * 60 ) + p_sknd.

*  	WHEN OTHERS.
  ENDCASE.

FORM value_rechnen  USING    p_id
                             p_gv_number_2.


  DATA: lt_values TYPE vrm_values.
  DATA: ls_value TYPE vrm_value.
  DATA: lv_number TYPE i VALUE 1.



  DO p_gv_number_2 TIMES.

    ls_value-key = lv_number.
    ls_value-text = lv_number.
    APPEND ls_value TO lt_values.
    CLEAR: ls_value.

    ADD 1 TO lv_number.

  ENDDO.


  CALL FUNCTION 'VRM_SET_VALUES'
    EXPORTING
      id              = p_id
      values          = lt_values
    EXCEPTIONS
      id_illegal_name = 1
      OTHERS          = 2.
  IF sy-subrc IS NOT INITIAL.
    BREAK-POINT.
  ENDIF.

  lv_number = 1.

ENDFORM. 
