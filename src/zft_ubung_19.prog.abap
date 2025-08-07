*&---------------------------------------------------------------------*
*& Report ZFT_UBUNG_19
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zft_ubung_19.


*Amaç; Call Screen(Dynpro) ekranında iki container oluşturarak seçili satırları soldan sağa veya sağdan sola geçirme ve silem işlemlerini gerçekleştireceğiz.
*Metod;Call screen ekranında iki container oluşturacağız, Soldaki container doldurulacak sağdaki boş olacak, soldakinden seçtiğimiz satırlar butona basınca
*sağa geçecek ve soldaki satırlar silinecek . Aynı şekilde sağdan  seçilenlerde sola geçecek ve saüda görünmeyecek. Ayrıca her iki tablodada işaretlediklerimizi
*silebileceğiz, ancak Database tablodan değil dahili tablodan silme işlemi gerçekleşecek.
*Yol;1-Programda Data tanımlamaları yapılacak , iki kontainer için , ayrıca sflight tablosundan veri çekilecek, onunla ilgili yanımlamalar ayrıca tabloda seçim
*yapılacağı için bununla ilgili tamımlamalar yapılacak.
*2-Call screen tanımlanacak, iki container oluşturulacak arada soldan sağa ve sağdan sola geçirmesiiçin iki buton tasarlanacak, ayrıca containerların altında delete
*işlemi için iki buton daha tasarlanacak
*3-Programdan çıkmak için Exit tanımlanacak ancak bu call screen pf statusde yapılacak.
*4- Programda butonların içi için gerekli kodlar yazılacak, form-perform yapıları kullanılacak.
*5- Call screen açıldığında soldaki containerda sflight tablosu görünümü sağlanacak ve sağdaki container boş olacak.
*6-Program çalışınca soldaki tablodan seçtiğim kolonlar seçilip butona basınca sağa geçecek ve soldan silinmiş olacak, aynı şekilde sağdan da sola geçiş sağlanacak
*7-Ayrıca seçili satırların delete butonuna basınca silme işlemi gerçekleşecek.



DATA: gt_sflight_1 TYPE TABLE OF sflight,
      gs_sflight_1 TYPE sflight,
      gt_sflight_2 TYPE TABLE OF sflight,
      gs_sflight_2 TYPE sflight,
      gt_fcat      TYPE lvc_t_fcat,
      gs_fcat      TYPE lvc_s_fcat,
      gs_layout    TYPE lvc_s_layo,
      go_cont_1    TYPE REF TO cl_gui_custom_container,
      go_cont_2    TYPE REF TO cl_gui_custom_container,
      go_alv_1     TYPE REF TO cl_gui_alv_grid,
      go_alv_2     TYPE REF TO cl_gui_alv_grid.



START-OF-SELECTION.

  CALL SCREEN 0200.

MODULE status_0200 OUTPUT.
  SET PF-STATUS 'PF_STATUS_19'.
*  SET TITLEBAR 'xxx'.

  PERFORM alv_sflight_1.

*  IF gt_sflight_2 IS NOT INITIAL.
*    PERFORM alv_sflight_2.
*  ELSEIF gt_sflight_2 IS INITIAL.
*    perform fcat.
*  ENDIF.

  IF gt_sflight_2 IS NOT INITIAL.
    PERFORM select_data.
    PERFORM alv.
  ELSEIF gt_sflight_2 IS INITIAL.
    PERFORM alv.
  ENDIF.


ENDMODULE.

