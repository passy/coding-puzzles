(ns passy-mutable-bst)

(definterface INode
  (getLeft [])
  (getRight [])
  (insert [k v])
  (lookup [k]))

(deftype Node
  [key
   val
   ^:volatile-mutable ^INode left
   ^:volatile-mutable ^INode right]

  INode
  (getLeft [_] left)
  (getRight [_] right)
  (insert [this k v]
    ;; new node for the insertion, taking the new key and value,
    ;; starting without right or left nodes.
    (let [n (Node. k v nil nil)]
      (cond
       (gt? k key) (if right
                     (.insert right k v)
                     ; mutating for now
                     (set! right n))
       (lt? k key) (if left
                     (.insert left k v)
                     (set! left n)))))
  (lookup [this k]
    (if (= k key)
      ;; this is what we're looking for
      val
      ;; otherwise, recurse
      (cond
       (and (gt? k key) right) (.lookup right k)
       (and (lt? k key) left) (.lookup left k)))))


(def gt? (comp pos? compare))
(def lt? (comp neg? compare))

; Function composition <3
(gt? 2 1)

; Little helper
(defn bst [& [k v]] (Node. k v nil nil))

(def my-tree (bst :stephen :sawchuk))
(.insert my-tree :sindre :sorhus)
(.lookup my-tree :sindre)
