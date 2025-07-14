(herald "Akeela Protocol"
    (comment "AP")
)

;; Role definition

(defprotocol akeela basic 
    ;;Init Def
    (defrole init
    (vars (m c data) (a b name))
    (trace 
        (send (enc (enc m (privk a)) (pubk b)))
        (recv (enc  (enc c (privk b)) (pubk a)))
    ))

    ;; Resp def
    (defrole resp
    (vars (m c data) (a b name))
    (trace
        (recv (enc (enc m (privk a)) (pubk b) ))
        (send  (enc c (enc c (privk b)) (pubk a)))
    ))
 )   




;; Init Skel
(defskeleton akeela
    (vars (a b name) (m data))
    (defstrandmax init  (a a) (b b) (m m))
    (non-orig (privk a) (privk b))
    (uniq-orig m)
)

;; Resp Skel
(defskeleton akeela
    (vars (a b name) (c data))
    (defstrandmax resp  (a a) (b b) (c c)
    (non-orig (privk a) (privk b))
    (uniq-orig c)
)
