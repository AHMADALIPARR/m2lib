IMPLEMENTATION MODULE M2Graph;

PROCEDURE Create (vertices: CARDINAL): Graph;

VAR g: Graph;
 i: CARDINAL;

BEGIN IF (vertices=0) OR (vertices>256) THEN RETURN NIL END;
 NEW(g);
 IF g=NIL THEN RETURN NIL END;
 NEW(g^.matrix,vertices*vertices);
 IF g^.matrix=NIL THEN DISPOSE(g);
 RETURN NIL END;
 g^.vertices:=vertices;
 g^.edges:=0;
 FOR i:=0 TO vertices*vertices-1 DO g^.matrix^[i]:=0 END;
 RETURN g END Create;

PROCEDURE Destroy (VAR g: Graph);
 BEGIN IF g#NIL THEN IF g^.matrix#NIL THEN DISPOSE(g^.matrix) END;
 DISPOSE(g);
 g:=NIL END END Destroy;

PROCEDURE AddEdge (g: Graph;
 fromVertex,toVertex: CARDINAL;
 directed: BOOLEAN): BOOLEAN;

BEGIN IF (g=NIL) OR (fromVertex>=g^.vertices) OR (toVertex>=g^.vertices) THEN RETURN FALSE END;
 IF g^.matrix^[fromVertex*g^.vertices+toVertex]=0 THEN INC(g^.edges) END;
 g^.matrix^[fromVertex*g^.vertices+toVertex]:=1;
 IF NOT directed THEN g^.matrix^[toVertex*g^.vertices+fromVertex]:=1 END;
 RETURN TRUE END AddEdge;

PROCEDURE RemoveEdge (g: Graph;
 fromVertex,toVertex: CARDINAL;
 directed: BOOLEAN): BOOLEAN;

BEGIN IF (g=NIL) OR (fromVertex>=g^.vertices) OR (toVertex>=g^.vertices) THEN RETURN FALSE END;
 IF g^.matrix^[fromVertex*g^.vertices+toVertex]#0 THEN DEC(g^.edges) END;
 g^.matrix^[fromVertex*g^.vertices+toVertex]:=0;
 IF NOT directed THEN g^.matrix^[toVertex*g^.vertices+fromVertex]:=0 END;
 RETURN TRUE END RemoveEdge;

PROCEDURE HasEdge (g: Graph;
 fromVertex,toVertex: CARDINAL): BOOLEAN;
 BEGIN IF (g=NIL) OR (fromVertex>=g^.vertices) OR (toVertex>=g^.vertices) THEN RETURN FALSE END;
 RETURN g^.matrix^[fromVertex*g^.vertices+toVertex]#0 END HasEdge;

PROCEDURE Degree (g: Graph;
 vertex: CARDINAL): CARDINAL;
 VAR i,n: CARDINAL;
 BEGIN IF (g=NIL) OR (vertex>=g^.vertices) THEN RETURN 0 END;
 n:=0;
 FOR i:=0 TO g^.vertices-1 DO IF g^.matrix^[vertex*g^.vertices+i]#0 THEN INC(n) END END;
 RETURN n END Degree;

PROCEDURE BFS (g: Graph;
 start: CARDINAL;
 VAR order: ARRAY OF CARDINAL;
 VAR count: CARDINAL);

VAR seen: ARRAY [0..255] OF BOOLEAN;
 queue: ARRAY [0..255] OF CARDINAL;
 head,tail,v,w,i: CARDINAL;

BEGIN count:=0;
 IF (g=NIL) OR (start>=g^.vertices) OR (g^.vertices>HIGH(order)+1) THEN RETURN END;
 FOR i:=0 TO g^.vertices-1 DO seen[i]:=FALSE END;
 head:=0;
 tail:=1;
 queue[0]:=start;
 seen[start]:=TRUE;
 WHILE head<tail DO v:=queue[head];
 INC(head);
 order[count]:=v;
 INC(count);
 FOR w:=0 TO g^.vertices-1 DO IF (g^.matrix^[v*g^.vertices+w]#0) AND NOT seen[w] THEN seen[w]:=TRUE;
 queue[tail]:=w;
 INC(tail) END END END END BFS;

PROCEDURE DFS (g: Graph;
 start: CARDINAL;
 VAR order: ARRAY OF CARDINAL;
 VAR count: CARDINAL);

VAR seen: ARRAY [0..255] OF BOOLEAN;
 stack: ARRAY [0..255] OF CARDINAL;
 top,v,w,i: CARDINAL;

BEGIN count:=0;
 IF (g=NIL) OR (start>=g^.vertices) OR (g^.vertices>HIGH(order)+1) THEN RETURN END;
 FOR i:=0 TO g^.vertices-1 DO seen[i]:=FALSE END;
 top:=1;
 stack[0]:=start;
 WHILE top>0 DO DEC(top);
 v:=stack[top];
 IF NOT seen[v] THEN seen[v]:=TRUE;
 order[count]:=v;
 INC(count);
 w:=g^.vertices;
 WHILE w>0 DO DEC(w);
 IF (g^.matrix^[v*g^.vertices+w]#0) AND NOT seen[w] THEN stack[top]:=w;
 INC(top) END END END END END DFS;

END M2Graph.
