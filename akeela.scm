(herald "Akeela Protocol"
    (comment "AP")
)

;; Role definition

(defprotocol akeela basic 
    ;;Init Def
    (defrole init
    (vars (m c data) (a b name))
    (trace 
        (send (enc m (cat (pubk b)) (enc m (privk a))))
        (recv (enc c (cat (pubk a)) (enc c (privk b))))
    ))
    ;; Resp def
    (defrole resp
    (vars (m c data) (a b name))
    (trace
        (recv (enc m (cat (pubk b)) (enc m (privk a))))
        (send (enc c (cat (pubk a)) (enc c (privk b))))
    ))
    
)


;; Init Skel
(defskeleton akeela
    (vars (a b name) (m data))
    (defstrand init 2 (a a) (b b) (m m))
    (non-orig (privk a) (privk b))
    (uniq-orig m)
)

;; Resp Skel
(defskeleton akeela
    (vars (a b name) (c data))
    (defstrand resp 2 (a a) (b b) (c c))
    (non-orig (privk a) (privk b))
    (uniq-orig c)
)
