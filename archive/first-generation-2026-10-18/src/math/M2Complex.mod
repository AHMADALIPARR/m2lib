IMPLEMENTATION MODULE M2Complex;

PROCEDURE Make (re,im: REAL): Complex;
 VAR z: Complex;
 BEGIN z.re:=re;
 z.im:=im;
 RETURN z END Make;

PROCEDURE Add (a,b: Complex): Complex;
 VAR z: Complex;
 BEGIN z.re:=a.re+b.re;
 z.im:=a.im+b.im;
 RETURN z END Add;

PROCEDURE Subtract (a,b: Complex): Complex;
 VAR z: Complex;
 BEGIN z.re:=a.re-b.re;
 z.im:=a.im-b.im;
 RETURN z END Subtract;

PROCEDURE Multiply (a,b: Complex): Complex;
 VAR z: Complex;
 BEGIN z.re:=a.re*b.re-a.im*b.im;
 z.im:=a.re*b.im+a.im*b.re;
 RETURN z END Multiply;

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

PROCEDURE MagnitudeSquared (z: Complex): REAL;
 BEGIN RETURN z.re*z.re+z.im*z.im END MagnitudeSquared;

PROCEDURE Conjugate (z: Complex): Complex;
 VAR r: Complex;
 BEGIN r.re:=z.re;
 r.im:=-z.im;
 RETURN r END Conjugate;

PROCEDURE Scale (z: Complex;
 factor: REAL): Complex;
 VAR r: Complex;
 BEGIN r.re:=z.re*factor;
 r.im:=z.im*factor;
 RETURN r END Scale;

END M2Complex.
