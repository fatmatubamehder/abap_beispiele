*&---------------------------------------------------------------------*
*& Report ZFT_UBUNG_34
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZFT_UBUNG_34.


*zwei Datumsfelder nebeneinander auf der Selection Screen,
*
*ein Button „Berechnen“, der ohne Verlassen der Selection Screen die Differenz in Tagen in Zelle 3 schreibt,
*
*das Mitteldatum in Zelle 4 (ebenfalls nebeneinander),
*
*Zelle 3 und 4 sind nur sichtbar, wenn sie Werte haben.


SELECTION-SCREEN BEGIN OF BLOCK A1 WITH FRAME TITLE TEXT-001 NO INTERVALS.

  SELECTION-SCREEN BEGIN OF LINE.

    SELECTION-SCREEN COMMENT 1(8) TEXT-002.
    SELECTION-SCREEN POSITION 10.

    PARAMETERS: p_dat_1 TYPE datum.

    SELECTION-SCREEN COMMENT 25(8) TEXT-003.
    SELECTION-SCREEN POSITION 33.

    PARAMETERS: p_dat_2 TYPE datum.

  SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN END OF BLOCK a1.

SELECTION-SCREEN BEGIN OF BLOCK A2 WITH FRAME TITLE TEXT-004 NO INTERVALS.

  SELECTION-SCREEN BEGIN OF LINE.

    SELECTION-SCREEN COMMENT 1(8) TEXT-005.
    SELECTION-SCREEN POSITION 10.

    PARAMETERS: p_anzahl TYPE i.

    SELECTION-SCREEN COMMENT 26(8) TEXT-006.
    SELECTION-SCREEN POSITION 34.

    PARAMETERS: p_mitte TYPE datum.

  SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN END OF BLOCK a2.



at SELECTION-SCREEN OUTPUT.

LOOP AT SCREEN.

      IF p_anzahl is INITIAL.
        IF screen-name = 'P_ANZAHL' or screen-name = '%C005012_1000'.
           screen-active = '0'.
        ENDIF.
      ELSE.
        IF screen-name = 'P_ANZAHL'.
           screen-input  = '0'.
        ENDIF.
      ENDIF.

     IF p_mitte is INITIAL.
        IF screen-name = 'P_MITTE' or screen-name = '%C006015_1000'.
           screen-active = '0'.
        ENDIF.
      ELSE.
        IF screen-name = 'P_MITTE'.
           screen-input  = '0'.
        ENDIF.
      ENDIF.
    MODIFY SCREEN.

    ENDLOOP.

at SELECTION-SCREEN.

  p_anzahl = p_dat_2 - p_dat_1.

  p_mitte  = p_dat_1 + ( p_anzahl / 2 ). 





*  BREAK-POINT.
