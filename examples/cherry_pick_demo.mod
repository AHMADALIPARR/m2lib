(* SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001 *)
(* Copyright (c) 2026 Ahmad Ali Parr. All rights reserved. *)
(* Authored by Ahmad Ali Parr. *)
(* Licensed under the SNAPKITTY OPAQUE SOURCE LICENSE v1.0. See LICENSE. *)

(* Assistant-added demo, written not executed. Covers the 16 modules
   cherry-picked from the first generation (see docs/SOURCES.md).
   All imports are qualified to avoid the name collisions between
   M2BST/M2Graph/M2RingQueue (Create/Destroy), M2Base64/M2Hex
   (Encode/Decode), and M2Text/M2KMP (Find).
   M2Graph BFS/DFS are NOT called here: their .def declares a BOOLEAN
   result but the .mod implements them with no return (known defect,
   documented in docs/SOURCES.md). *)

MODULE cherry_pick_demo;

IMPORT M2BST, M2Graph, M2KMP, M2Base64, M2Char, M2Hex, M2Parse, M2Text,
       M2Integer, M2Rational, M2Stats, M2Interpolation, M2CRC16, M2BitOps,
       M2Date, M2RingQueue;

VAR
  t: M2BST.Tree;
  g: M2Graph.Graph;
  q: M2RingQueue.Queue;
  d: M2Date.Date;
  r, r2: M2Rational.Rational;
  buf, buf2: ARRAY [0..63] OF CHAR;
  nums: ARRAY [0..7] OF CARDINAL;
  reals: ARRAY [0..7] OF REAL;
  count, v, w: CARDINAL;
  pos: CARDINAL;
  iv: INTEGER;
  rv, rv2: REAL;
  ok: BOOLEAN;
  c: CHAR;
  b: BOOLEAN;

