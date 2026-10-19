(* SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 *)
(* Copyright (c) 2026 Ahmad Ali Parr. All rights reserved. *)
(* Authored by Ahmad Ali Parr. *)
(* Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE. *)

IMPLEMENTATION MODULE M2BitSet;

PROCEDURE Create (bits: CARDINAL): BitSet;

VAR s: BitSet;
 i: CARDINAL;

BEGIN NEW(s);
 IF s=NIL THEN RETURN NIL END;
 s^.bits:=bits;
 s^.wordCount:=(bits+31) DIV 32;
 NEW(s^.words,s^.wordCount);
 IF s^.words=NIL THEN DISPOSE(s);
 RETURN NIL END;
 FOR i:=0 TO s^.wordCount-1 DO s^.words^[i]:=0 END;
 RETURN s END Create;

PROCEDURE Destroy (VAR s: BitSet);
 BEGIN IF s#NIL THEN IF s^.words#NIL THEN DISPOSE(s^.words) END;
 DISPOSE(s);
 s:=NIL END END Destroy;

PROCEDURE Add (s: BitSet;
 item: CARDINAL): BOOLEAN;
 BEGIN IF (s=NIL) OR (item>=s^.bits) THEN RETURN FALSE END;
 s^.words^[item DIV 32]:=s^.words^[item DIV 32] OR (1<<(item MOD 32));
 RETURN TRUE END Add;

PROCEDURE Remove (s: BitSet;
 item: CARDINAL): BOOLEAN;
 BEGIN IF (s=NIL) OR (item>=s^.bits) THEN RETURN FALSE END;
 s^.words^[item DIV 32]:=s^.words^[item DIV 32] AND NOT (1<<(item MOD 32));
 RETURN TRUE END Remove;

PROCEDURE Contains (s: BitSet;
 item: CARDINAL): BOOLEAN;
 BEGIN IF (s=NIL) OR (item>=s^.bits) THEN RETURN FALSE END;
 RETURN (s^.words^[item DIV 32] AND (1<<(item MOD 32)))#0 END Contains;

PROCEDURE Clear (s: BitSet);
 VAR i: CARDINAL;
 BEGIN IF s#NIL THEN FOR i:=0 TO s^.wordCount-1 DO s^.words^[i]:=0 END END END Clear;

PROCEDURE Count (s: BitSet): CARDINAL;
 VAR i,n,v: CARDINAL;
 BEGIN IF s=NIL THEN RETURN 0 END;
 n:=0;
 FOR i:=0 TO s^.wordCount-1 DO v:=s^.words^[i];
 WHILE v#0 DO v:=v AND (v-1);
 INC(n) END END;
 RETURN n END Count;

PROCEDURE Union (a,b,destination: BitSet): BOOLEAN;
 VAR i: CARDINAL;
 BEGIN IF (a=NIL) OR (b=NIL) OR (destination=NIL) OR (a^.bits#b^.bits) OR (a^.bits#destination^.bits) THEN RETURN FALSE END;
 FOR i:=0 TO a^.wordCount-1 DO destination^.words^[i]:=a^.words^[i] OR b^.words^[i] END;
 RETURN TRUE END Union;

PROCEDURE Intersect (a,b,destination: BitSet): BOOLEAN;
 VAR i: CARDINAL;
 BEGIN IF (a=NIL) OR (b=NIL) OR (destination=NIL) OR (a^.bits#b^.bits) OR (a^.bits#destination^.bits) THEN RETURN FALSE END;
 FOR i:=0 TO a^.wordCount-1 DO destination^.words^[i]:=a^.words^[i] AND b^.words^[i] END;
 RETURN TRUE END Intersect;

END M2BitSet.
