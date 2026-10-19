IMPLEMENTATION MODULE M2Hash;

PROCEDURE FNV1a32 (data: ARRAY OF CHAR;
 length: CARDINAL): CARDINAL;

VAR i,h: CARDINAL;

BEGIN IF length>HIGH(data)+1 THEN length:=HIGH(data)+1 END;
 h:=16#811C9DC5;
 FOR i:=0 TO length-1 DO h:=h XOR ORD(data[i]);
 h:=h*16#01000193 END;
 RETURN h END FNV1a32;

PROCEDURE DJB2 (data: ARRAY OF CHAR;
 length: CARDINAL): CARDINAL;

VAR i,h: CARDINAL;

BEGIN IF length>HIGH(data)+1 THEN length:=HIGH(data)+1 END;
 h:=5381;
 FOR i:=0 TO length-1 DO h:=h*33+ORD(data[i]) END;
 RETURN h END DJB2;

END M2Hash.
