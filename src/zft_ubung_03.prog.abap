*&---------------------------------------------------------------------*
*& Report ZFT_UBUNG_03_
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zft_ubung_03.

*
*Erstellen Sie einen neuen Report und definieren Sie zwei Parameter, beide vom Typ CARRID.
*Übertragen Sie die vom Benutzer eingegebenen Werte mithilfe des Befehls TYPE RANGE in eine Select-Options-Struktur.
*Verwenden Sie diese Struktur, um Datensätze aus der Tabelle SPFLI zu lesen und auf dem Bildschirm anzuzeigen.


PARAMETERS: p_carr_1 TYPE s_carr_id,
            p_carr_2 TYPE s_carr_id.

TYPES: BEGIN OF gty_str,
         sign   TYPE c LENGTH 1,
         option TYPE c LENGTH 2,
         low    TYPE s_carr_id,
         higt   TYPE s_carr_id,
       END OF gty_str.

DATA: gs_str_so   TYPE gty_str,
      gt_table_so TYPE RANGE OF s_carr_id, "Tablo yapisi Type range of ile olusturuluyor.
      gt_spfli    TYPE TABLE OF spfli,
      gs_spfli    TYPE spfli.

START-OF-SELECTION.

  gs_str_so-sign    = 'I'.
  gs_str_so-option  = 'BT'.
  gs_str_so-low    = p_carr_1.
  gs_str_so-higt    = p_carr_2.

  APPEND gs_str_so TO gt_table_so.
  CLEAR: gs_str_so.

  SELECT * FROM spfli
    INTO TABLE gt_spfli
    WHERE carrid IN gt_table_so.


  LOOP AT gt_spfli into gs_spfli.

    write: gs_spfli-carrid,
           gs_spfli-connid,
           gs_spfli-countryfr,
           gs_spfli-cityfrom,
           gs_spfli-airpfrom,
           gs_spfli-countryto,
           gs_spfli-cityto,
           gs_spfli-airpto,
           gs_spfli-fltime,
           gs_spfli-deptime,
           gs_spfli-arrtime,
           gs_spfli-distance,
           gs_spfli-distid,
           gs_spfli-fltype,
           gs_spfli-period.

    uline.
    skip.

  ENDLOOP.


*BREAK-POINT.
