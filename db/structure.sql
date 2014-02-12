CREATE TABLE "bets" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "lot_id" integer, "user_id" integer, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "categories" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "title" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "images" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "product_id" integer, "image" varchar(255), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "lots" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "title" varchar(255), "end_time" datetime, "created_at" datetime, "updated_at" datetime, "price" float DEFAULT 0);
CREATE TABLE "products" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "title" varchar(255), "description" varchar(255), "price" decimal(8,2), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE TABLE "users" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "first_name" varchar(255), "last_name" varchar(255), "created_at" datetime, "updated_at" datetime, "email" varchar(255) DEFAULT '' NOT NULL, "encrypted_password" varchar(255) DEFAULT '' NOT NULL, "reset_password_token" varchar(255), "reset_password_sent_at" datetime, "remember_created_at" datetime, "sign_in_count" integer DEFAULT 0 NOT NULL, "current_sign_in_at" datetime, "last_sign_in_at" datetime, "current_sign_in_ip" varchar(255), "last_sign_in_ip" varchar(255), "admin" boolean DEFAULT 'f');
CREATE INDEX "index_bets_on_lot_id" ON "bets" ("lot_id");
CREATE INDEX "index_bets_on_user_id" ON "bets" ("user_id");
CREATE INDEX "index_images_on_product_id" ON "images" ("product_id");
CREATE UNIQUE INDEX "index_users_on_email" ON "users" ("email");
CREATE UNIQUE INDEX "index_users_on_reset_password_token" ON "users" ("reset_password_token");
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20131208081039');

INSERT INTO schema_migrations (version) VALUES ('20131214124816');

INSERT INTO schema_migrations (version) VALUES ('20131214125621');

INSERT INTO schema_migrations (version) VALUES ('20131222092016');

INSERT INTO schema_migrations (version) VALUES ('20131225172903');

INSERT INTO schema_migrations (version) VALUES ('20140115140217');

INSERT INTO schema_migrations (version) VALUES ('20140202083215');

INSERT INTO schema_migrations (version) VALUES ('20140202083305');

INSERT INTO schema_migrations (version) VALUES ('20140212150505');
