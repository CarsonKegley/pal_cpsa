(herald "Needham-Schroeder Demo June 2025"
	(comment "Example of analyzing NS.")
)

(defprotocol ns basic ;; Use basic cryptoalgebra. Other option is Diffie-Hellman (DH)
	     (defrole initiator
		(vars (nonce_a nonce_b data) (name_a name_b name))
		(trace
		  	(send (enc nonce_a name_a (pubk name_b)))
			(recv (enc nonce_a nonce_b name_b (pubk name_a)))
			(send (enc nonce_b (pubk name_b)))
		))
	     (defrole responder
		(vars (nonce_a nonce_b data) (name_a name_b name))
		(trace
		  	(recv (enc nonce_a name_a (pubk name_b)))
			(send (enc nonce_a nonce_b name_b (pubk name_a)))
			(recv (enc nonce_b (pubk name_b)))
		))
)

;; Initiator "perspective".
(defskeleton ns
	(vars (name_a name_b name) (nonce_a data))
	(defstrandmax initiator (name_a name_a) (name_b name_b) (nonce_a nonce_a))
	(non-orig (privk name_a) (privk name_b))
	(uniq-orig nonce_a)
)

;; Responder "perspective".
(defskeleton ns
	(vars (name_a name_b name) (nonce_b data))
	(defstrandmax responder (name_a name_a) (name_b name_b) (nonce_b nonce_b))
	(non-orig (privk name_a) (privk name_b))
	(uniq-orig nonce_b)
)
