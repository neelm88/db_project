CREATE TABLE [USER](
    email VARCHAR(80) NOT NULL,
    name VARCHAR(60),
    address VARCHAR(60) NOT NULL,
    phone_number INT NOT NULL,
    CONSTRAINT USERPRIMKEY
        PRIMARY KEY(email)
);

CREATE TABLE SELLER(
    email VARCHAR(80),
    bio VARCHAR(255),
    photo VARCHAR(120) DEFAULT "dummy.img",
    CONSTRAINT SELLFK
        FOREIGN KEY(email) REFERENCES BUYER(Email)
            ON UPDATE CASCADE
);

CREATE TABLE BUYER(
    email VARCHAR(80),
    karma_points INT NOT NULL DEFAULT 0,
    CONSTRAINT BUYFK
        FOREIGN KEY(email) REFERENCES BUYER(Email)
            ON UPDATE CASCADE
);

CREATE TABLE WISH(
    wish_number INT NOT NULL,
    email VARCHAR(80) NOT NULL,
    product_id INT NOT NULL,
    CONSTRAINT WISHFK
        FOREIGN KEY(email) REFERENCES BUYER(Email)
);

CREATE TABLE STORE(
    name VARCHAR(255) NOT NULL,
    seller_email VARCHAR(80) NOT NULL,
    description VARCHAR(255),
    banner VARCHAR(255) NOT NULL DEFAULT "dummybanner.img",
    CONSTRAINT STOREPK
        PRIMARY KEY(NAME),
    CONSTRAINT STOREFK
        FOREIGN KEY(seller_email) REFERENCES INVENTORY(store_name)
);

CREATE TABLE URL(
    link VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    CONSTRAINT URLFK
        FOREIGN KEY(name) references STORE(name)
);

CREATE TABLE INVENTORY
(	product_id INT NOT NULL,
	quantity INT NOT NULL,
	file_type VARCHAR(16) NOT NULL,
	file_size VARCHAR(16) NOT NULL,
	description VARCHAR(512) NOT NULL,
	buying_price FLOAT(10,2) NOT NULL,
	title VARCHAR(64) NOT NULL,
	store_name VARCHAR(64),
	download_URL VARCHAR(2048) NOT NULL,
	is_for_sale BOOLEAN NOT NULL DEFAULT true,
	CONSTRAINT INVPK
		PRIMARY KEY(product_id),
	CONSTRAINT INVSTOREFK
		FOREIGN KEY(store_name) REFERENCES STORE(name));
		
CREATE TABLE RENTAL
(	product_id INT NOT NULL,
	duration VARCHAR(16) NOT NULL,
	start_date DATE NOT NULL,
	price FLOAT(10,2) NOT NULL,
	CONSTRAINT RENTPK
		PRIMARY KEY(product_id),
	CONSTRAINT RENTINVFK
		FOREIGN KEY(product_id) REFERENCES INVENTORY(product_id));
CREATE TABLE SUBSCRIPTION
(	product_id INT NOT NULL,
	subscription_type VARCHAR(16) NOT NULL,
	start_date DATE NOT NULL,
	price FLOAT(10,2) NOT NULL,
	CONSTRAINT SUBPK
		PRIMARY KEY(product_id),
	CONSTRAINT SUBINVFK
		FOREIGN KEY(product_id) REFERENCES INVENTORY(product_id));
CREATE TABLE IMAGE
(	image_id INT NOT NULL,
	product_id INT NOT NULL,
	image_file VARCHAR(2048) NOT NULL,
	CONSTRAINT IMGPK
		PRIMARY KEY(image_id,product_id),
	CONSTRAINT IMGINVFK
		FOREIGN KEY(product_id) REFERENCES INVENTORY(product_id));
CREATE TABLE IP_TYPE
(	word VARCHAR(32) NOT NULL,
	CONSTRAINT IPTYPEPK
		PRIMARY KEY(word));
CREATE TABLE PRODUCT_KEYWORD
(	product_id INT NOT NULL,
	word VARCHAR(32) NOT NULL,
	CONSTRAINT PROKEYPK
		PRIMARY KEY(product_id, word),
	CONSTRAINT PROKEYIPTYPEFK
		FOREIGN KEY(word) REFERENCES IP_TYPE(word),
	CONSTRAINT PROKEYINVFK
		FOREIGN KEY(product_id) REFERENCES INVENTORY(product_id));
CREATE TABLE FEEDBACK
(	comment_id INT NOT NULL,
	rating INT NOT NULL,
	comment VARCHAR(512) NOT NULL,
	comment_time DATETIME NOT NULL,
	product_id INT NOT NULL,
	email VARCHAR(128) NOT NULL,
	CONSTRAINT FDBKPK
		PRIMARY KEY(comment_id),
	CONSTRAINT FDBKINVFK
		FOREIGN KEY(product_id) REFERENCES INVENTORY(product_id),
	CONSTRAINT FDBKBYRFK
		FOREIGN KEY(email) REFERENCES BUYER(email));
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