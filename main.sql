CREATE TABLE IF NOT EXISTS users (
    id UUID DEFAULT gen_random_uuid(), -- UUID with random characters. (db7018ff-5403-4b29-9e29-ec578f9a5ed3)
    username VARCHAR(32) NOT NULL,
    email VARCHAR(128) NOT NULL,
    bio VARCHAR(128) DEFAULT NULL,
    password VARCHAR(256) NOT NULL,
    keyring VARCHAR(256) DEFAULT NULL -- Account recovery word sequence. These are going to be stored hashed in sha256.
    created_at TIMESTAMP DEFAULT now()
);

CREATE TABLE IF NOT EXISTS posts(
    id UUID DEFAULT gen_random_uuid(),
    created_at TIMESTAMP DEFAULT now(),
    author UUID NOT NULL,
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
);
