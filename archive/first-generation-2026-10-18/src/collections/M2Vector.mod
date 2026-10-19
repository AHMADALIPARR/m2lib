(* SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 *)
(* Copyright (c) 2026 Ahmad Ali Parr. All rights reserved. *)
(* Authored by Ahmad Ali Parr. *)
(* Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE. *)

IMPLEMENTATION MODULE M2Vector;

FROM Storage IMPORT ALLOCATE, DEALLOCATE;

FROM SYSTEM IMPORT TSIZE, ADDRESS;

FROM M2Errors IMPORT ReportError, ErrOutOfMemory, ErrIndexOutOfBounds, ErrUnderflow, ErrOverflow;

PROCEDURE ElemSize (): CARDINAL;
 BEGIN RETURN TSIZE(CARDINAL) END ElemSize;

PROCEDURE Reserve (v: Vector;
 newCap: CARDINAL): BOOLEAN;

VAR nd: ADDRESS;
 i: CARDINAL;
 src,dst: POINTER TO CARDINAL;

BEGIN
 IF v=NIL THEN RETURN FALSE END;
 IF newCap<=v^.cap THEN RETURN TRUE END;

 IF newCap > MAX(CARDINAL) DIV ElemSize() THEN ReportError(ErrOverflow,"Vector.Reserve");
 RETURN FALSE END;

 ALLOCATE(nd,newCap*ElemSize());
 IF nd=NIL THEN ReportError(ErrOutOfMemory,"Vector.Reserve");
 RETURN FALSE END;

 FOR i:=0 TO v^.len-1 DO
   src:=CAST(POINTER TO CARDINAL,ADDRESS(v^.data)+i*ElemSize());

   dst:=CAST(POINTER TO CARDINAL,ADDRESS(nd)+i*ElemSize());
 dst^:=src^;

 END;

 IF v^.data#NIL THEN DEALLOCATE(v^.data,v^.cap*ElemSize()) END;

 v^.data:=nd;
 v^.cap:=newCap;
 RETURN TRUE;

END Reserve;

PROCEDURE Create (initCap: CARDINAL): Vector;

VAR v: Vector;

BEGIN IF initCap=0 THEN initCap:=8 END;
 IF initCap>MAX(CARDINAL) DIV ElemSize() THEN RETURN NIL END;

 NEW(v);
 IF v=NIL THEN ReportError(ErrOutOfMemory,"Vector.Create");
 RETURN NIL END;

 v^.data:=NIL;
 v^.len:=0;
 v^.cap:=0;
 IF NOT Reserve(v,initCap) THEN DISPOSE(v);
 RETURN NIL END;
 RETURN v;

END Create;

PROCEDURE Destroy (VAR v: Vector);

BEGIN IF v#NIL THEN IF v^.data#NIL THEN DEALLOCATE(v^.data,v^.cap*ElemSize()) END;
 DISPOSE(v);
 v:=NIL END END Destroy;

PROCEDURE Push (v: Vector;
 val: CARDINAL): BOOLEAN;

VAR p: POINTER TO CARDINAL;
 nc: CARDINAL;

BEGIN IF v=NIL THEN RETURN FALSE END;
 IF v^.len=v^.cap THEN
 IF v^.cap=0 THEN nc:=8 ELSIF v^.cap>MAX(CARDINAL) DIV 2 THEN ReportError(ErrOverflow,"Vector.Push");
 RETURN FALSE ELSE nc:=v^.cap*2 END;

 IF NOT Reserve(v,nc) THEN RETURN FALSE END END;

 p:=CAST(POINTER TO CARDINAL,ADDRESS(v^.data)+v^.len*ElemSize());
 p^:=val;
 INC(v^.len);
 RETURN TRUE;

END Push;

PROCEDURE Pop (v: Vector;
 VAR val: CARDINAL): BOOLEAN;

VAR p: POINTER TO CARDINAL;

BEGIN IF (v=NIL) OR (v^.len=0) THEN ReportError(ErrUnderflow,"Vector.Pop");
 RETURN FALSE END;
 DEC(v^.len);
 p:=CAST(POINTER TO CARDINAL,ADDRESS(v^.data)+v^.len*ElemSize());
 val:=p^;
 RETURN TRUE END Pop;

PROCEDURE Get (v: Vector;
 idx: CARDINAL;
 VAR val: CARDINAL): BOOLEAN;

VAR p: POINTER TO CARDINAL;

BEGIN IF (v=NIL) OR (idx>=v^.len) THEN ReportError(ErrIndexOutOfBounds,"Vector.Get");
 RETURN FALSE END;
 p:=CAST(POINTER TO CARDINAL,ADDRESS(v^.data)+idx*ElemSize());
 val:=p^;
 RETURN TRUE END Get;

PROCEDURE Set (v: Vector;
 idx: CARDINAL;
 val: CARDINAL): BOOLEAN;

VAR p: POINTER TO CARDINAL;

BEGIN IF (v=NIL) OR (idx>=v^.len) THEN ReportError(ErrIndexOutOfBounds,"Vector.Set");
 RETURN FALSE END;
 p:=CAST(POINTER TO CARDINAL,ADDRESS(v^.data)+idx*ElemSize());
 p^:=val;
 RETURN TRUE END Set;

PROCEDURE Size (v: Vector): CARDINAL;
 BEGIN IF v=NIL THEN RETURN 0 ELSE RETURN v^.len END END Size;

PROCEDURE Capacity (v: Vector): CARDINAL;
 BEGIN IF v=NIL THEN RETURN 0 ELSE RETURN v^.cap END END Capacity;

PROCEDURE Clear (v: Vector);
 BEGIN IF v#NIL THEN v^.len:=0 END END Clear;

PROCEDURE IsEmpty (v: Vector): BOOLEAN;
 BEGIN RETURN (v=NIL) OR (v^.len=0) END IsEmpty;

END M2Vector.
