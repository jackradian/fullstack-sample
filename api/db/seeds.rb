user1 = User.create(username: "user1", password: "password")
user2 = User.create(username: "user2", password: "password")
user3 = User.create(username: "user3", password: "password")
user4 = User.create(username: "user4", password: "password")
user5 = User.create(username: "user5", password: "password")

user1_movie1 = Movie.create(url: "https://www.youtube.com/watch?v=1", user: user1)
user1_movie2 = Movie.create(url: "https://www.youtube.com/watch?v=2", user: user1)

user2_movie1 = Movie.create(url: "https://www.youtube.com/watch?v=3", user: user2)
user2_movie2 = Movie.create(url: "https://www.youtube.com/watch?v=4", user: user2)

user3_movie1 = Movie.create(url: "https://www.youtube.com/watch?v=5", user: user3)

vote_types = Vote.vote_types.keys

[user1, user2, user3, user4, user5].each do |user|
  [user1_movie1, user1_movie2, user2_movie1, user2_movie2, user3_movie1].each do |movie|
    user.votes.create(movie: movie, vote_type: vote_types.sample)
  end
end
