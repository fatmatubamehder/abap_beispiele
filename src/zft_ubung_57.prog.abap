*&---------------------------------------------------------------------*
*& Report ZFT_UBUNG_57
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zft_ubung_57.


"Vom Benutzer einen Datenbanktabellennamen abfragen und diese Tabelle auswählen.


PARAMETERS: p_table TYPE tabname.

DATA: gr_data TYPE REF TO data.


START-OF-SELECTION.

  DATA(go_obj) = NEW zft_dynamic_table_sel( ).

go_obj->get_table(
  EXPORTING
    iv_tabname =    p_table
  IMPORTING
    et_data    = gr_data ).


ASSIGN gr_data->* to FIELD-SYMBOL(<fs_table>).

BREAK-POINT.
