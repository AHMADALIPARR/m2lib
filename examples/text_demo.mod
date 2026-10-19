(* Assistant-added demo. Written, not executed: gm2 was unavailable.
   M2Chars and M2Strings both export ToUpper/ToLower, so this file imports
   ToUpper only from M2Strings and the non-colliding predicates from M2Chars. *)
MODULE text_demo;
FROM M2Chars IMPORT IsAlpha, IsDigit, IsHexDigit, IsAlNum, IsSpace, HexValue;
FROM M2Strings IMPORT Length, Equal, Index, StartsWith, EndsWith, IsEmpty, Trim, Reverse, ToUpper;
FROM M2UTF8 IMPORT IsValid, DecodeRune, CountRunes;
VAR buf: ARRAY [0..63] OF CHAR; s: ARRAY [0..7] OF CHAR;
    rune, width, count: CARDINAL; ok: BOOLEAN;
BEGIN
  IF NOT IsAlpha('A') THEN HALT(1) END;
  IF IsAlpha('5') THEN HALT(2) END;
  IF NOT IsDigit('5') THEN HALT(3) END;
  IF NOT IsHexDigit('F') THEN HALT(4) END;
  IF NOT IsAlNum('z') THEN HALT(5) END;
  IF NOT IsSpace(' ') THEN HALT(6) END;
  IF HexValue('F')#15 THEN HALT(7) END;
  IF HexValue('z')#MAX(CARDINAL) THEN HALT(8) END;
  IF Length("hello")#5 THEN HALT(9) END;
  IF NOT Equal("abc","abc") THEN HALT(10) END;
  IF Index("hello","ell")#1 THEN HALT(11) END;
  IF Index("hello","z")#-1 THEN HALT(12) END;
  IF NOT StartsWith("library","lib") THEN HALT(13) END;
  IF NOT EndsWith("library","ary") THEN HALT(14) END;
  IF NOT IsEmpty("") THEN HALT(15) END;
  Trim("  hi  ",buf);
  IF NOT Equal(buf,"hi") THEN HALT(16) END;
  Reverse("abc",buf);
  IF NOT Equal(buf,"cba") THEN HALT(17) END;
  ToUpper("abc",buf);
  IF NOT Equal(buf,"ABC") THEN HALT(18) END;
  IF NOT IsValid("hello") THEN HALT(19) END;
  ok:=DecodeRune("A",0,rune,width);
  IF NOT ok OR (rune#65) OR (width#1) THEN HALT(20) END;
  ok:=CountRunes("hello",count);
  IF NOT ok OR (count#5) THEN HALT(21) END;
  s[0]:=CHR(195); s[1]:=CHR(169); s[2]:=0C;
  IF NOT IsValid(s) THEN HALT(22) END;
  ok:=CountRunes(s,count);
  IF NOT ok OR (count#1) THEN HALT(23) END;
  ok:=DecodeRune(s,0,rune,width);
  IF NOT ok OR (rune#233) OR (width#2) THEN HALT(24) END;
END text_demo.
