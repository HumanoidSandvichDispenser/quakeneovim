(local {: reverse
        : car
        : cdr} (require :lib.common))

(fn dot [& rest]
  (accumulate [acc (car rest)
               _ key (ipairs (cdr rest))]
    '(. ,acc ,key)))

;; (dot! abc def ghi)
;; -> ghi
;; -> (. def ghi)
;; -> (. (. abc def) ghi)

;; -> abc
;; -> (. abc def)
;; -> (. (. abc def) ghi)

{:dot! dot}
