(* SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 *)
(* Copyright (c) 2026 Ahmad Ali Parr. All rights reserved. *)
(* Authored by Ahmad Ali Parr. *)
(* Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE. *)

MODULE vector_demo; FROM M2Vector IMPORT Vector,Create,Push,Get,Size,Destroy; VAR v:Vector;x:CARDINAL; BEGIN v:=Create(4);IF v=NIL THEN HALT(1)END;IF NOT Push(v,10)THEN HALT(2)END;IF NOT Push(v,20)THEN HALT(3)END;IF Size(v)#2 THEN HALT(4)END;IF NOT Get(v,1,x)OR(x#20)THEN HALT(5)END;Destroy(v) END vector_demo.
