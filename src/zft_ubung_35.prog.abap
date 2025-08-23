*&---------------------------------------------------------------------*
*& Report ZFT_UBUNG_35
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZFT_UBUNG_35.


*Erstellen Sie einen neuen Bericht und erfassen Sie vom Benutzer eine CARRID und eine CONNID.
*Stellen Sie sicher, dass diese Parameter im Bericht als Dropdown angezeigt werden können.
*Definieren Sie außerdem auf dem Bildschirm für jede Spalte der Tabelle SPFLI einen Parameter.
*Diese Parameter sollen nebeneinander angeordnet, für die Dateneingabe des Benutzers gesperrt und unsichtbar sein, wenn sie keine Daten enthalten.
*Lesen Sie die entsprechende Zeile aus der Tabelle SPFLI anhand der eingegebenen Werte und füllen Sie die Felder der Selektionsmaske mit den Werten
*dieser Zeile, sodass sie sichtbar werden.



SELECTION-SCREEN BEGIN OF BLOCK A1 WITH FRAME TITLE TEXT-001 NO INTERVALS.

  SELECTION-SCREEN BEGIN OF LINE.

    SELECTION-SCREEN COMMENT 1(6) TEXT-002.
    SELECTION-SCREEN POSITION 9.

    PARAMETERS: p_carrid TYPE c LENGTH 3 as LISTBOX VISIBLE LENGTH 5.

    SELECTION-SCREEN COMMENT 18(8) TEXT-003.
    SELECTION-SCREEN POSITION 28.

    PARAMETERS: p_connid TYPE n LENGTH 4 as LISTBOX VISIBLE LENGTH 7.

  SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN END OF BLOCK a1.
*
SELECTION-SCREEN BEGIN OF BLOCK A2 WITH FRAME TITLE TEXT-004 NO INTERVALS.

  SELECTION-SCREEN BEGIN OF LINE.

    SELECTION-SCREEN COMMENT 1(10) TEXT-005.
    SELECTION-SCREEN POSITION 12.

    PARAMETERS: p_cntrfr TYPE c LENGTH 3.

    SELECTION-SCREEN COMMENT 17(8) TEXT-006.
    SELECTION-SCREEN POSITION 28.

    PARAMETERS: p_cityfr TYPE c LENGTH 14.

    SELECTION-SCREEN COMMENT 43(8) TEXT-007.
    SELECTION-SCREEN POSITION 52.

    PARAMETERS: p_airfr TYPE c LENGTH 3.

  SELECTION-SCREEN END OF LINE.

SELECTION-SCREEN END OF BLOCK a2.


data: gt_values TYPE vrm_values.
data: gs_value TYPE vrm_value.
data: gt_carrid TYPE TABLE OF s_carr_id.
data: gs_carrid TYPE s_carr_id.
data: gt_connid TYPE TABLE OF s_conn_id.
data: gs_connid TYPE s_conn_id.
data: gt_spfli TYPE TABLE OF spfli.
data: gs_spfli TYPE spfli.

INITIALIZATION.

select carrid from spfli
  into table gt_carrid.

sort gt_carrid.
delete ADJACENT DUPLICATES FROM gt_carrid.

LOOP AT gt_carrid into gs_carrid.

  gs_value-key  = gs_carrid.
  gs_value-text = gs_carrid.

APPEND gs_value to gt_values.
clear: gs_value.

ENDLOOP.


CALL FUNCTION 'VRM_SET_VALUES'
  EXPORTING
    id                    = 'P_CARRID'
    values                = gt_values
 EXCEPTIONS
   ID_ILLEGAL_NAME       = 1
   OTHERS                = 2.
IF sy-subrc is NOT INITIAL.
  BREAK-POINT.
ENDIF.

clear: gt_values.

select connid from spfli
  into table gt_connid.

sort gt_connid.
delete ADJACENT DUPLICATES FROM gt_connid.

LOOP AT gt_connid into gs_connid.

  gs_value-key  = gs_connid.
  gs_value-text = gs_connid.

APPEND gs_value to gt_values.
clear: gs_value.

ENDLOOP.


CALL FUNCTION 'VRM_SET_VALUES'
  EXPORTING
    id                    = 'P_CONNID'
    values                = gt_values
 EXCEPTIONS
   ID_ILLEGAL_NAME       = 1
   OTHERS                = 2.
IF sy-subrc is NOT INITIAL.
  BREAK-POINT.
ENDIF.


at SELECTION-SCREEN OUTPUT.

  LOOP AT SCREEN.

    IF p_cntrfr is INITIAL.
      IF screen-name = 'P_CNTRFR'  or screen-name = '%C005012_1000'.
        screen-active = '0'.
      ENDIF.
    else.
      IF screen-name = 'P_CNTRFR'.
        screen-input = '0'.
      ENDIF.
    ENDIF.

    IF p_cityfr is INITIAL.
      IF screen-name = 'P_CITYFR' or screen-name = '%C006015_1000'.
        screen-active = '0'.
      ENDIF.
    else.
      IF screen-name = 'P_CITYFR'.
        screen-input = '0'.
      ENDIF.
    ENDIF.

     IF p_airfr is INITIAL.
      IF screen-name = 'P_AIRFR' or screen-name = '%C007018_1000'.
        screen-active = '0'.
      ENDIF.
    else.
      IF screen-name = 'P_AIRFR'.
        screen-input = '0'.
      ENDIF.
    ENDIF.

     MODIFY SCREEN.

  ENDLOOP.

at SELECTION-SCREEN.


select single * from spfli
  into gs_spfli
  where carrid = p_carrid
  and connid = p_connid.

  p_cntrfr = gs_spfli-countryfr.
  p_cityfr = gs_spfli-cityfrom.
  p_airfr  = gs_spfli-airpfrom.
