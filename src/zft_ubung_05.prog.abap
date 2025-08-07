*&---------------------------------------------------------------------*
*& Report ZFT_UBUNG_05
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZFT_UBUNG_05.  

*Erstellen Sie einen neuen Bericht und nehmen Sie einen Parameter vom Benutzer entgegen (eine Zahl und zwei Radiobuttons).
*Die Radiobuttons sollen mit „Quadrat“ und „Kubik“ (bzw. „Karesi“ und „Küpü“) beschriftet sein.
*
*Je nachdem, welchen Radiobutton der Benutzer auswählt, soll das entsprechende Ergebnis berechnet und auf dem Bildschirm angezeigt werden.
*
*Die Berechnung des Quadrats und des Kubiks der eingegebenen Zahl soll in jeweils einem eigenen Formular (bzw. separaten Formularen) durchgeführt werden.


PARAMETERS: p_1 TYPE i,
            p_kare RADIOBUTTON GROUP abc,
            p_kup RADIOBUTTON GROUP abc.


data: gv_result TYPE i.

START-OF-SELECTION.

IF p_kare = abap_true.

  perform kare.

  else.

  perform kup.

ENDIF.

perform display.

FORM kare.

  gv_result = p_1 * p_1.

ENDFORM.

FORM kup.

  gv_result = p_1 * p_1 * p_1.

ENDFORM.

FORM display .

    write: 'Ergebnis = ' , gv_result.

ENDFORM.
