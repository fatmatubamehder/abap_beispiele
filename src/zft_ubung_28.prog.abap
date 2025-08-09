*&---------------------------------------------------------------------*
*& Report ZFT_UBUNG_28
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZFT_UBUNG_28.

types: BEGIN OF gty_str,
  carrid TYPE s_carr_id,
  carrname TYPE S_CARRNAME,
  CURRCODE TYPE S_CURRCODE,
  CONNID TYPE S_CONN_ID,
  COUNTRYFR TYPE LAND1,
  END OF gty_str.


data: gt_scarr TYPE TABLE OF scarr.
data: gt_spfli TYPE TABLE OF spfli.
data: gs_scarr TYPE scarr.
data: gs_spfli TYPE spfli.
data: gt_table TYPE TABLE OF gty_str.
data: gs_table TYPE gty_str.
data: gt_table_2 TYPE TABLE OF gty_str.
data: gt_table_3 TYPE TABLE OF gty_str.

START-OF-SELECTION.

*select * from scarr
*  into table gt_scarr.
*
*select * from spfli
*  into table gt_spfli.


*  LOOP AT gt_scarr into gs_scarr.
*
*    LOOP AT gt_spfli into gs_spfli where carrid = gs_scarr-carrid.
*
*        gs_table-carrid         = gs_scarr-carrid.
*        gs_table-carrname       = gs_scarr-carrname.
*        gs_table-currcode       = gs_scarr-currcode.
*        gs_table-connid         = gs_spfli-connid.
*        gs_table-countryfr      = gs_spfli-countryfr.
*
*        APPEND gs_table to gt_table.
*        clear: gs_table.
*
*    ENDLOOP.
*
*
*  ENDLOOP.


select scarr~carrid, scarr~carrname, scarr~currcode,
       spfli~connid, spfli~countryfr

    into TABLE @gt_table_2
    from scarr
    INNER JOIN spfli
    on scarr~carrid = spfli~carrid.


select scarr~carrid, scarr~carrname, scarr~currcode,
       spfli~connid, spfli~countryfr

    into TABLE @gt_table_3
    from scarr
    LEFT  OUTER JOIN spfli
    on scarr~carrid = spfli~carrid.


  BREAK-POINT. 
