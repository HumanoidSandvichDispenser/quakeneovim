(local {: reverse
        : car
        : cdr} (require :lib.common))
(local {: dot!} (require :macros.common))

(fn tset! [& opts]
  (local reversed (reverse opts))
  (local value (car reversed))
  (local key (car (cdr reversed)))
  (local dots (dot! (table.unpack (reverse (cdr (cdr reversed))))))
  '(tset ,dots ,key ,value))

{:tset! tset!}
