(* SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 *)
(* Copyright (c) 2026 Ahmad Ali Parr. All rights reserved. *)
(* Authored by Ahmad Ali Parr. *)
(* Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE. *)

IMPLEMENTATION MODULE M2Rational;

FROM M2Integer IMPORT GCD;

PROCEDURE Normalize (VAR r: Rational);

VAR g: CARDINAL;

BEGIN IF r.numerator=0 THEN r.denominator:=1;
 RETURN END;
 g:=GCD(ABS(r.numerator),r.denominator);
 IF g>1 THEN r.numerator:=r.numerator DIV INTEGER(g);
 r.denominator:=r.denominator DIV g END END Normalize;

PROCEDURE Make (n: INTEGER;
 d: CARDINAL;
 VAR r: Rational): BOOLEAN;

BEGIN IF d=0 THEN RETURN FALSE END;
 r.numerator:=n;
 r.denominator:=d;
 Normalize(r);
 RETURN TRUE END Make;

PROCEDURE Add (a,b: Rational;
 VAR r: Rational): BOOLEAN;

VAR x,y: INTEGER;
 d: CARDINAL;

BEGIN IF (a.denominator=0) OR (b.denominator=0) THEN RETURN FALSE END;
 IF a.denominator>MAX(CARDINAL) DIV b.denominator THEN RETURN FALSE END;
 d:=a.denominator*b.denominator;
 x:=a.numerator*INTEGER(b.denominator);
 y:=b.numerator*INTEGER(a.denominator);
 IF ((y>0) AND (x>MAX(INTEGER)-y)) OR ((y<0) AND (x<MIN(INTEGER)-y)) THEN RETURN FALSE END;
 r.numerator:=x+y;
 r.denominator:=d;
 Normalize(r);
 RETURN TRUE END Add;

PROCEDURE Subtract (a,b: Rational;
 VAR r: Rational): BOOLEAN;

VAR neg: Rational;

BEGIN neg:=b;
 IF neg.numerator=MIN(INTEGER) THEN RETURN FALSE END;
 neg.numerator:=-neg.numerator;
 RETURN Add(a,neg,r) END Subtract;

PROCEDURE Multiply (a,b: Rational;
 VAR r: Rational): BOOLEAN;

VAR x,y: INTEGER;
 d: CARDINAL;

BEGIN IF (a.denominator=0) OR (b.denominator=0) THEN RETURN FALSE END;
 IF (a.numerator#0) AND (ABS(b.numerator)>MAX(INTEGER) DIV ABS(a.numerator)) THEN RETURN FALSE END;
 IF a.denominator>MAX(CARDINAL) DIV b.denominator THEN RETURN FALSE END;
 x:=a.numerator*b.numerator;
 d:=a.denominator*b.denominator;
 r.numerator:=x;
 r.denominator:=d;
 Normalize(r);
 RETURN TRUE END Multiply;

PROCEDURE Divide (a,b: Rational;
 VAR r: Rational): BOOLEAN;

VAR sign: INTEGER;
 n: INTEGER;
 d: CARDINAL;

BEGIN IF (a.denominator=0) OR (b.denominator=0) OR (b.numerator=0) THEN RETURN FALSE END;
 sign:=1;
 n:=b.numerator;
 IF n<0 THEN sign:=-1;
 n:=-n END;
 IF a.denominator>MAX(CARDINAL) DIV CARDINAL(n) THEN RETURN FALSE END;
 d:=a.denominator*CARDINAL(n);
 IF b.denominator>MAX(CARDINAL) DIV CARDINAL(ABS(a.numerator)) THEN RETURN FALSE END;
 r.numerator:=a.numerator*INTEGER(b.denominator)*sign;
 r.denominator:=d;
 Normalize(r);
 RETURN TRUE END Divide;

PROCEDURE Compare (a,b: Rational): INTEGER;

VAR x,y: REAL;

BEGIN IF (a.denominator=0) OR (b.denominator=0) THEN RETURN 0 END;
 x:=FLOAT(a.numerator)/FLOAT(a.denominator);
 y:=FLOAT(b.numerator)/FLOAT(b.denominator);
 IF x<y THEN RETURN -1 ELSIF x>y THEN RETURN 1 ELSE RETURN 0 END END Compare;

PROCEDURE ToReal (r: Rational;
 VAR value: REAL): BOOLEAN;

BEGIN IF r.denominator=0 THEN value:=0.0;
 RETURN FALSE END;
 value:=FLOAT(r.numerator)/FLOAT(r.denominator);
 RETURN TRUE END ToReal;

END M2Rational.
