(* SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 *)
(* Copyright (c) 2026 Ahmad Ali Parr. All rights reserved. *)
(* Authored by Ahmad Ali Parr. *)
(* Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE. *)

IMPLEMENTATION MODULE M2BST;

TYPE Node = POINTER TO NodeDesc;
 NodeDesc = RECORD key: CARDINAL;
 left,right: Node END;

PROCEDURE Create (): Tree;
 VAR t: Tree;
 BEGIN NEW(t);
 IF t#NIL THEN t^.root:=NIL;
 t^.size:=0 END;
 RETURN t END Create;

PROCEDURE FreeNode (p: Node);
 BEGIN IF p#NIL THEN FreeNode(p^.left);
 FreeNode(p^.right);
 DISPOSE(p) END END FreeNode;

PROCEDURE Destroy (VAR t: Tree);
 BEGIN IF t#NIL THEN FreeNode(t^.root);
 DISPOSE(t);
 t:=NIL END END Destroy;

PROCEDURE Insert (t: Tree;
 value: CARDINAL): BOOLEAN;

VAR p,parent,n: Node;

BEGIN IF t=NIL THEN RETURN FALSE END;
 parent:=NIL;
 p:=t^.root;

WHILE p#NIL DO parent:=p;
 IF value=p^.key THEN RETURN FALSE ELSIF value<p^.key THEN p:=p^.left ELSE p:=p^.right END END;

NEW(n);
 IF n=NIL THEN RETURN FALSE END;
 n^.key:=value;
 n^.left:=NIL;
 n^.right:=NIL;

IF parent=NIL THEN t^.root:=n ELSIF value<parent^.key THEN parent^.left:=n ELSE parent^.right:=n END;
 INC(t^.size);
 RETURN TRUE;

END Insert;

PROCEDURE Contains (t: Tree;
 value: CARDINAL): BOOLEAN;

VAR p: Node;

BEGIN IF t=NIL THEN RETURN FALSE END;
 p:=t^.root;
 WHILE p#NIL DO IF value=p^.key THEN RETURN TRUE ELSIF value<p^.key THEN p:=p^.left ELSE p:=p^.right END END;
 RETURN FALSE END Contains;

PROCEDURE Remove (t: Tree;
 value: CARDINAL): BOOLEAN;

VAR p,parent,child,succ,succParent: Node;

BEGIN IF t=NIL THEN RETURN FALSE END;
 parent:=NIL;
 p:=t^.root;

WHILE (p#NIL) AND (p^.key#value) DO parent:=p;
 IF value<p^.key THEN p:=p^.left ELSE p:=p^.right END END;

IF p=NIL THEN RETURN FALSE END;

IF (p^.left#NIL) AND (p^.right#NIL) THEN succParent:=p;
 succ:=p^.right;
 WHILE succ^.left#NIL DO succParent:=succ;
 succ:=succ^.left END;
 p^.key:=succ^.key;
 parent:=succParent;
 p:=succ END;

IF p^.left#NIL THEN child:=p^.left ELSE child:=p^.right END;

IF parent=NIL THEN t^.root:=child ELSIF parent^.left=p THEN parent^.left:=child ELSE parent^.right:=child END;

DISPOSE(p);
 DEC(t^.size);
 RETURN TRUE;

END Remove;

PROCEDURE Minimum (t: Tree;
 VAR value: CARDINAL): BOOLEAN;
 VAR p: Node;
 BEGIN IF (t=NIL) OR (t^.root=NIL) THEN RETURN FALSE END;
 p:=t^.root;
 WHILE p^.left#NIL DO p:=p^.left END;
 value:=p^.key;
 RETURN TRUE END Minimum;

PROCEDURE Maximum (t: Tree;
 VAR value: CARDINAL): BOOLEAN;
 VAR p: Node;
 BEGIN IF (t=NIL) OR (t^.root=NIL) THEN RETURN FALSE END;
 p:=t^.root;
 WHILE p^.right#NIL DO p:=p^.right END;
 value:=p^.key;
 RETURN TRUE END Maximum;

PROCEDURE Size (t: Tree): CARDINAL;
 BEGIN IF t=NIL THEN RETURN 0 ELSE RETURN t^.size END END Size;

PROCEDURE Walk (p: Node;
 VAR values: ARRAY OF CARDINAL;
 VAR count: CARDINAL): BOOLEAN;

BEGIN IF p=NIL THEN RETURN TRUE END;
 IF NOT Walk(p^.left,values,count) THEN RETURN FALSE END;
 IF count>HIGH(values) THEN RETURN FALSE END;
 values[count]:=p^.key;
 INC(count);
 RETURN Walk(p^.right,values,count) END Walk;

PROCEDURE InOrder (t: Tree;
 VAR values: ARRAY OF CARDINAL;
 VAR count: CARDINAL): BOOLEAN;

BEGIN count:=0;
 IF t=NIL THEN RETURN TRUE END;
 RETURN Walk(t^.root,values,count) END InOrder;

END M2BST.
