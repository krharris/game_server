# rake bootstrap:all

namespace :bootstrap do

  desc "Add test data"
  task :test_data => :environment do

    puts("Adding test users...")
 
    user1 = User.create( :name => 'Mr. Test1', :email => 'test1@test.com', :password => "password1", :password_confirmation => "password1" )
    user2 = User.create( :name => 'Mr. Test2', :email => 'test2@test.com', :password => "password2", :password_confirmation => "password2" )

    puts("Adding test games...")

    game1 = Game.create(:user_id_1 => user1.id, :user_id_2 => user2.id, :num_moves => 2, :num_chats => 3)
    game2 = Game.create(:user_id_1 => user2.id, :user_id_2 => user1.id, :num_moves => 0, :num_chats => 0)

    puts("Adding test moves...")

    Move.create(:user_id => user1.id, :game_id => game1.id, :data => 'Move 1 data as json')
    Move.create(:user_id => user2.id, :game_id => game1.id, :data => 'Move 2 data as json')

    puts("Adding test chats...")

    Chat.create(:user_id => user1.id, :game_id => game1.id, :message => 'Hey!')
    Chat.create(:user_id => user2.id, :game_id => game1.id, :message => 'Whatz up!')
    Chat.create(:user_id => user1.id, :game_id => game1.id, :message => 'Not much...')
  
  end

  #desc "Add test games"
  #task :test_games => :environment do
  #    Game.create(:user_id_1 => user1.id, :user_id_2 => user2.id, :num_moves => 2, :num_chats => 3)
  #    Game.create(:user_id_1 => user2.id, :user_id_2 => user1.id, :num_moves => 0, :num_chats => 0)
  #end

  desc "Run bootstrapping task for test data"
  task :all => [:test_data]
  #task :all => [:test_data, :test_games]

end
