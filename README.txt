 -- How to Install Postgresql for Ruby --

brew install postgres
brew info postgres

initdb /usr/local/var/postgres

# Install lunchy to assist with starting and stopping postgresql.
sudo gem install lunchy
mkdir -p ~/Library/LaunchAgents
cp /usr/local/Cellar/postgresql/9.1.2/org.postgresql.postgres.plist ~/Library/LaunchAgents/
lunchy start postgres
lunchy stop postgres
lunchy start postgres

# Create two users for testing.
createuser myuser          # Super user = 'y'
createuser game_server     # Input 'n' for all questions

# Create two databases for our ruby app.
createdb -Ogame_server -Eutf8 emptyapp_development
createdb -Ogame_server -Eutf8 emptyapp_test

# Test new database by connecting to it.
psql -U game_server emptyapp_development

# Install the gem required by ruby to talk to a postgreslq database.
sudo env ARCHFLAGS="-arch x86_64" gem install pg