(herald "Pake 0 "
    (comment "PAKE-0 Implemetation by Carson Kegley"
))

(defprotocol PAKE basic 
    (defrole init 
    (vars (nonce_a nonce_b data) (password text) (name_a name_b name))
    (trace 
        (send nonce_a)
        (recv nonce_b)
        (send (hash password name_a name_b nonce_a nonce_b))
        (recv (hash (hash password name_a name_b nonce_a nonce_b) password name_a name_b nonce_a nonce_b))  
))

    (defrole resp 
    (vars (nonce_a nonce_b data) (password text) (name_a name_b name))
    (trace 
        (recv nonce_a)
        (send nonce_b)
        (recv (hash password name_a name_b nonce_a nonce_b))
        (send (hash (hash password name_a name_b nonce_a nonce_b) password name_a name_b nonce_a nonce_b))

))
)

;; Init Skeleton
(defskeleton PAKE 
    (vars (nonce_a nonce_b data) (password text) (name_a name_b name))
    (defstrandmax init (name_a name_a) (name_b name_b) (password password) (nonce_a nonce_a))
    (uniq-orig nonce_a)
    (pen-non-orig password)
)

;;Resp Skeleton
(defskeleton PAKE
    (vars (nonce_a nonce_b data) (password text) (name_a name_b name))
    (defstrandmax resp (name_a name_a) (name_b name_b) (password password) (nonce_b nonce_b))
    (uniq-orig nonce_b)
    (pen-non-orig password) 
) 

    

