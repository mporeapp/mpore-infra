CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY, -- ID with increasing numerical sequence (1, 2, 3...)
    username VARCHAR(32) NOT NULL,
    email VARCHAR(128) NOT NULL,
    hashed_password VARCHAR(64) NOT NULL,
    keyring VARCHAR(64) DEFAULT NULL -- Account recovery word sequence. These are going to be stored hashed in sha256. 
);

CREATE TABLE IF NOT EXISTS posts(
    id VARCHAR(36) DEFAULT gen_random_uuid(), -- UUID with random characters. (db7018ff-5403-4b29-9e29-ec578f9a5ed3)
    created_at TIMESTAMP DEFAULT now(),
    author INT NOT NULL,
	title VARCHAR(64) DEFAULT NULL,
	content VARCHAR(1024) NOT NULL,
    posted_in INT DEFAULT NULL,
    replying_to VARCHAR(36) DEFAULT NULL
);

CREATE TABLE IF NOT EXISTS following (
    following_id INT NOT NULL,
    follower_id INT NOT NULL
);

CREATE TABLE IF NOT EXISTS likes (
    user_id INT NOT NULL,
    post_id INT NOT NULL
)