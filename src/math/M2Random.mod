(* SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 *)
(* Copyright (c) 2026 Ahmad Ali Parr. All rights reserved. *)
(* Authored by Ahmad Ali Parr. *)
(* Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE. *)

IMPLEMENTATION MODULE M2Random;

VAR state:CARDINAL;

PROCEDURE Seed(value:CARDINAL);

BEGIN state:=value;

IF state=0 THEN state:=2463534242 END END Seed;

PROCEDURE Next():CARDINAL;

BEGIN state:=state XOR (state*8192);

state:=state XOR (state DIV 131072);

state:=state XOR (state*32);

RETURN state END Next;

PROCEDURE NextRange(lo,hi:CARDINAL):CARDINAL;

BEGIN IF hi<=lo THEN RETURN lo END;

RETURN lo+Next()MOD(hi-lo+1)END NextRange;

PROCEDURE NextReal():REAL;

BEGIN RETURN FLOAT(Next())/FLOAT(MAX(CARDINAL))END NextReal;


PROCEDURE Step(VAR state:Generator):CARDINAL;

BEGIN state:=state XOR (state*16#9E3779B9);

state:=state XOR (state DIV 16);

state:=state*16#85EBCA6B;

state:=state XOR (state DIV 13);

state:=state*16#C2B2AE35;

state:=state XOR (state DIV 16);

RETURN state END Step;

PROCEDURE Bounded(VAR state:Generator;

bound:CARDINAL;

VAR value:CARDINAL):BOOLEAN;

BEGIN IF bound=0 THEN value:=0;

RETURN FALSE END;

value:=Step(state) MOD bound;

RETURN TRUE END Bounded;

PROCEDURE UnitReal(VAR state:Generator):REAL;

BEGIN RETURN FLOAT(Step(state) MOD 16777216)/16777216.0 END UnitReal;
BEGIN state:=2463534242 END M2Random.
