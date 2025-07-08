*&---------------------------------------------------------------------*
*& Report ZFT_UBUNG_02
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZFT_UBUNG_02.

*Erstellen Sie einen neuen Report und verwenden Sie Select-Options, um vom Benutzer drei verschiedene „CARRID“-Werte abzufragen.
*Verwenden Sie die eingegebenen Werte, um alle Datensätze aus den Tabellen SCARR, SPFLI und SFLIGHT zu lesen und auf dem Bildschirm auszugeben.
*
*Beim Ausgeben beachten Sie folgende Reihenfolge:
*
*Geben Sie eine Zeile aus der SCARR-Tabelle aus.
*
*Danach geben Sie alle Zeilen aus der SPFLI-Tabelle aus, bei denen der CARRID-Wert mit der SCARR-Zeile übereinstimmt.
*
*Nach jeder SPFLI-Zeile geben Sie die Zeilen aus der SFLIGHT-Tabelle aus, die denselben CARRID-Wert wie die SPFLI-Zeile haben.



data: gv_scarr TYPE S_CARR_ID,
      gs_scarr TYPE scarr,
      gt_scarr TYPE TABLE OF scarr,
      gs_spfli TYPE spfli,
      gt_spfli TYPE TABLE OF spfli,
      gs_sflight TYPE sflight,
      gt_sflight type TABLE OF sflight.

SELECT-OPTIONS: so_carr FOR gv_scarr.

select * from scarr
  into table gt_scarr
  where carrid IN so_carr.

select * from spfli
  into table gt_spfli
  where carrid in so_carr.

select * from sflight
  into table gt_sflight
  where carrid in so_carr.


LOOP AT gt_scarr into gs_scarr.

  write: gs_scarr-carrid,
         gs_scarr-carrname,
         gs_scarr-currcode,
         gs_scarr-url.

  uline.
  skip.

  LOOP AT gt_spfli into gs_spfli where carrid = gs_scarr-carrid.

  write: / gs_spfli-carrid,
         gs_spfli-arrtime,
         gs_spfli-period.

  uline.

    LOOP AT gt_sflight into gs_sflight where carrid = gs_spfli-carrid and connid = gs_spfli-connid .

      write: / gs_sflight-carrid,
               gs_sflight-connid,
               gs_sflight-fldate,
               gs_sflight-price.

      uline.


    ENDLOOP.
  ENDLOOP.

uline.

ENDLOOP.


*
*  BREAK-POINT.
