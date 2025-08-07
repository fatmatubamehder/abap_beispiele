*&---------------------------------------------------------------------*
*& Report ZFT_UBUNG_09
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zft_ubung_09.

*Erstellen Sie einen neuen Bericht und nehmen Sie vom Benutzer eine Zahl entgegen.
*
*Außerdem sollen drei Radiobuttons vorhanden sein. Die Radiobuttons heißen:
*
*„Quadrat“
*
*„Kubik“
*
*„Hoch 4“
*
*Erstellen Sie eine neue Klasse. Die Klasse soll drei Methoden enthalten (alle Instanz-Methoden, public).
*
*Je nachdem, welcher Radiobutton vom Benutzer ausgewählt wurde, soll die entsprechende Methode aufgerufen werden, um die Potenz der eingegebenen Zahl zu berechnen und das Ergebnis auf dem Bildschirm auszugeben.
*
*(Beispiel: Wenn der Radiobutton „Quadrat“ ausgewählt ist, wird die erste Methode verwendet und das Ergebnis berechnet.)



SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001 NO INTERVALS.

PARAMETERS: p_1     TYPE i,
            p_exp_2 RADIOBUTTON GROUP abc,
            p_exp_3 RADIOBUTTON GROUP abc,
            p_exp_4 RADIOBUTTON GROUP abc.

SELECTION-SCREEN END OF BLOCK a1.

DATA: gv_result TYPE i.
DATA: go_exp TYPE REF TO zft_cl_07.

CREATE OBJECT go_exp.

START-OF-SELECTION.

  IF p_exp_2 = abap_true.

    go_exp->exp_2(
      EXPORTING
        iv_nummer =  p_1
      IMPORTING
        ev_result = gv_result ).

    MESSAGE | { p_1 } hoch 2 = { gv_result } | TYPE 'I'.

  ELSEIF p_exp_3 = abap_true.

    go_exp->exp_3(
      EXPORTING
        iv_nummer =  p_1
      IMPORTING
        ev_result = gv_result ).

    MESSAGE | { p_1 } hoch 3 = { gv_result } | TYPE 'I'.

  ELSE.

    go_exp->exp_4(
      EXPORTING
        iv_nummer =  p_1
      IMPORTING
        ev_result = gv_result ).

    MESSAGE | { p_1 } hoch 4 = { gv_result } | TYPE 'I'.

  ENDIF.






*  der inhalt vom class

*  IV_NUMMER  TYPE INT4 Natürliche Zahl
*  EV_RESULT  TYPE INT4 Natürliche Zahl

*
*  method EXP_2.
*
*    ev_result = IV_NUMMER * IV_NUMMER.
*
*  endmethod. 