MODULE user_command_0200 INPUT.

  DATA: ls_selected_rows TYPE lvc_s_roid.
  DATA: ls_selected_rows_2 TYPE lvc_s_roid.
  DATA: lt_selected_rows TYPE lvc_t_roid.
  DATA: lt_selected_rows_2 TYPE lvc_t_roid.
  DATA: lt_sflight_1 TYPE TABLE OF sflight.
  DATA: lt_sflight_2 TYPE TABLE OF sflight.




  CASE sy-ucomm.
    WHEN 'LEAVE'.
      LEAVE PROGRAM.
    WHEN 'RIGHT'.

      lt_sflight_1 = gt_sflight_1.

      go_alv_1->get_selected_rows(
        IMPORTING
*        et_index_rows =
          et_row_no     =   lt_selected_rows ).

      LOOP AT lt_selected_rows INTO ls_selected_rows.

        READ TABLE gt_sflight_1 INTO gs_sflight_1 INDEX ls_selected_rows-row_id.

        IF sy-subrc IS INITIAL.

          APPEND gs_sflight_1 TO gt_sflight_2.

          DELETE lt_sflight_1 WHERE carrid = gs_sflight_1-carrid AND
                                    connid = gs_sflight_1-connid AND
                                    fldate = gs_sflight_1-fldate.

        ENDIF.

      ENDLOOP.


      gt_sflight_1 = lt_sflight_1.

      CLEAR: ls_selected_rows.
      CLEAR: gs_sflight_1.

      SORT gt_sflight_2.



    WHEN 'LEFT'.

      lt_sflight_2 = gt_sflight_2.

      go_alv_2->get_selected_rows(
        IMPORTING
*        et_index_rows =
          et_row_no     =   lt_selected_rows ).

      LOOP AT lt_selected_rows INTO ls_selected_rows.

        READ TABLE gt_sflight_2 INTO gs_sflight_2 INDEX ls_selected_rows-row_id.

        IF sy-subrc IS INITIAL.

          APPEND gs_sflight_2 TO gt_sflight_1.

          DELETE lt_sflight_2 WHERE carrid = gs_sflight_2-carrid AND
                                    connid = gs_sflight_2-connid AND
                                    fldate = gs_sflight_2-fldate.

        ENDIF.

      ENDLOOP.


      gt_sflight_2 = lt_sflight_2.

      CLEAR: ls_selected_rows.
      CLEAR: gs_sflight_2.

      SORT gt_sflight_1.

    WHEN 'DELETE'.

      lt_sflight_1 = gt_sflight_1.

      go_alv_1->get_selected_rows(
    IMPORTING
*        et_index_rows =
      et_row_no     =   lt_selected_rows ).

      IF lt_selected_rows IS NOT INITIAL.

        LOOP AT lt_selected_rows INTO ls_selected_rows.

          READ TABLE gt_sflight_1 INTO gs_sflight_1 INDEX ls_selected_rows-row_id.

          IF sy-subrc IS INITIAL.

            DELETE lt_sflight_1 WHERE carrid = gs_sflight_1-carrid AND
                                      connid = gs_sflight_1-connid AND
                                      fldate = gs_sflight_1-fldate.

          ENDIF.


        ENDLOOP.

      ENDIF.

      gt_sflight_1 = lt_sflight_1.



      lt_sflight_2 = gt_sflight_2.

      go_alv_2->get_selected_rows(
    IMPORTING
*        et_index_rows =
      et_row_no     =   lt_selected_rows_2 ).

      IF lt_selected_rows_2 IS NOT INITIAL.

        LOOP AT lt_selected_rows_2 INTO ls_selected_rows_2.

          READ TABLE gt_sflight_2 INTO gs_sflight_2 INDEX ls_selected_rows_2-row_id.

          IF sy-subrc IS INITIAL.

            DELETE lt_sflight_2 WHERE carrid = gs_sflight_2-carrid AND
                                      connid = gs_sflight_2-connid AND
                                      fldate = gs_sflight_2-fldate.

          ENDIF.

        ENDLOOP.

      ENDIF.

      gt_sflight_2 = lt_sflight_2.

*	WHEN OTHERS.
  ENDCASE.
ENDMODULE.

FORM alv_sflight_1.

  IF gt_sflight_1 IS INITIAL.
    SELECT * FROM sflight
      INTO TABLE gt_sflight_1.
  ENDIF.

  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'SFLIGHT'
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


  gs_layout-zebra             = abap_true.
  gs_layout-cwidth_opt        = abap_true.
  gs_layout-sel_mode          = 'A'.


  IF go_alv_1 IS NOT BOUND.

    CREATE OBJECT go_cont_1
      EXPORTING
        container_name              = 'C_ALV_1'
      EXCEPTIONS
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        lifetime_dynpro_dynpro_link = 5
        OTHERS                      = 6.
    IF sy-subrc <> 0.
      BREAK-POINT.
    ENDIF.


    CREATE OBJECT go_alv_1
      EXPORTING
        i_parent          = go_cont_1
      EXCEPTIONS
        error_cntl_create = 1
        error_cntl_init   = 2
        error_cntl_link   = 3
        error_dp_create   = 4
        OTHERS            = 5.
    IF sy-subrc <> 0.
      BREAK-POINT.
    ENDIF.


    go_alv_1->set_table_for_first_display(
      EXPORTING
        is_layout                     =   gs_layout
      CHANGING
        it_outtab                     =   gt_sflight_1
        it_fieldcatalog               =   gt_fcat

      EXCEPTIONS
        invalid_parameter_combination = 1
        program_error                 = 2
        too_many_lines                = 3
        OTHERS                        = 4 ).
    IF sy-subrc <> 0.
      BREAK-POINT.
    ENDIF.

  ELSE.
    go_alv_1->refresh_table_display(

    EXCEPTIONS
      finished       = 1
      OTHERS         = 2 ).
    IF sy-subrc <> 0.
      BREAK-POINT.
    ENDIF.

  ENDIF.



