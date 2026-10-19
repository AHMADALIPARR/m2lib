# Edge cases — assistant-added

Every row below is traced from the corresponding `.mod` implementation by reading
the source. None has been executed: `gm2` is unavailable, so these are
**expected values for the first `gm2` run**, not observed results.
`tests/unit/test_edge_cases.mod` asserts each one with the HALT code shown.
`tools/check_edge_cases.py` checks the table and the test file stay in sync.

| # | Edge case | Expected | Traced from |
|---|---|---|---|
| 1 | `IsPowerOfTwo(0)` | `FALSE` | `M2Limits.mod`: explicit `n=0` guard |
| 2 | `Log2Floor(0)` | `0` | `M2Limits.mod`: explicit `n=0` guard |
| 3 | `NextPowerOfTwo(0)` | `1` | `M2Limits.mod`: `n<=1` returns 1 |
| 4 | `NextPowerOfTwo(1)` | `1` | `M2Limits.mod`: `n<=1` returns 1 |
| 5 | `GCD(0,0)` | `0` | `M2Math.mod`: loop body never runs, returns `a` |
| 6 | `GCD(0,5)` | `5` | `M2Math.mod`: Euclid with `a=0` |
| 7 | `LCM(0,5)` | `TRUE`, result `0` | `M2Math.mod`: explicit zero guard |
| 8 | `Factorial(0)` | `TRUE`, result `1` | `M2Math.mod`: loop `2..0` runs zero times |
| 9 | `Clamp(5,10,3)` | `10` | `M2Math.mod`: `lo>hi` returns `lo` |
| 10 | `Linear([1,3,5],2)` | `-1` | `M2Search.mod`: no match |
| 11 | `Binary([1,3,5],2)` | `-1` | `M2Search.mod`: `LowerBound` points at `3`, not `2` |
| 12 | `LowerBound([1,3,5],2)` | `1` | `M2Search.mod`: first element `>= 2` |
| 13 | `UpperBound([1,3,5],2)` | `1` | `M2Search.mod`: first element `> 2` |
| 14 | `HeapSort` on 1-element array | unchanged | `M2Sort.mod`: `HIGH(a)<1` returns |
| 15 | `M2Stack` fresh `IsEmpty` | `TRUE` | `M2Stack.mod`: `Create` returns `NIL` |
| 16 | `M2Stack.Pop` on empty | `FALSE` | `M2Stack.mod`: `NIL` guard, reports `ErrUnderflow` |
| 17 | `M2Queue.Create(0)` then `Size` | `0` | `M2Queue.mod`: capacity `0` becomes `16` |
| 18 | `M2Queue` fresh `IsEmpty` | `TRUE` | `M2Queue.mod`: `len=0` |
| 19 | `M2Queue.Dequeue` on empty | `FALSE` | `M2Queue.mod`: `len=0` guard, reports `ErrUnderflow` |
| 20 | `M2List` fresh `Length` | `0` | `M2List.mod`: `Create` returns `NIL` |
| 21 | `M2List.RemoveFirst` on empty | `FALSE` | `M2List.mod`: `NIL` guard, reports `ErrUnderflow` |
| 22 | `Index("abc","")` | `0` | `M2Strings.mod`: empty-pattern guard |
| 23 | `RIndex("abc","")` | `3` | `M2Strings.mod`: empty-pattern guard returns length |
| 24 | `IsEmpty("")` | `TRUE` | `M2Strings.mod`: `Length=0` |
| 25 | `StartsWith("abc","")` | `TRUE` | `M2Strings.mod`: loop over 0 chars |
| 26 | `EndsWith("abc","")` | `TRUE` | `M2Strings.mod`: loop over 0 chars |
| 27 | `IsValidDate(year=0,1,1)` | `FALSE` | `M2Time.mod`: `year>0` required |
| 28 | `DayOfYear` on invalid date | `0` | `M2Time.mod`: invalid guard |
| 29 | `DaysInMonth(2024,13)` | `0` | `M2Time.mod`: `CASE ELSE` |
| 30 | `Compute("")` (CRC-32) | `0` | `M2CRC32.mod`: zero bytes, `FFFFFFFF XOR FFFFFFFF` |
| 31 | `FNV1a32("")` | `2166136261` | `M2Hash.mod`: offset basis, no bytes |
| 32 | `DJB2("")` | `5381` | `M2Hash.mod`: seed, no bytes |
| 33 | `Mix32(0)` | `0` | `M2Hash.mod`: all-xor chain on `0` |

## Edge cases covered by the demos (not in the table above)

- `M2Queue`: enqueue past capacity returns `FALSE` (`queue_demo.mod`).
- `M2Binary`: `WriteBE32` / `ReadBE32` at offset 6 in an 8-byte buffer return `FALSE`
  (`binary_stream_demo.mod`).
- `M2NetFrame`: `Decode` with a wrong `frameLen` returns `FALSE` (`formats_demo.mod`).
- `M2INI`: `ParseCardinal("12x")` returns `FALSE`; `FindValue` for a missing key returns
  `FALSE` (`formats_demo.mod`).
- `M2SHA256`: `DigestHex` always returns `FALSE` and empties `out` — fails closed
  (`security_demo.mod`).
- `M2Random`: `NextRange(5,5)` returns `5`; `NextRange(10,20)` stays in range
  (`bits_demo.mod`).
