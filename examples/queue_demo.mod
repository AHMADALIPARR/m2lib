(* Assistant-added demo. Written, not executed: gm2 was unavailable. *)
MODULE queue_demo;
FROM M2Queue IMPORT Queue, Create, Destroy, Enqueue, Dequeue, Front, Size, IsEmpty, Clear;
VAR q: Queue; v: CARDINAL;
BEGIN
  q:=Create(2);
  IF q=NIL THEN HALT(1) END;
  IF NOT IsEmpty(q) THEN HALT(2) END;
  IF Dequeue(q,v) THEN HALT(3) END;
  IF NOT Enqueue(q,10) THEN HALT(4) END;
  IF NOT Enqueue(q,20) THEN HALT(5) END;
  IF Enqueue(q,30) THEN HALT(6) END;
  IF Size(q)#2 THEN HALT(7) END;
  IF NOT Front(q,v) OR (v#10) THEN HALT(8) END;
  IF NOT Dequeue(q,v) OR (v#10) THEN HALT(9) END;
  Clear(q);
  IF NOT IsEmpty(q) THEN HALT(10) END;
  Destroy(q);
END queue_demo.