PROCEDURE Demo;
BEGIN
  (* M2BST: binary search tree *)
  t := M2BST.Create();
  ok := M2BST.Insert(t, 5);
  ok := M2BST.Insert(t, 3);
  ok := M2BST.Insert(t, 7);
  b := M2BST.Contains(t, 3);
  ok := M2BST.Minimum(t, v);
  ok := M2BST.Maximum(t, w);
  count := M2BST.Size(t);
  ok := M2BST.InOrder(t, nums, count);
  ok := M2BST.Remove(t, 3);
  M2BST.Destroy(t);

  (* M2Graph: adjacency-matrix graph. BFS/DFS not called: see header note. *)
  g := M2Graph.Create(4);
  ok := M2Graph.AddEdge(g, 0, 1, FALSE);
  ok := M2Graph.AddEdge(g, 1, 2, FALSE);
  b := M2Graph.HasEdge(g, 0, 1);
  count := M2Graph.Degree(g, 1);
  ok := M2Graph.RemoveEdge(g, 0, 1, FALSE);
  M2Graph.Destroy(g);

  (* M2KMP: Knuth-Morris-Pratt search *)
  ok := M2KMP.Find("hello world", "world", 0, pos);
  count := M2KMP.CountMatches("aaa", "aa");

  (* M2Base64 / M2Hex: codec pairs *)
  ok := M2Base64.Encode("Man", 3, buf);
  ok := M2Base64.Decode("TWFu", buf2, count);
  ok := M2Hex.Encode("AB", 2, buf);
  ok := M2Hex.Decode("4142", buf2, count);

  (* M2Char: single-character classification *)
  b := M2Char.IsAlpha('A');
  b := M2Char.IsDigit('7');
  b := M2Char.IsAlphaNum('x');
  b := M2Char.IsSpace(' ');
  b := M2Char.IsUpper('Z');
  b := M2Char.IsLower('z');
  c := M2Char.ToUpper('a');
  c := M2Char.ToLower('B');
  b := M2Char.IsHexDigit('F');
  ok := M2Char.HexValue('F', v);

  (* M2Parse: string to number/boolean *)
  ok := M2Parse.ParseCardinal("123", v);
  ok := M2Parse.ParseInteger("-42", iv);
  ok := M2Parse.ParseHex("0xFF", v);
  ok := M2Parse.ParseBoolean("true", b);

  (* M2Text: NUL-terminated string helpers *)
  count := M2Text.Length("hello");
  b := M2Text.Equal("abc", "abc");
  iv := M2Text.Compare("abc", "abd");
  ok := M2Text.Find("hello", "ell", pos);
  b := M2Text.StartsWith("hello", "he");
  b := M2Text.EndsWith("hello", "lo");
  ok := M2Text.Copy("hello", buf);
  M2Text.TrimLeft("  hi", buf);
  M2Text.TrimRight("hi  ", buf);
  M2Text.Trim("  hi  ", buf);
  M2Text.ReplaceChar("hello", 'l', 'L', buf);
  count := M2Text.CountChar("hello", 'l');

  (* M2Integer: integer arithmetic helpers *)
  count := M2Integer.GCD(12, 18);
  ok := M2Integer.LCM(4, 6, v);
  b := M2Integer.IsEven(4);
  b := M2Integer.IsOdd(3);
  b := M2Integer.IsPowerOfTwo(8);
  ok := M2Integer.CeilDiv(7, 2, v);
  count := M2Integer.Clamp(9, 0, 5);

  (* M2Rational: exact rational arithmetic *)
  ok := M2Rational.Make(1, 2, r);
  ok := M2Rational.Make(1, 3, r2);
  ok := M2Rational.Add(r, r2, r);
  ok := M2Rational.Subtract(r, r2, r);
  ok := M2Rational.Multiply(r, r2, r);
  ok := M2Rational.Divide(r, r2, r);
  iv := M2Rational.Compare(r, r2);
  ok := M2Rational.ToReal(r, rv);

  (* M2Stats: real-array statistics *)
  reals[0] := 1.0; reals[1] := 2.0; reals[2] := 3.0; reals[3] := 4.0;
  rv := M2Stats.Sum(reals, 4);
  ok := M2Stats.Mean(reals, 4, rv);
  ok := M2Stats.Variance(reals, 4, FALSE, rv);
  ok := M2Stats.MinMax(reals, 4, rv, rv2);

  (* M2Interpolation: interpolation, quadrature, root finding *)
  ok := M2Interpolation.Linear(0.0, 0.0, 2.0, 4.0, 1.0, rv);
  ok := M2Interpolation.Trapezoid(0.0, 1.0, 10, rv);
  ok := M2Interpolation.Bisect(1.0, 2.0, 0.001, 50, rv);
  ok := M2Interpolation.Lagrange(reals, reals, 4, 1.5, rv);

  (* M2CRC16: CRC-16 variants *)
  count := M2CRC16.CCITT("123456789", 9);
  count := M2CRC16.Modbus("123456789", 9);

  (* M2BitOps: word-level bit operations *)
  b := M2BitOps.Test(5, 0);
  count := M2BitOps.Set(0, 3);
  count := M2BitOps.Clear(15, 1);
  count := M2BitOps.Toggle(5, 0);
  count := M2BitOps.Count(7);
  count := M2BitOps.LeadingZeros(1);
  count := M2BitOps.RotateLeft(1, 1);

  (* M2Date: calendar dates *)
  b := M2Date.IsLeapYear(2024);
  count := M2Date.DaysInMonth(2024, 2);
  d.year := 2024; d.month := 2; d.day := 29;
  b := M2Date.Valid(d);
  ok := M2Date.DayOfYear(d, count);
  ok := M2Date.Weekday(d, w);

  (* M2RingQueue: bounded ring buffer *)
  q := M2RingQueue.Create(4);
  ok := M2RingQueue.Enqueue(q, 10);
  ok := M2RingQueue.Enqueue(q, 20);
  ok := M2RingQueue.Dequeue(q, v);
  ok := M2RingQueue.Front(q, v);
  count := M2RingQueue.Size(q);
  count := M2RingQueue.Capacity(q);
  b := M2RingQueue.IsEmpty(q);
  b := M2RingQueue.IsFull(q);
  M2RingQueue.Clear(q);
  M2RingQueue.Destroy(q);
END Demo;

BEGIN
  Demo
END cherry_pick_demo.
