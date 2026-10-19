(* Assistant-added demo. Written, not executed: gm2 was unavailable. *)
MODULE stack_demo;
FROM M2Stack IMPORT Stack, Create, Destroy, Push, Pop, Peek, Size, IsEmpty;
VAR s: Stack; v: CARDINAL;
BEGIN
  s:=Create();
  IF NOT IsEmpty(s) THEN HALT(1) END;
  IF Pop(s,v) THEN HALT(2) END;
  IF NOT Push(s,10) THEN HALT(3) END;
  IF NOT Push(s,20) THEN HALT(4) END;
  IF Size(s)#2 THEN HALT(5) END;
  IF NOT Peek(s,v) OR (v#20) THEN HALT(6) END;
  IF NOT Pop(s,v) OR (v#20) THEN HALT(7) END;
  IF NOT Pop(s,v) OR (v#10) THEN HALT(8) END;
  IF NOT IsEmpty(s) THEN HALT(9) END;
  Destroy(s);
END stack_demo.
