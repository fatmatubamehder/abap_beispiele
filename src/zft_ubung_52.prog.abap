*&---------------------------------------------------------------------*
*& Report ZFT_UBUNG_52
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zft_ubung_52.



START-OF-SELECTION.

  SELECT * FROM zmc_sap04_strav
    INTO TABLE @DATA(gt_stravelag).



  DATA(gt_table) = VALUE zft_tt_sap04( FOR gs_strav IN gt_stravelag WHERE ( id > 30 ) ( id   = gs_strav-id
                                                                                        agencynum  = gs_strav-agencynum
                                                                                        name       = gs_strav-name
                                                                                        street     = gs_strav-street
                                                                                        url        = gs_strav-url ) ).

  gt_table = VALUE #( BASE gt_table FOR gs_strav IN gt_stravelag WHERE ( id < 10 ) ( id   = gs_strav-id
                                                                                     agencynum  = gs_strav-agencynum
                                                                                     name       = gs_strav-name
                                                                                     street     = gs_strav-street
                                                                                     url        = gs_strav-url ) ).




  BREAK-POINT.
