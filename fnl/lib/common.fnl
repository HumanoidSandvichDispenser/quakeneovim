(fn car [list]
  "Return the car of the list. If list is nil, return nil."
  (when (~= list nil)
    (. list 1)))

(fn cdr [list]
  (fcollect [i 2 (# list) 1]
    (. list i)))

(fn reverse [list]
  (fcollect [i (# list) 1 -1]
    (. list i)))

{:car car
 :cdr cdr
 :reverse reverse}
