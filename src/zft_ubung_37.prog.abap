*&---------------------------------------------------------------------*
*& Report ZFT_UBUNG_37
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zft_ubung_37.


*Wir haben zwei Datenbanktabellen. In der einen stehen die Personennamen und ihre gesamten Urlaubsansprüche.
*In der anderen stehen die Urlaubsdaten der Mitarbeiter mit Beginn- und Enddatum. Allerdings kommen in dieser
*zweiten Tabelle einige Mitarbeiter vor, die in der ersten Tabelle nicht enthalten sind. Schreiben Sie ein Programm,
*das die Namen der Mitarbeiter auflistet, die noch keinen Urlaub genommen haben, sowie die, die zwar Urlaub genommen haben,
*aber nicht in der ersten Tabelle vorhanden sind.


DATA: go_container  TYPE REF TO cl_gui_custom_container.
DATA: go_grid  TYPE REF TO cl_gui_alv_grid.
DATA: gt_fcat TYPE lvc_t_fcat.
DATA: gs_fcat TYPE lvc_s_fcat.
DATA: gs_layout TYPE lvc_s_layo.
DATA: gt_table TYPE zft_tt_new.
DATA: gs_table TYPE zft_tt_new_str.
DATA: gv_contname TYPE c LENGTH 20.
DATA: gv_strktname TYPE c LENGTH 30.
DATA: gt_table_2 TYPE TABLE OF zft_sap04_emp.
DATA: gs_table_2 TYPE zft_sap04_emp.
DATA: gt_table_3 TYPE TABLE OF zft_sap04_hld.
DATA: gs_table_3 TYPE zft_sap04_hld.


START-OF-SELECTION.

  CALL SCREEN 0100.

MODULE status_0100 OUTPUT.
  SET PF-STATUS 'STATUS_37'.
*  SET TITLEBAR 'xxx'.

  SELECT zft_sap04_emp~id, zft_sap04_emp~name, zft_sap04_emp~sname, zft_sap04_emp~holiday,
    zft_sap04_hld~start_date, zft_sap04_hld~end_date

    INTO TABLE @gt_table
    FROM zft_sap04_emp
    INNER JOIN zft_sap04_hld
    ON zft_sap04_emp~id = zft_sap04_hld~id.


  PERFORM alv USING gt_table 'ZFT_TT_NEW_STR' 'C_ALV_1'.


ENDMODULE.

MODULE user_command_0100 INPUT.

  CASE sy-ucomm.
    WHEN 'LEAVE'.
      LEAVE PROGRAM.
    WHEN 'OHNE'.

      SELECT * FROM zft_sap04_emp
        INTO TABLE gt_table_2.

      LOOP AT gt_table INTO gs_table.
        DELETE gt_table_2 WHERE id = gs_table-id.
      ENDLOOP.

      PERFORM alv USING gt_table_2 'zft_sap04_emp' 'C_ALV_2'.

     WHEN 'FEHLER'.

       select * from zft_sap04_hld
         into table gt_table_3.

       LOOP AT gt_table into gs_table.
         delete gt_table_3 where id = gs_table-id.
       ENDLOOP.

       LOOP AT gt_table_2 into gs_table_2.
         delete gt_table_3 where id = gs_table_2-id.
       ENDLOOP.

      PERFORM alv USING gt_table_3 'zft_sap04_hld' 'C_ALV_3'.

  ENDCASE.

ENDMODULE.

FORM alv USING it_table gv_strktname gv_contname.


  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = gv_strktname
      i_bypassing_buffer     = abap_true
    CHANGING
      ct_fieldcat            = gt_fcat
    EXCEPTIONS
      inconsistent_interface = 1
      program_error          = 2
      OTHERS                 = 3.
  IF sy-subrc <> 0.
    BREAK-POINT.
  ENDIF.

  gs_layout-zebra         = abap_true.
  gs_layout-cwidth_opt     = abap_true.
  gs_layout-sel_mode       = 'A'.


  CREATE OBJECT go_container
    EXPORTING
      container_name              = gv_contname
    EXCEPTIONS
      cntl_error                  = 1
      cntl_system_error           = 2
      create_error                = 3
      lifetime_error              = 4
      lifetime_dynpro_dynpro_link = 5
      OTHERS                      = 6.
  IF sy-subrc IS NOT INITIAL.
    BREAK-POINT.
  ENDIF.

  CREATE OBJECT go_grid
    EXPORTING
      i_parent          = go_container
    EXCEPTIONS
      error_cntl_create = 1
      error_cntl_init   = 2
      error_cntl_link   = 3
      error_dp_create   = 4
      OTHERS            = 5.
  IF sy-subrc IS NOT INITIAL.
    BREAK-POINT.
  ENDIF.

  go_grid->set_table_for_first_display(
    EXPORTING
      is_layout                     =     gs_layout
    CHANGING
      it_outtab                     =     it_table
      it_fieldcatalog               =     gt_fcat
    EXCEPTIONS
      invalid_parameter_combination = 1
      program_error                 = 2
      too_many_lines                = 3
      OTHERS                        = 4 ).
  IF sy-subrc IS NOT INITIAL.
    BREAK-POINT.
  ENDIF.

ENDFORM.
