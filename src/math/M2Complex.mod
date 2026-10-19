(* SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 *)
(* Copyright (c) 2026 Ahmad Ali Parr. All rights reserved. *)
(* Authored by Ahmad Ali Parr. *)
(* Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE. *)

IMPLEMENTATION MODULE M2Complex;

PROCEDURE Make(re,im:REAL):Complex;

VAR z:Complex;

BEGIN z.re:=re;

z.im:=im;

RETURN z END Make;

PROCEDURE Add(a,b:Complex):Complex;

BEGIN RETURN Make(a.re+b.re,a.im+b.im)END Add;

PROCEDURE Subtract(a,b:Complex):Complex;

BEGIN RETURN Make(a.re-b.re,a.im-b.im)END Subtract;

PROCEDURE Multiply(a,b:Complex):Complex;

BEGIN RETURN Make(a.re*b.re-a.im*b.im,a.re*b.im+a.im*b.re)END Multiply;

PROCEDURE MagnitudeSquared(a:Complex):REAL;

BEGIN RETURN a.re*a.re+a.im*a.im END MagnitudeSquared;

PROCEDURE Conjugate(a:Complex):Complex;

BEGIN RETURN Make(a.re,-a.im)END Conjugate;

PROCEDURE Divide (a,b: Complex;
 VAR result: Complex): BOOLEAN;

VAR d: REAL;

BEGIN d:=b.re*b.re+b.im*b.im;
 IF d=0.0 THEN result.re:=0.0;
 result.im:=0.0;
 RETURN FALSE END;
 result.re:=(a.re*b.re+a.im*b.im)/d;
 result.im:=(a.im*b.re-a.re*b.im)/d;
 RETURN TRUE END Divide;

PROCEDURE Scale (z: Complex;
 factor: REAL): Complex;
 VAR r: Complex;
 BEGIN r.re:=z.re*factor;
 r.im:=z.im*factor;
 RETURN r END Scale;

END M2Complex.
