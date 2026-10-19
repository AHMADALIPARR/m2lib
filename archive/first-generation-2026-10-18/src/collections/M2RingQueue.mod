IMPLEMENTATION MODULE M2RingQueue;

FROM M2Errors IMPORT ReportError, ErrInvalidArgument, ErrUnderflow, ErrOutOfMemory;

PROCEDURE Create (capacity: CARDINAL): Queue;

VAR q: Queue;

BEGIN IF capacity=0 THEN capacity:=16 END;
 NEW(q);
 IF q=NIL THEN ReportError(ErrOutOfMemory,"RingQueue.Create");
 RETURN NIL END;

 NEW(q^.data,capacity);
 IF q^.data=NIL THEN DISPOSE(q);
 ReportError(ErrOutOfMemory,"RingQueue.buffer");
 RETURN NIL END;

 q^.head:=0;
 q^.len:=0;
 q^.cap:=capacity;
 RETURN q;

END Create;

PROCEDURE Destroy (VAR q: Queue);

BEGIN IF q#NIL THEN IF q^.data#NIL THEN DISPOSE(q^.data) END;
 DISPOSE(q);
 q:=NIL END END Destroy;

PROCEDURE Enqueue (q: Queue;
 value: CARDINAL): BOOLEAN;

VAR tail: CARDINAL;

BEGIN IF q=NIL THEN RETURN FALSE END;
 IF q^.len=q^.cap THEN RETURN FALSE END;
 tail:=(q^.head+q^.len) MOD q^.cap;
 q^.data^[tail]:=value;
 INC(q^.len);
 RETURN TRUE END Enqueue;

PROCEDURE Dequeue (q: Queue;
 VAR value: CARDINAL): BOOLEAN;

BEGIN IF (q=NIL) OR (q^.len=0) THEN ReportError(ErrUnderflow,"RingQueue.Dequeue");
 RETURN FALSE END;
 value:=q^.data^[q^.head];
 q^.head:=(q^.head+1) MOD q^.cap;
 DEC(q^.len);
 RETURN TRUE END Dequeue;

PROCEDURE Front (q: Queue;
 VAR value: CARDINAL): BOOLEAN;

BEGIN IF (q=NIL) OR (q^.len=0) THEN RETURN FALSE END;
 value:=q^.data^[q^.head];
 RETURN TRUE END Front;

PROCEDURE Size (q: Queue): CARDINAL;
 BEGIN IF q=NIL THEN RETURN 0 ELSE RETURN q^.len END END Size;

PROCEDURE Capacity (q: Queue): CARDINAL;
 BEGIN IF q=NIL THEN RETURN 0 ELSE RETURN q^.cap END END Capacity;

PROCEDURE IsEmpty (q: Queue): BOOLEAN;
 BEGIN RETURN (q=NIL) OR (q^.len=0) END IsEmpty;

PROCEDURE IsFull (q: Queue): BOOLEAN;
 BEGIN RETURN (q#NIL) AND (q^.len=q^.cap) END IsFull;

PROCEDURE Clear (q: Queue);
 BEGIN IF q#NIL THEN q^.head:=0;
 q^.len:=0 END END Clear;

END M2RingQueue.
