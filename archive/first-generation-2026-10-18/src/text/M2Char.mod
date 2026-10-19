IMPLEMENTATION MODULE M2Char;

PROCEDURE IsAlpha (c: CHAR): BOOLEAN;

BEGIN RETURN ((c >= 'A') AND (c <= 'Z')) OR ((c >= 'a') AND (c <= 'z')) END IsAlpha;

PROCEDURE IsDigit (c: CHAR): BOOLEAN;

BEGIN RETURN (c >= '0') AND (c <= '9') END IsDigit;

PROCEDURE IsAlphaNum (c: CHAR): BOOLEAN;

BEGIN RETURN IsAlpha(c) OR IsDigit(c) END IsAlphaNum;

PROCEDURE IsSpace (c: CHAR): BOOLEAN;

BEGIN RETURN (c = ' ') OR (c = 11C) OR (c = 12C) OR (c = 15C) OR (c = 12X) OR (c = 40X) END IsSpace;

PROCEDURE IsUpper (c: CHAR): BOOLEAN;

BEGIN RETURN (c >= 'A') AND (c <= 'Z') END IsUpper;

PROCEDURE IsLower (c: CHAR): BOOLEAN;

BEGIN RETURN (c >= 'a') AND (c <= 'z') END IsLower;

PROCEDURE ToUpper (c: CHAR): CHAR;

BEGIN IF IsLower(c) THEN RETURN CHR(ORD(c)-ORD('a')+ORD('A')) ELSE RETURN c END END ToUpper;

PROCEDURE ToLower (c: CHAR): CHAR;

BEGIN IF IsUpper(c) THEN RETURN CHR(ORD(c)-ORD('A')+ORD('a')) ELSE RETURN c END END ToLower;

PROCEDURE IsHexDigit (c: CHAR): BOOLEAN;

BEGIN RETURN IsDigit(c) OR ((ToUpper(c) >= 'A') AND (ToUpper(c) <= 'F')) END IsHexDigit;

PROCEDURE HexValue (c: CHAR;
 VAR value: CARDINAL): BOOLEAN;

VAR u: CHAR;

BEGIN
  u := ToUpper(c);

  IF IsDigit(u) THEN value := ORD(u)-ORD('0');
 RETURN TRUE END;

  IF (u >= 'A') AND (u <= 'F') THEN value := ORD(u)-ORD('A')+10;
 RETURN TRUE END;

  value := 0;
 RETURN FALSE;

END HexValue;

END M2Char.
