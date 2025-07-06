*&---------------------------------------------------------------------*
*& REPORT ZFT_GET_DATA_2.
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*

*Erstellen Sie einen neuen Report. Definieren Sie im Report einen Parameter.
*Bitten Sie den Benutzer, eine Fluggesellschaft (carrid) einzugeben. Lesen
*Sie aus der Tabelle SPFLI alle Zeilen aus, bei denen die Fluggesellschaft
*mit der Benutzereingabe übereinstimmt. Zeigen Sie dem Benutzer anschließend
*eine Informationsmeldung mit der Anzahl der gelesenen Zeilen an.


REPORT ZFT_GET_DATA_2.

SELECTION-SCREEN BEGIN OF BLOCK a1 WITH FRAME TITLE TEXT-001 NO INTERVALS.

PARAMETERS: p_carrid TYPE s_carr_id.

SELECTION-SCREEN END OF BLOCK a1.

DATA: gt_spfli TYPE TABLE OF spfli,
      gv_msg TYPE string,
      gv_no TYPE n LENGTH 2.



START-OF-SELECTION.

select * from spfli
  into TABLE gt_spfli
  where carrid = p_carrid.

DESCRIBE TABLE gt_spfli LINES gv_no.

*gv_no = lines( gt_spfli ).

IF gv_no ne 0.

    shift gv_no LEFT DELETING LEADING '0'.

ENDIF.


CONCATENATE 'Anzahl der gelesenen Daten =' gv_no into gv_msg RESPECTING BLANKS.



MESSAGE gv_msg TYPE 'I'.

*BREAK-POINT.
