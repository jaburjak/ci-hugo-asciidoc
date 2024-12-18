default: server client

.PHONY: server
server:
	cd server/ && bundle install && bundle exec rake install

.PHONY: client
client:
	cd client/ && cargo build --locked --release
	cp client/target/release/asciidoctor-client /usr/local/bin/
