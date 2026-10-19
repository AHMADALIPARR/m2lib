IMPLEMENTATION MODULE M2Hex;

FROM M2Char IMPORT HexValue;

CONST digits = "0123456789ABCDEF";

PROCEDURE Encode (src: ARRAY OF CHAR;
 length: CARDINAL;
 VAR dst: ARRAY OF CHAR): BOOLEAN;

VAR i: CARDINAL;
 b: CARDINAL;

BEGIN IF length>HIGH(src)+1 THEN RETURN FALSE END;
 IF length*2>HIGH(dst) THEN RETURN FALSE END;
 FOR i:=0 TO length-1 DO b:=ORD(src[i]);
 dst[2*i]:=digits[b DIV 16];
 dst[2*i+1]:=digits[b MOD 16] END;
 dst[length*2]:=0C;
 RETURN TRUE END Encode;

PROCEDURE Decode (src: ARRAY OF CHAR;
 VAR dst: ARRAY OF CHAR;
 VAR written: CARDINAL): BOOLEAN;

VAR i,n,a,b: CARDINAL;

BEGIN n:=0;
 WHILE (n<=HIGH(src)) AND (src[n]#0C) DO INC(n) END;
 IF n MOD 2#0 THEN written:=0;
 RETURN FALSE END;
 IF n DIV 2>HIGH(dst) THEN written:=0;
 RETURN FALSE END;
 i:=0;
 WHILE i<n DO IF NOT HexValue(src[i],a) OR NOT HexValue(src[i+1],b) THEN written:=0;
 RETURN FALSE END;
 dst[i DIV 2]:=CHR(a*16+b);
 INC(i,2) END;
 written:=n DIV 2;
 RETURN TRUE END Decode;

END M2Hex.
