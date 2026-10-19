(* SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 *)
(* Copyright (c) 2026 Ahmad Ali Parr. All rights reserved. *)
(* Authored by Ahmad Ali Parr. *)
(* Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE. *)

IMPLEMENTATION MODULE M2Interpolation;

PROCEDURE Linear (x0,y0,x1,y1,x: REAL;
 VAR y: REAL): BOOLEAN;

BEGIN IF x0=x1 THEN RETURN FALSE END;
 y:=y0+(y1-y0)*(x-x0)/(x1-x0);
 RETURN TRUE END Linear;

PROCEDURE FunctionValue (x: REAL): REAL;
 BEGIN RETURN x*x*x-x-2.0 END FunctionValue;

PROCEDURE Trapezoid (a,b: REAL;
 steps: CARDINAL;
 VAR integral: REAL): BOOLEAN;

VAR i: CARDINAL;
 h,x,sum: REAL;

BEGIN IF steps=0 THEN RETURN FALSE END;
 h:=(b-a)/FLOAT(steps);
 sum:=(FunctionValue(a)+FunctionValue(b))/2.0;

FOR i:=1 TO steps-1 DO x:=a+FLOAT(i)*h;
 sum:=sum+FunctionValue(x) END;

integral:=sum*h;
 RETURN TRUE END Trapezoid;

PROCEDURE Bisect (a,b,tolerance: REAL;
 maxIterations: CARDINAL;
 VAR root: REAL): BOOLEAN;

VAR fa,fb,mid,fm: REAL;
 i: CARDINAL;

BEGIN fa:=FunctionValue(a);
 fb:=FunctionValue(b);
 IF (fa=0.0) THEN root:=a;
 RETURN TRUE END;
 IF fb=0.0 THEN root:=b;
 RETURN TRUE END;
 IF fa*fb>0.0 THEN RETURN FALSE END;

FOR i:=0 TO maxIterations-1 DO mid:=(a+b)/2.0;
 fm:=FunctionValue(mid);
 IF (ABS(fm)<tolerance) OR (ABS(b-a)/2.0<tolerance) THEN root:=mid;
 RETURN TRUE END;
 IF fa*fm<0.0 THEN b:=mid;
 fb:=fm ELSE a:=mid;
 fa:=fm END END;
 root:=(a+b)/2.0;
 RETURN ABS(FunctionValue(root))<tolerance*10.0 END Bisect;

PROCEDURE Lagrange (xs,ys: ARRAY OF REAL;
 n: CARDINAL;
 x: REAL;
 VAR y: REAL): BOOLEAN;

VAR i,j: CARDINAL;
 term: REAL;

BEGIN IF (n=0) OR (n>HIGH(xs)+1) OR (n>HIGH(ys)+1) THEN RETURN FALSE END;
 y:=0.0;

FOR i:=0 TO n-1 DO term:=ys[i];
 FOR j:=0 TO n-1 DO IF i#j THEN IF xs[i]=xs[j] THEN RETURN FALSE END;
 term:=term*(x-xs[j])/(xs[i]-xs[j]) END END;
 y:=y+term END;
 RETURN TRUE END Lagrange;

END M2Interpolation.
