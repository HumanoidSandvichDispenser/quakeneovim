(local {: spread! : to-kv!} (require :macros.macros))

(fn lazy-spec [name & spec]
  (if (= spec nil)
    name
    (spread! (tostring name) (to-kv! spec))))

(fn lazy-use [name & spec]
  (let [name-str (tostring name)]
    '(table.insert _G.lazy-plugins-table! ,(lazy-spec name (table.unpack spec)))))

(fn lazy-begin []
  '(tset _G :lazy-plugins-table! {}))

(fn lazy-end []
  '((. (require :lazy) :setup) _G.lazy-plugins-table!))

(fn setup [plugin & args]
  '((. (require ,plugin) :setup) ,(table.unpack args)))

(fn require-call [module-name fn-name & args]
  '((. (require ,module-name) ,fn-name) ,(table.unpack args)))

{:lazy-spec! lazy-spec
 :lazy-use! lazy-use
 :lazy-begin! lazy-begin
 :lazy-end! lazy-end
 :setup! setup
 :require-call! require-call}
