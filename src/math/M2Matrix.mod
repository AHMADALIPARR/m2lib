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

END M2Matrix.
