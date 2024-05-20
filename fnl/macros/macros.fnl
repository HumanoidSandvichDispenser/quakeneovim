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

{:spread! spread
 :to-kv! to-kv}
