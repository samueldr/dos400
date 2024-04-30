	PAGE	90,132			;A2
	TITLE	fastsm.SAL - fastopen SYSTEM MESSAGES
;****************** START OF SPECIFICATIONS *****************************
; MODULE NAME: fastsm.SAL

; DESCRIPTIVE NAME: Include the DOS system MESSAGE HANDLER in the SEGMENT
;		    configuration expected by the modules of fastopen.

;FUNCTION: The common code of the DOS SYSTEM MESSAGE HANDLER is made a
;	   part of the fastopen module by using INCLUDE to bring in the
;	   common portion, in SYSMSG.INC.  This included code contains
;	   the routines to initialize for message services, to find
;	   where a particular message is, and to display a message.

; ENTRY POINT: SYSDISPMSG:near
;	       SYSGETMSG:near
;	       SYSLOADMSG:near

; INPUT:
;    AX = MESSAGE NUMBER
;    BX = HANDLE TO DISPLAY TO (-1 means use DOS functions 1-12)
;    SI = OFFSET IN ES: OF SUBLIST, OR 0 IF NONE
;    CX = NUMBER OF %PARMS, 0 IF NONE
;    DX = CLASS IN HIGH BYTE, INPUT FUNCTION IN LOW
;   CALL SYSDISPMSG		;DISPLAY THE MESSAGE

;    If carry set, extended error already called:
;    AX = EXTENDED MESSAGE NUMBER
;    BH = ERROR CLASS
;    BL = SUGGESTED ACTION
;    CH = LOCUS
; _ _ _ _ _ _ _ _ _ _ _ _

;    AX = MESSAGE NUMBER
;    DH = MESSAGE CLASS (1=DOS EXTENDED ERROR, 2=PARSE ERROR, -1=UTILITY MSG)
;   CALL SYSGETMSG		 ;FIND WHERE A MSG IS

;    If carry set, error
;     CX = 0, MESSAGE NOT FOUND
;    If carry not set, ok, and resulting regs are:
;     CX = MESSAGE SIZE
;     DS:SI = MESSAGE TEXT
; _ _ _ _ _ _ _ _ _ _ _ _

;   CALL SYSLOADMSG		 ;SET ADDRESSABILITY TO MSGS, CHECK DOS VERSION
;    If carry not set:
;    CX = SIZE OF MSGS LOADED

;    If carry is set, regs preset up for SYSDISPMSG, as:
;    AX = ERROR CODE IF CARRY SET
;	  AX = 1, INCORRECT DOS VERSION
;	  DH =-1, (Utility msg)
;	OR,
;	  AX = 1, Error loading messages
;	  DH = 0, (Message manager error)
;    BX = STDERR
;    CX = NO_REPLACE
;    DL = NO_INPUT

; EXIT-NORMAL: CARRY is not set

; EXIT-ERROR:  CARRY is set
;	       Call Get Extended Error for reason code, for SYSDISPMSG and
;	       SYSGETMSG.

; INTERNAL REFERENCES:
;    ROUTINES: (Generated by the MSG_SERVICES macro)
;	SYSLOADMSG
;	SYSDISPMSG
;	SYSGETMSG

;    DATA AREAS:

;	INCLUDE SYSMSG.INC   ;Permit System Message handler definition
;
; EXTERNAL REFERENCES:
;    ROUTINES: none

;    DATA AREAS: control blocks pointed to by input registers.

; NOTES:

;	 To assemble these modules, the alphabetical or sequential
;	 ordering of segments may be used.

;	 For LINK instructions, refer to the PROLOG of the main module,
;	 fastopen.asm.

; REVISION HISTORY: A000 Version 4.00: add PARSER, System Message Handler,
;
; COPYRIGHT: "MS DOS FASTOPEN Utility"
;	     "Version 4.00 (C)Copyright 1988 Microsoft "
;	     "Licensed Material - Property of Microsoft "
;
;****************** END OF SPECIFICATIONS *****************************
	IF1				;					;AN000;
	    %OUT    COMPONENT=fastopen, MODULE=fastsm.asm...
	ENDIF				;					;AN000;
; =  =	=  =  =  =  =  =  =  =	=  =

HEADER	MACRO	TEXT			;;					;AN000;
.XLIST					;;
	SUBTTL	TEXT
.LIST					;;
	PAGE				;;					;AN000;
	ENDM				;;					;AN000;
; =  =	=  =  =  =  =  =  =  =	=  =
	INCLUDE SYSMSG.INC		;PERMIT SYSTEM MESSAGE HANDLER DEFINITION ;AN000;
	MSG_UTILNAME <fastopen> 	;IDENTIFY THE COMPONENT 		;AN000;
; =  =	=  =  =  =  =  =  =  =	=  =
	HEADER	<DEFINITION OF MESSAGES> ;					;AN000;
CSEG_INIT    SEGMENT PARA PUBLIC 'CODE' ;
	   ASSUME CS:CSEG_INIT		;ESTABLISHED BY CALLER
	   ASSUME DS:CSEG_INIT		;ESTABLISHED BY CALLER
	   ASSUME ES:CSEG_INIT		;ESTABLISHED BY CALLER

	   PUBLIC COPYRIGHT	   ;						;AN000;
COPYRIGHT  DB	 "MS DOS FASTOPEN Utility " ;                 ;AN000;
	   INCLUDE COPYRIGH.INC    ;						;AN000;
	   HEADER <MESSAGE DATA AREAS> ;					;AN000;
	   MSG_SERVICES <MSGDATA>  ;WORKAREAS FOR SYSTEM MESSAGE HANDLER	;AN000;
; =  =	=  =  =  =  =  =  =  =	=  =
	   HEADER <SYSTEM MESSAGE HANDLER> ;					;AN000;
	   PUBLIC SYSLOADMSG	   ;						;AN000;
	   PUBLIC SYSDISPMSG	   ;						;AN000;


	MSG_SERVICES <FASTOPEN.CLA,FASTOPEN.CL1,FASTOPEN.CL2> ;

				   ;DEFAULT=CHECK DOS VERSION
				   ;DEFAULT=NEARmsg
				   ;DEFAULT=INPUTmsg
				   ;DEFAULT=NUMmsg
				   ;DEFAULT=NO TIMEmsg
				   ;DEFAULT=NO DATEmsg

.xlist
.xcref
	MSG_SERVICES <LOADmsg,GETmsg,DISPLAYmsg,INPUTmsg,CHARmsg,NUMmsg> ;AN000;
	include msgdcl.inc
.cref
.list
; = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = =
CSEG_INIT	ENDS			;
	   END			   ;						;AN000;
