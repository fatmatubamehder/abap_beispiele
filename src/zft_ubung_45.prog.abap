*&---------------------------------------------------------------------*
*& Report ZFT_UBUNG_45
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zft_ubung_45.

*
*Erstellen Sie einen neuen Report.
*Im Report sollen 2 Radiobuttons vorhanden sein.
*
*Wählt der Benutzer den ersten Radiobutton, so sollen alle Zeilen der Tabelle ZFT_SAP04_EMP gelesen und in eine interne Tabelle gespeichert werden.
*
*Wählt der Benutzer den zweiten Radiobutton, so sollen alle Zeilen der Tabelle ZFT_SAP04_HLD gelesen und in eine interne Tabelle gespeichert werden.
*
*Der SELECT-Befehl soll nur einmal verwendet werden.
*
*Definieren Sie ein Field-Symbol mit dem Befehl TYPE ANY TABLE und weisen Sie die interne Tabelle diesem Field-Symbol zu.
*
*Durchlaufen Sie die interne Tabelle über das Field-Symbol und geben Sie alle Spalten auf dem Bildschirm aus.


PARAMETERS: p_1 RADIOBUTTON GROUP abc,
            p_2 RADIOBUTTON GROUP abc.

DATA: gt_table_emp TYPE TABLE OF zft_sap04_emp,
      gt_table_hld TYPE TABLE OF zft_sap04_hld,
      gv_name      TYPE tabname,
      gv_number    TYPE i VALUE 1.

FIELD-SYMBOLS: <fs_table> TYPE ANY TABLE,
               <fs_str>   TYPE any,
               <fs_field> TYPE any.

START-OF-SELECTION.

  IF p_1 = abap_true.
    gv_name = 'ZFT_SAP04_EMP'.
    ASSIGN gt_table_emp TO <fs_table>.
  ELSE.
    ASSIGN gt_table_hld TO <fs_table>.
    gv_name = 'ZFT_SAP04_HLD'.
  ENDIF.

  SELECT * FROM (gv_name)
    INTO TABLE <fs_table>.


  LOOP AT <fs_table> ASSIGNING <fs_str>.

    DO.
      ASSIGN COMPONENT gv_number OF STRUCTURE <fs_str> TO <fs_field>.
      IF <fs_field> IS ASSIGNED.
        WRITE: <fs_field>.
        UNASSIGN <fs_field>.
      ELSE.
        EXIT.
      ENDIF.
      ADD 1 TO gv_number.
    ENDDO.

    gv_number = 1.
    skip.

  ENDLOOP.
