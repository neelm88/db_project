CREATE TABLE PURCHASE
(	confirmation_no	INT NOT NULL,
    receiver_email 	VARCHAR(128)	NOT NULL,
	gift	BOOLEAN	NOT NULL,
	buyer_email	VARCHAR(128)	NOT NULL,
	payment_id INT NOT NULL,
	purchase_date DATETIME NOT NULL,
	CONSTRAINT PURCHASEPK
		PRIMARY KEY(confirmation_no),
	CONSTRAINT PURCHASESUPERPK
		FOREIGN KEY(payment_id) REFERENCES PAYMENT(payment_id)
			ON DELETE CASCADE );


CREATE TABLE PAYMENT
( payment_id INT	NOT NULL,
  amount_spent	FLOAT(10,2)	NOT NULL,
  CONSTRAINT PAYMENTPK
		PRIMARY KEY(payment_id)
);


CREATE TABLE CRYPTO_CURRENCY
( payment_id INT NOT NULL,
  currency	VARCHAR(128) NOT NULL,
  account_number	VARCHAR(128)	NOT NULL,
  CONSTRAINT CCPK
	PRIMARY KEY(payment_id),
  CONSTRAINT CCFK
	FOREIGN KEY(payment_id) REFERENCES PAYMENT (payment_id)
			ON DELETE CASCADE
);

CREATE TABLE KARMA_POINTS
( payment_id INT NOT NULL,
  CONSTRAINT KPPK
	PRIMARY KEY(payment_id),
  CONSTRAINT KPFK
	FOREIGN KEY(payment_id) REFERENCES PAYMENT(payment_id)
			ON DELETE CASCADE
);


CREATE TABLE CARD
(	payment_id INT NOT NULL,
	security_number INT NOT NULL,
	expiration_date date	NOT NULL,
	currency VARCHAR(128) NOT NULL DEFAULT 'Dollar', 
	card_number VARCHAR(128) NOT NULL,
	CONSTRAINT CARDPK
		PRIMARY KEY(payment_id),
	CONSTRAINT CARDFK
		FOREIGN KEY(payment_id) REFERENCES PAYMENT(payment_id)
			ON DELETE CASCADE
);


CREATE TABLE PURCHASE_PAYMENT
( purchase_payment_id INT NOT NULL,
   confirmation_no INT NOT NULL,
   amount_spent FLOAT(10,2)	NOT NULL,
   CONSTRAINT PURCPAYPK
		PRIMARY KEY(purchase_payment_id, confirmation_no),
	CONSTRAINT PURCHPAYFK
		FOREIGN KEY(confirmation_no) REFERENCES PURCHASE (confirmation_no)
				ON DELETE CASCADE
);

CREATE TABLE PURCHASE_DETAILS
( purchase_payment_id INT NOT NULL,
   confirmation_no INT NOT NULL,
   quantity INT	NOT NULL,
   product_id INT NOT NULL,
   comment_id INT NOT NULL,
   CONSTRAINT PUR_DET 
		PRIMARY KEY(purchase_payment_id, confirmation_no),
	CONSTRAINT PUR_DET_FK
		FOREIGN KEY(purchase_payment_id) REFERENCES PURCHASE_PAYMENT(purchase_payment_id)
				ON DELETE CASCADE,
		FOREIGN KEY(confirmation_no) REFERENCES PURCHASE(confirmation_no)
				ON DELETE CASCADE,
		FOREIGN KEY(product_id) REFERENCES INVENTORY(product_id)
				ON DELETE SET NULL,
		FOREIGN KEY(comment_id) REFERENCES FEEDBACK(comment_id)
				ON DELETE SET NULL
);
