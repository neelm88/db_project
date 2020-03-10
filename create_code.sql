CREATE TABLE USER(
    email VARCHAR(80) NOT NULL,
    name VARCHAR(60),
    address VARCHAR(60) NOT NULL,
    phone_number INT NOT NULL,
    PRIMARY KEY(email)
);

CREATE TABLE SELLER(
    email VARCHAR(80),
    bio VARCHAR(255),
    photo VARCHAR(120) DEFAULT "dummy.img",
    FOREIGN KEY(email) REFERENCES BUYER(Email)
);

CREATE TABLE BUYER(
    email VARCHAR(80),
    karma_points INT NOT NULL DEFAULT 0,
    FOREIGN KEY(email) REFERENCES BUYER(Email)
);

CREATE TABLE WISH(
    wish_number INT NOT NULL,
    email VARCHAR(80) NOT NULL,
    product_id INT NOT NULL,
    FOREIGN KEY(email) REFERENCES BUYER(Email)
);

CREATE TABLE STORE(
    name VARCHAR(255) NOT NULL,
    seller_email VARCHAR(80) NOT NULL,
    description VARCHAR(255),
    banner VARCHAR(255) NOT NULL DEFAULT "dummybanner.img",
    PRIMARY KEY(NAME),
    FOREIGN KEY(seller_email) REFERENCES INVENTORY(store_name)
);

CREATE TABLE URL(
    link VARCHAR(255) NOT NULL,
    name VARCHAR(255) NOT NULL,
    FOREIGN KEY(name) references STOER(name)
);