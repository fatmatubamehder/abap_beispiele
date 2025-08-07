*&---------------------------------------------------------------------*
*& Report ZFT_UBUNG_20
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zft_ubung_20.

DATA: gv_field TYPE string.
DATA: gv_1 TYPE string.
DATA: gv_2 TYPE string.



START-OF-SELECTION.

  CALL SCREEN 0400.

MODULE status_0400 OUTPUT.
  SET PF-STATUS 'PF_STATUS_20'.
*  SET TITLEBAR 'xxx'.
ENDMODULE.

MODULE user_command_0400 INPUT.

  CASE sy-ucomm.
    WHEN 'LEAVE'.
      LEAVE PROGRAM.
    WHEN 'EINS'.
      CONCATENATE gv_field '1' INTO gv_field.
    WHEN 'ZWEI'.
      CONCATENATE gv_field '2' INTO gv_field.
    WHEN 'DREI'.
      CONCATENATE gv_field '3' INTO gv_field.
    WHEN 'VIER'.
      CONCATENATE gv_field '4' INTO gv_field.
    WHEN 'FUNF'.
      CONCATENATE gv_field '5' INTO gv_field.
    WHEN 'SECHS'.
      CONCATENATE gv_field '6' INTO gv_field.
    WHEN 'SIEBEN'.
      CONCATENATE gv_field '7' INTO gv_field.
    WHEN 'ACHT'.
      CONCATENATE gv_field '8' INTO gv_field.
    WHEN 'NEUN'.
      CONCATENATE gv_field '9' INTO gv_field.
    WHEN 'NULL'.
      CONCATENATE gv_field '0' INTO gv_field.
    WHEN 'MULT'.
      CONCATENATE gv_field '*' INTO gv_field.
    WHEN 'TEIL'.
      CONCATENATE gv_field '/' INTO gv_field.
    WHEN 'SUB'.
      CONCATENATE gv_field '-' INTO gv_field.
    WHEN 'SUM'.
      CONCATENATE gv_field '+' INTO gv_field.

    WHEN 'GLEICH'.

      FIND '*' IN gv_field.

      IF sy-subrc IS INITIAL.

        split gv_field AT '*' INTO gv_1 gv_2.

        gv_field = gv_1 * gv_2.

      ENDIF.

      FIND '/' IN gv_field.

      IF sy-subrc IS INITIAL.

        split gv_field AT '/' INTO gv_1 gv_2.

        gv_field = gv_1 / gv_2.

      ENDIF.

      FIND '-' IN gv_field.

      IF sy-subrc IS INITIAL.

        split gv_field AT '-' INTO gv_1 gv_2.

        gv_field = gv_1 - gv_2.

      ENDIF.

      FIND '+' IN gv_field.

      IF sy-subrc IS INITIAL.

        split gv_field AT '+' INTO gv_1 gv_2.

        gv_field = gv_1 + gv_2.

      ENDIF.

      WHEN 'CLEAR'.

        clear: gv_field.


*  	WHEN OTHERS.
  ENDCASE.

ENDMODULE. 
