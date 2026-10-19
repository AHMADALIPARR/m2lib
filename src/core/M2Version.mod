IMPLEMENTATION MODULE M2Version;

PROCEDURE VersionString(VAR s:ARRAY OF CHAR);

VAR i:CARDINAL;

v:ARRAY [0..10] OF CHAR;

BEGIN v:="M2Lib 0.1.0";

i:=0;

WHILE (i<=HIGH(v)) AND (i<=HIGH(s)) DO s[i]:=v[i];

INC(i) END END VersionString;

END M2Version.
