(* SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 *)
(* Copyright (c) 2026 Ahmad Ali Parr. All rights reserved. *)
(* Authored by Ahmad Ali Parr. *)
(* Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE. *)

IMPLEMENTATION MODULE M2Random;

PROCEDURE Seed (value: CARDINAL): Generator;
 BEGIN IF value=0 THEN RETURN 16#6D2B79F5 ELSE RETURN value END END Seed;

PROCEDURE Next (VAR state: Generator): CARDINAL;

BEGIN state:=state XOR (state*16#9E3779B9);
 state:=state XOR (state DIV 16);
 state:=state*16#85EBCA6B;
 state:=state XOR (state DIV 13);
 state:=state*16#C2B2AE35;
 state:=state XOR (state DIV 16);
 RETURN state END Next;

PROCEDURE Bounded (VAR state: Generator;
 bound: CARDINAL;
 VAR value: CARDINAL): BOOLEAN;

BEGIN IF bound=0 THEN value:=0;
 RETURN FALSE END;
 value:=Next(state) MOD bound;
 RETURN TRUE END Bounded;

PROCEDURE UnitReal (VAR state: Generator): REAL;
 BEGIN RETURN FLOAT(Next(state) MOD 16777216)/16777216.0 END UnitReal;

END M2Random.
