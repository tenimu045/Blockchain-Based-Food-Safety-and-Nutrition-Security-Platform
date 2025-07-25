;; Food Bank Distribution Optimization Contract
;; Efficiently distributes donated food to food-insecure populations

;; Constants
(define-constant CONTRACT-OWNER tx-sender)
(define-constant ERR-UNAUTHORIZED (err u300))
(define-constant ERR-INVALID-INPUT (err u301))
(define-constant ERR-NOT-FOUND (err u302))
(define-constant ERR-INSUFFICIENT-QUANTITY (err u303))
(define-constant ERR-EXPIRED (err u304))

;; Data Variables
(define-data-var next-donation-id uint u1)
(define-data-var next-request-id uint u1)

;; Data Maps
(define-map food-donations uint {
  donor: principal,
  food-type: (string-ascii 100),
  quantity: uint,
  expiration-date: uint,
  status: (string-ascii 20),
  donation-timestamp: uint
})

(define-map food-requests uint {
  requester: principal,
  food-type: (string-ascii 100),
  quantity-needed: uint,
  urgency-level: uint,
  status: (string-ascii 20),
  request-timestamp: uint
})

;; Read-only functions
(define-read-only (get-donation (donation-id uint))
  (map-get? food-donations donation-id)
)

(define-read-only (get-request (request-id uint))
  (map-get? food-requests request-id)
)

;; Public functions
(define-public (donate-food
  (food-type (string-ascii 100))
  (quantity uint)
  (expiration-date uint))
  (let ((donation-id (var-get next-donation-id)))
    (asserts! (> (len food-type) u0) ERR-INVALID-INPUT)
    (asserts! (> quantity u0) ERR-INVALID-INPUT)
    (asserts! (> expiration-date block-height) ERR-EXPIRED)

    (map-set food-donations donation-id {
      donor: tx-sender,
      food-type: food-type,
      quantity: quantity,
      expiration-date: expiration-date,
      status: "available",
      donation-timestamp: block-height
    })

    (var-set next-donation-id (+ donation-id u1))
    (ok donation-id)
  )
)

(define-public (request-food
  (food-type (string-ascii 100))
  (quantity-needed uint)
  (urgency-level uint))
  (let ((request-id (var-get next-request-id)))
    (asserts! (> (len food-type) u0) ERR-INVALID-INPUT)
    (asserts! (> quantity-needed u0) ERR-INVALID-INPUT)
    (asserts! (and (>= urgency-level u1) (<= urgency-level u5)) ERR-INVALID-INPUT)

    (map-set food-requests request-id {
      requester: tx-sender,
      food-type: food-type,
      quantity-needed: quantity-needed,
      urgency-level: urgency-level,
      status: "pending",
      request-timestamp: block-height
    })

    (var-set next-request-id (+ request-id u1))
    (ok request-id)
  )
)

(define-public (allocate-donation (donation-id uint) (request-id uint))
  (let ((donation (unwrap! (map-get? food-donations donation-id) ERR-NOT-FOUND))
        (request (unwrap! (map-get? food-requests request-id) ERR-NOT-FOUND)))

    (asserts! (is-eq (get status donation) "available") ERR-INVALID-INPUT)
    (asserts! (is-eq (get status request) "pending") ERR-INVALID-INPUT)
    (asserts! (is-eq (get food-type donation) (get food-type request)) ERR-INVALID-INPUT)
    (asserts! (>= (get quantity donation) (get quantity-needed request)) ERR-INSUFFICIENT-QUANTITY)
    (asserts! (> (get expiration-date donation) block-height) ERR-EXPIRED)

    (map-set food-donations donation-id (merge donation {
      status: "allocated"
    }))

    (map-set food-requests request-id (merge request {
      status: "fulfilled"
    }))

    (ok true)
  )
)
