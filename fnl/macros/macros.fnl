(fn table-remove-new [tbl idx]
  (var copy tbl)
  (table.remove copy idx)
  copy)

(fn car [list]
  (. list 1))

(fn cdr [list]
  (table-remove-new list 1))

(fn spread [& args]
  (local full-tbl [])
  (each [_ arg (ipairs args)]
    (if (= (type arg) :table)
      (collect [k v (pairs arg) &into full-tbl]
        (values k v))
      (table.insert full-tbl arg)))
  full-tbl)

(fn to-kv [spread-kv]
  (assert (= (% (# spread-kv) 2) 0)
    "Each key must have a value.")
  (local tbl {})
  (collect [i key (ipairs spread-kv)]
    (if (= (% i 2) 1)
      (let [val (. spread-kv (+ i 1))]
        (values key val)))))

{:car car
 :cdr cdr
 :spread! spread
 :to-kv! to-kv}
