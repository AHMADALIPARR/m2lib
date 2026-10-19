(* SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 *)
(* Copyright (c) 2026 Ahmad Ali Parr. All rights reserved. *)
(* Authored by Ahmad Ali Parr. *)
(* Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE. *)

IMPLEMENTATION MODULE M2Matrix;

PROCEDURE Make2(a11,a12,a21,a22:REAL):Matrix2;

VAR m:Matrix2;

BEGIN m.a11:=a11;

m.a12:=a12;

m.a21:=a21;

m.a22:=a22;

RETURN m END Make2;

PROCEDURE Add2(a,b:Matrix2):Matrix2;

BEGIN RETURN Make2(a.a11+b.a11,a.a12+b.a12,a.a21+b.a21,a.a22+b.a22)END Add2;

PROCEDURE Multiply2(a,b:Matrix2):Matrix2;

BEGIN RETURN Make2(a.a11*b.a11+a.a12*b.a21,a.a11*b.a12+a.a12*b.a22,a.a21*b.a11+a.a22*b.a21,a.a21*b.a12+a.a22*b.a22)END Multiply2;

PROCEDURE Determinant2(a:Matrix2):REAL;

BEGIN RETURN a.a11*a.a22-a.a12*a.a21 END Determinant2;

PROCEDURE Apply2(a:Matrix2;

x,y:REAL;

VAR ox,oy:REAL);

BEGIN ox:=a.a11*x+a.a12*y;

oy:=a.a21*x+a.a22*y END Apply2;

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
END M2Matrix.
