*&---------------------------------------------------------------------*
*& Report ZFT_UBUNG_44
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zft_ubung_44.

*Erstellen Sie einen neuen Report.
*Im Report sollen 3 Radiobuttons vorhanden sein.
*
*Lesen Sie alle Zeilen der Tabelle STRAVELAG und speichern Sie diese in eine interne Tabelle.
*
*Wählt der Benutzer den ersten Radiobutton, so sollen die ersten 3 Spalten der Tabelle ausgegeben werden.
*
*Wählt der Benutzer den zweiten Radiobutton, so sollen die ersten 6 Spalten ausgegeben werden.
*
*Wählt der Benutzer den dritten Radiobutton, so sollen alle Spalten ausgegeben werden.
*
*Die Schleife soll mit einem Field-Symbol durchgeführt werden.
*Das Field-Symbol soll mit dem Befehl TYPE ANY TABLE deklariert werden.


PARAMETERS : p_3   RADIOBUTTON GROUP abc,
             p_6   RADIOBUTTON GROUP abc,
             p_all RADIOBUTTON GROUP abc.


DATA: gt_stravelag TYPE TABLE OF stravelag,
      gv_number    TYPE i VALUE 1.

FIELD-SYMBOLS: <fs_table_stravelag> TYPE ANY TABLE,
               <fs_str_stravelag>   TYPE any,
               <fs_field>           TYPE any.


START-OF-SELECTION.

  ASSIGN gt_stravelag TO <fs_table_stravelag>.

  SELECT * FROM stravelag
    INTO TABLE <fs_table_stravelag>.


  IF p_3 = abap_true.

    LOOP AT <fs_table_stravelag> ASSIGNING <fs_str_stravelag>.

      WHILE gv_number <= 3.
        ASSIGN COMPONENT gv_number OF STRUCTURE <fs_str_stravelag> TO <fs_field>.
        WRITE: <fs_field>.
        ADD 1 TO gv_number.
      ENDWHILE.
      SKIP.
      gv_number = 1.

    ENDLOOP.

  ELSEIF p_6 = abap_true.

    LOOP AT <fs_table_stravelag> ASSIGNING <fs_str_stravelag>.

      WHILE gv_number <= 6.
        ASSIGN COMPONENT gv_number OF STRUCTURE <fs_str_stravelag> TO <fs_field>.
        WRITE: <fs_field>.
        ADD 1 TO gv_number.
      ENDWHILE.
      SKIP.
      gv_number = 1.

    ENDLOOP.

  ELSE.

    LOOP AT <fs_table_stravelag> ASSIGNING <fs_str_stravelag>.

      DO.

        ASSIGN COMPONENT gv_number OF STRUCTURE <fs_str_stravelag> TO <fs_field>.

        IF <fs_field> IS ASSIGNED.
          WRITE: <fs_field>.
          UNASSIGN <fs_field>.
        ELSE.
          EXIT.
        ENDIF.

        ADD 1 TO gv_number.


      ENDDO.

      gv_number = 1.


    ENDLOOP.


  ENDIF.