ENDFORM.

FORM alv_sflight_2.

  IF gt_sflight_2 IS INITIAL.
    SELECT * FROM sflight
      INTO TABLE gt_sflight_2.
  ENDIF.


  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'SFLIGHT'
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


  gs_layout-zebra             = abap_true.
  gs_layout-cwidth_opt        = abap_true.
  gs_layout-sel_mode          = 'A'.


  IF go_alv_2 IS NOT BOUND.

    CREATE OBJECT go_cont_2
      EXPORTING
        container_name              = 'C_ALV_2'
      EXCEPTIONS
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        lifetime_dynpro_dynpro_link = 5
        OTHERS                      = 6.
    IF sy-subrc <> 0.
      BREAK-POINT.
    ENDIF.


    CREATE OBJECT go_alv_2
      EXPORTING
        i_parent          = go_cont_2
      EXCEPTIONS
        error_cntl_create = 1
        error_cntl_init   = 2
        error_cntl_link   = 3
        error_dp_create   = 4
        OTHERS            = 5.
    IF sy-subrc <> 0.
      BREAK-POINT.
    ENDIF.


    go_alv_2->set_table_for_first_display(
      EXPORTING
        is_layout                     =   gs_layout
      CHANGING
        it_outtab                     =   gt_sflight_2
        it_fieldcatalog               =   gt_fcat

      EXCEPTIONS
        invalid_parameter_combination = 1
        program_error                 = 2
        too_many_lines                = 3
        OTHERS                        = 4 ).
    IF sy-subrc <> 0.
      BREAK-POINT.
    ENDIF.

  ELSE.

    go_alv_2->refresh_table_display(

    EXCEPTIONS
      finished       = 1
      OTHERS         = 2 ).
    IF sy-subrc <> 0.
      BREAK-POINT.
    ENDIF.

  ENDIF.

ENDFORM.


FORM select_data.

  IF gt_sflight_2 IS INITIAL.
    SELECT * FROM sflight
      INTO TABLE gt_sflight_2.
  ENDIF.

ENDFORM.

FORM alv.

  CALL FUNCTION 'LVC_FIELDCATALOG_MERGE'
    EXPORTING
      i_structure_name       = 'SFLIGHT'
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


  gs_layout-zebra             = abap_true.
  gs_layout-cwidth_opt        = abap_true.
  gs_layout-sel_mode          = 'A'.


  IF go_alv_2 IS NOT BOUND.

    CREATE OBJECT go_cont_2
      EXPORTING
        container_name              = 'C_ALV_2'
      EXCEPTIONS
        cntl_error                  = 1
        cntl_system_error           = 2
        create_error                = 3
        lifetime_error              = 4
        lifetime_dynpro_dynpro_link = 5
        OTHERS                      = 6.
    IF sy-subrc <> 0.
      BREAK-POINT.
    ENDIF.


    CREATE OBJECT go_alv_2
      EXPORTING
        i_parent          = go_cont_2
      EXCEPTIONS
        error_cntl_create = 1
        error_cntl_init   = 2
        error_cntl_link   = 3
        error_dp_create   = 4
        OTHERS            = 5.
    IF sy-subrc <> 0.
      BREAK-POINT.
    ENDIF.


    go_alv_2->set_table_for_first_display(
      EXPORTING
        is_layout                     =   gs_layout
      CHANGING
        it_outtab                     =   gt_sflight_2
        it_fieldcatalog               =   gt_fcat

      EXCEPTIONS
        invalid_parameter_combination = 1
        program_error                 = 2
        too_many_lines                = 3
        OTHERS                        = 4 ).
    IF sy-subrc <> 0.
      BREAK-POINT.
    ENDIF.

  ELSE.

    go_alv_2->refresh_table_display(

    EXCEPTIONS
      finished       = 1
      OTHERS         = 2 ).
    IF sy-subrc <> 0.
      BREAK-POINT.
    ENDIF.

  ENDIF.



ENDFORM.
