IMPLEMENTATION MODULE M2List;

TYPE Node = POINTER TO NodeDesc;
 NodeDesc = RECORD value: CARDINAL;
 next: Node END;

PROCEDURE Create (): List;
 VAR list: List;
 BEGIN NEW(list);
 IF list#NIL THEN list^.first:=NIL;
 list^.last:=NIL;
 list^.len:=0 END;
 RETURN list END Create;

PROCEDURE Clear (list: List);
 VAR p,q: Node;
 BEGIN IF list=NIL THEN RETURN END;
 p:=list^.first;
 WHILE p#NIL DO q:=p^.next;
 DISPOSE(p);
 p:=q END;
 list^.first:=NIL;
 list^.last:=NIL;
 list^.len:=0 END Clear;

PROCEDURE Destroy (VAR list: List);
 BEGIN IF list#NIL THEN Clear(list);
 DISPOSE(list);
 list:=NIL END END Destroy;

PROCEDURE Append (list: List;
 value: CARDINAL): BOOLEAN;
 VAR p: Node;
 BEGIN IF list=NIL THEN RETURN FALSE END;
 NEW(p);
 IF p=NIL THEN RETURN FALSE END;
 p^.value:=value;
 p^.next:=NIL;
 IF list^.last=NIL THEN list^.first:=p ELSE list^.last^.next:=p END;
 list^.last:=p;
 INC(list^.len);
 RETURN TRUE END Append;

PROCEDURE Prepend (list: List;
 value: CARDINAL): BOOLEAN;
 VAR p: Node;
 BEGIN IF list=NIL THEN RETURN FALSE END;
 NEW(p);
 IF p=NIL THEN RETURN FALSE END;
 p^.value:=value;
 p^.next:=list^.first;
 list^.first:=p;
 IF list^.last=NIL THEN list^.last:=p END;
 INC(list^.len);
 RETURN TRUE END Prepend;

PROCEDURE RemoveFirst (list: List;
 VAR value: CARDINAL): BOOLEAN;
 VAR p: Node;
 BEGIN IF (list=NIL) OR (list^.first=NIL) THEN RETURN FALSE END;
 p:=list^.first;
 value:=p^.value;
 list^.first:=p^.next;
 IF list^.first=NIL THEN list^.last:=NIL END;
 DISPOSE(p);
 DEC(list^.len);
 RETURN TRUE END RemoveFirst;

PROCEDURE Get (list: List;
 index: CARDINAL;
 VAR value: CARDINAL): BOOLEAN;
 VAR p: Node;
 i: CARDINAL;
 BEGIN IF (list=NIL) OR (index>=list^.len) THEN RETURN FALSE END;
 p:=list^.first;
 FOR i:=0 TO index-1 DO p:=p^.next END;
 value:=p^.value;
 RETURN TRUE END Get;

PROCEDURE Set (list: List;
 index,value: CARDINAL): BOOLEAN;
 VAR p: Node;
 i: CARDINAL;
 BEGIN IF (list=NIL) OR (index>=list^.len) THEN RETURN FALSE END;
 p:=list^.first;
 FOR i:=0 TO index-1 DO p:=p^.next END;
 p^.value:=value;
 RETURN TRUE END Set;

PROCEDURE Length (list: List): CARDINAL;
 BEGIN IF list=NIL THEN RETURN 0 ELSE RETURN list^.len END END Length;

PROCEDURE IsEmpty (list: List): BOOLEAN;
 BEGIN RETURN (list=NIL) OR (list^.len=0) END IsEmpty;

PROCEDURE Reverse (list: List);
 VAR prev,current,next: Node;
 BEGIN IF list=NIL THEN RETURN END;
 prev:=NIL;
 current:=list^.first;
 list^.last:=list^.first;
 WHILE current#NIL DO next:=current^.next;
 current^.next:=prev;
 prev:=current;
 current:=next END;
 list^.first:=prev END Reverse;

END M2List.
