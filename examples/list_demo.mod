(* Assistant-added demo. Written, not executed: gm2 was unavailable. *)
MODULE list_demo;
FROM M2List IMPORT List, Create, Destroy, Append, Prepend, RemoveFirst, Length, Contains;
VAR l: List; v: CARDINAL;
BEGIN
  l:=Create();
  IF Length(l)#0 THEN HALT(1) END;
  IF RemoveFirst(l,v) THEN HALT(2) END;
  IF NOT Append(l,10) THEN HALT(3) END;
  IF NOT Append(l,20) THEN HALT(4) END;
  IF NOT Prepend(l,5) THEN HALT(5) END;
  IF Length(l)#3 THEN HALT(6) END;
  IF NOT Contains(l,20) THEN HALT(7) END;
  IF Contains(l,99) THEN HALT(8) END;
  IF NOT RemoveFirst(l,v) OR (v#5) THEN HALT(9) END;
  IF Length(l)#2 THEN HALT(10) END;
  Destroy(l);
END list_demo.
