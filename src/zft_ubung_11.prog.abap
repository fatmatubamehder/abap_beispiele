*&---------------------------------------------------------------------*
*& Report ZFT_UBUNG_11
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZFT_UBUNG_11.

*Erstellen Sie einen neuen Bericht (Report) und lassen Sie den Benutzer mithilfe von SELECT-OPTIONS einen CARRID-Wert eingeben.
*
*Zusätzlich sollen drei Checkboxen vorhanden sein mit den Bezeichnungen:
*
*„SCARR“
*
*„SPFLI“
*
*„SFLIGHT“
*
*Erstellen Sie eine neue Klasse mit insgesamt vier Methoden:
*
*Die erste Methode soll Instance-Public sein.
*Sie empfängt als Import-Parameter den eingegebenen CARRID-Wert sowie die vom Benutzer ausgewählten Checkboxen.
*Entsprechend der Auswahl soll sie Daten aus den jeweiligen Tabellen lesen und diese als Export-Parameter zurückgeben.
*
*Für jede Tabelle soll es eine eigene Methode geben (drei weitere Methoden), die jeweils Instance-Protected sind.
*Diese Methoden sollen die Daten aus SCARR, SPFLI bzw. SFLIGHT lesen.
*
*Die erste Methode soll diese geschützten Methoden intern aufrufen – je nachdem, welche Checkbox(en) ausgewählt wurden.



DATA: gv_carr TYPE s_carr_id.

SELECT-OPTIONS: so_carr FOR gv_carr.

data: go_getdata type REF TO ZFT_CL_11,
      gt_scarr type table of scarr,
      gt_spfli type TABLE OF spfli,
      gt_sflight type table of sflight.

PARAMETERS: p_scarr AS CHECKBOX.
PARAMETERS: p_spfli AS CHECKBOX.
PARAMETERS: p_sflght AS CHECKBOX.

START-OF-SELECTION.

CREATE OBJECT go_getdata.


go_getdata->get_data(
  EXPORTING
    it_range_carrid =  so_carr[]
    ic_scarr        =  p_scarr
    ic_spfli        =  p_spfli
    ic_sflight      =  p_sflght
  IMPORTING
    et_scarr        =  gt_scarr
    et_spfli        =  gt_spfli
    et_sflight      =  gt_sflight ).



" der Inhalt vom Class


*@78\QImporting@  IT_RANGE_CARRID TYPE ZFT_TT_CARRID  Carrid tt range
*@78\QImporting@  IC_SCARR  TYPE CHAR1  Einstelliges Kennzeichen
*@78\QImporting@  IC_SPFLI  TYPE CHAR1  Einstelliges Kennzeichen
*@78\QImporting@  IC_SFLIGHT  TYPE CHAR1  Einstelliges Kennzeichen
*@79\QExporting@  ET_SCARR  TYPE ZFT_TT_SCARR Table Type Scarr
*@79\QExporting@  ET_SPFLI  TYPE ZFT_TT_SPFLI Table Type spfli
*@79\QExporting@  ET_SFLIGHT  TYPE ZFT_TT_SFLIGHT Type Table sflight




* METHOD get_data.
*
*    IF IC_SCARR = abap_true.
*
*      get_scarr(
*        EXPORTING
*          it_range_carrid =  IT_RANGE_CARRID
*        IMPORTING
*          et_scarr        =   ET_SCARR ).
*
*    ENDIF.
*
*    IF IC_Spfli = abap_true.
*
*      get_spfli(
*        EXPORTING
*          it_range_carrid = IT_RANGE_CARRID
*        IMPORTING
*          et_spfli        = ET_SPFLI  ).
*
*    ENDIF.
*
*    IF IC_SFLIGHT = abap_true.
*
*      get_sflight(
*        EXPORTING
*          it_range_carrid =  IT_RANGE_CARRID
*        IMPORTING
*          et_sflight      =  ET_SFLIGHT ).
*
*    ENDIF.
*
*  ENDMETHOD. 
