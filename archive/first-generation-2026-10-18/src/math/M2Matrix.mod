(* SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 *)
(* Copyright (c) 2026 Ahmad Ali Parr. All rights reserved. *)
(* Authored by Ahmad Ali Parr. *)
(* Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE. *)

IMPLEMENTATION MODULE M2Matrix;

PROCEDURE Multiply (a,b: ARRAY OF REAL;
 rowsA,colsA,colsB: CARDINAL;
 VAR result: ARRAY OF REAL): BOOLEAN;

VAR i,j,k: CARDINAL;
 sum: REAL;

BEGIN IF rowsA*colsA>HIGH(a)+1 THEN RETURN FALSE END;
 IF colsA*colsB>HIGH(b)+1 THEN RETURN FALSE END;
 IF rowsA*colsB>HIGH(result)+1 THEN RETURN FALSE END;

 FOR i:=0 TO rowsA-1 DO FOR j:=0 TO colsB-1 DO sum:=0.0;
 FOR k:=0 TO colsA-1 DO sum:=sum+a[i*colsA+k]*b[k*colsB+j] END;
 result[i*colsB+j]:=sum END END;
 RETURN TRUE END Multiply;

PROCEDURE Transpose (a: ARRAY OF REAL;
 rows,cols: CARDINAL;
 VAR result: ARRAY OF REAL): BOOLEAN;

VAR i,j: CARDINAL;

BEGIN IF rows*cols>HIGH(a)+1 THEN RETURN FALSE END;
 IF rows*cols>HIGH(result)+1 THEN RETURN FALSE END;
 FOR i:=0 TO rows-1 DO FOR j:=0 TO cols-1 DO result[j*rows+i]:=a[i*cols+j] END END;
 RETURN TRUE END Transpose;

PROCEDURE Identity (n: CARDINAL;
 VAR result: ARRAY OF REAL): BOOLEAN;

VAR i,j: CARDINAL;

BEGIN IF n*n>HIGH(result)+1 THEN RETURN FALSE END;
 FOR i:=0 TO n-1 DO FOR j:=0 TO n-1 DO IF i=j THEN result[i*n+j]:=1.0 ELSE result[i*n+j]:=0.0 END END END;
 RETURN TRUE END Identity;

PROCEDURE Determinant (a: ARRAY OF REAL;
 n: CARDINAL;
 VAR value: REAL): BOOLEAN;

VAR m: ARRAY [0..255] OF REAL;
 i,j,k,p: CARDINAL;
 pivot,factor,t: REAL;
 sign: REAL;

BEGIN IF (n=0) OR (n>16) OR (n*n>HIGH(a)+1) THEN RETURN FALSE END;
 FOR i:=0 TO n*n-1 DO m[i]:=a[i] END;
 sign:=1.0;

 FOR k:=0 TO n-1 DO p:=k;
 FOR i:=k+1 TO n-1 DO IF ABS(m[i*n+k])>ABS(m[p*n+k]) THEN p:=i END END;
 IF ABS(m[p*n+k])<1.0E-30 THEN value:=0.0;
 RETURN TRUE END;

 IF p#k THEN FOR j:=0 TO n-1 DO t:=m[k*n+j];
 m[k*n+j]:=m[p*n+j];
 m[p*n+j]:=t END;
 sign:=-sign END;
 pivot:=m[k*n+k];

 FOR i:=k+1 TO n-1 DO factor:=m[i*n+k]/pivot;
 FOR j:=k+1 TO n-1 DO m[i*n+j]:=m[i*n+j]-factor*m[k*n+j] END END END;

 value:=sign;
 FOR i:=0 TO n-1 DO value:=value*m[i*n+i] END;
 RETURN TRUE END Determinant;

PROCEDURE Solve (a,b: ARRAY OF REAL;
 n: CARDINAL;
 VAR x: ARRAY OF REAL): BOOLEAN;

VAR m: ARRAY [0..271] OF REAL;
 i,j,k,p: CARDINAL;
 pivot,factor,t: REAL;

BEGIN IF (n=0) OR (n>16) OR (n*n>HIGH(a)+1) OR (n>HIGH(b)+1) OR (n>HIGH(x)+1) THEN RETURN FALSE END;

 FOR i:=0 TO n-1 DO FOR j:=0 TO n-1 DO m[i*(n+1)+j]:=a[i*n+j] END;
 m[i*(n+1)+n]:=b[i] END;

 FOR k:=0 TO n-1 DO p:=k;
 FOR i:=k+1 TO n-1 DO IF ABS(m[i*(n+1)+k])>ABS(m[p*(n+1)+k]) THEN p:=i END END;
 pivot:=m[p*(n+1)+k];
 IF ABS(pivot)<1.0E-30 THEN RETURN FALSE END;

 IF p#k THEN FOR j:=k TO n DO t:=m[k*(n+1)+j];
 m[k*(n+1)+j]:=m[p*(n+1)+j];
 m[p*(n+1)+j]:=t END END;

 FOR i:=k+1 TO n-1 DO factor:=m[i*(n+1)+k]/m[k*(n+1)+k];
 FOR j:=k TO n DO m[i*(n+1)+j]:=m[i*(n+1)+j]-factor*m[k*(n+1)+j] END END END;

 FOR i:=n-1 TO 0 BY -1 DO t:=m[i*(n+1)+n];
 FOR j:=i+1 TO n-1 DO t:=t-m[i*(n+1)+j]*x[j] END;
 x[i]:=t/m[i*(n+1)+i] END;
 RETURN TRUE END Solve;

END M2Matrix.
