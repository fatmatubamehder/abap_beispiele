*&---------------------------------------------------------------------*
*& Report ZFT_UBUNG_10
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zft_ubung_10.

*Erstellen Sie einen neuen Bericht und nehmen Sie vom Benutzer eine Zahl entgegen.
*
*Außerdem sollen drei Radiobuttons vorhanden sein mit den Namen:
*
*„Quadrat“
*
*„Kubik“
*
*„Hoch 4“
*
*Erstellen Sie eine neue Klasse. Die Klasse soll drei Methoden enthalten, die alle static und public sind.
*
*Je nachdem, welcher Radiobutton vom Benutzer ausgewählt wurde, soll die entsprechende Methode aufgerufen werden,
*
*um die Potenz der eingegebenen Zahl zu berechnen und das Ergebnis auf dem Bildschirm auszugeben.
*
*(Beispiel: Wenn der Radiobutton „Quadrat“ ausgewählt ist, wird die erste Methode verwendet und das Ergebnis berechnet.)


PARAMETERS: p_1     TYPE i,
            p_exp_2 RADIOBUTTON GROUP abc,
            p_exp_3 RADIOBUTTON GROUP abc,
            p_exp_4 RADIOBUTTON GROUP abc.

DATA: gv_result TYPE i.

START-OF-SELECTION.


  IF p_exp_2 = abap_true.

    zft_cl_08=>exp_2(
    EXPORTING
      iv_nummer =  p_1
    IMPORTING
      ev_result =  gv_result ).

    MESSAGE | { p_1 } hoch 2 = { gv_result } | TYPE 'I'.

  ELSEIF p_exp_3 = abap_true.

    zft_cl_08=>exp_3(
   EXPORTING
     iv_nummer =  p_1
   IMPORTING
     ev_result =  gv_result ).

    MESSAGE | { p_1 } hoch 3 = { gv_result } | TYPE 'I'.

  ELSE.

    zft_cl_08=>exp_4(
    EXPORTING
    iv_nummer =  p_1
    IMPORTING
    ev_result =  gv_result ).

    MESSAGE | { p_1 } hoch 4 = { gv_result } | TYPE 'I'.

  ENDIF.




*  der inhalt vom Class

*  IV_NUMMER  TYPE INT4 Natürliche Zahl
*  EV_RESULT  TYPE INT4 Natürliche Zahl

*
*  method EXP_2.
*
*    ev_result = IV_NUMMER * IV_NUMMER.
*
*  endmethod.
