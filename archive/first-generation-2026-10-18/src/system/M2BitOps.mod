IMPLEMENTATION MODULE M2BitOps;
FROM SYSTEM IMPORT TSIZE;

PROCEDURE Test (value,bit: CARDINAL): BOOLEAN;
 BEGIN IF bit>=TSIZE(CARDINAL)*8 THEN RETURN FALSE END;
 RETURN (value AND (1<<bit))#0 END Test;

PROCEDURE Set (value,bit: CARDINAL): CARDINAL;
 BEGIN IF bit>=TSIZE(CARDINAL)*8 THEN RETURN value END;
 RETURN value OR (1<<bit) END Set;

PROCEDURE Clear (value,bit: CARDINAL): CARDINAL;
 BEGIN IF bit>=TSIZE(CARDINAL)*8 THEN RETURN value END;
 RETURN value AND NOT (1<<bit) END Clear;

PROCEDURE Toggle (value,bit: CARDINAL): CARDINAL;
 BEGIN IF bit>=TSIZE(CARDINAL)*8 THEN RETURN value END;
 RETURN value XOR (1<<bit) END Toggle;

PROCEDURE Count (value: CARDINAL): CARDINAL;

VAR n: CARDINAL;

BEGIN n:=0;
 WHILE value#0 DO value:=value AND (value-1);
 INC(n) END;
 RETURN n END Count;

PROCEDURE LeadingZeros (value: CARDINAL): CARDINAL;

VAR n: CARDINAL;
 mask: CARDINAL;

BEGIN n:=0;
 mask:=1<<(TSIZE(CARDINAL)*8-1);
 WHILE (mask#0) AND ((value AND mask)=0) DO INC(n);
 mask:=mask>>1 END;
 RETURN n END LeadingZeros;

PROCEDURE RotateLeft (value,amount: CARDINAL): CARDINAL;

VAR bits: CARDINAL;

BEGIN bits:=TSIZE(CARDINAL)*8;
 amount:=amount MOD bits;
 IF amount=0 THEN RETURN value END;
 RETURN (value<<amount) OR (value>>(bits-amount)) END RotateLeft;

END M2BitOps.
