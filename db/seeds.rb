catty_subs = [
  {title: "Cats!", description: "Cats are really great and everyone loves cats."},
  {title: "Not cats.", description: "Not as great as cats."}
]

less_catty_subs = [
  {title: "Hockey", description: "Sometimes they punch eachother in the face."},
  {title: "Jokes", description: "No one is as funny as they think they are."},
  {title: "Internet", description: "So cool. Full of cats."}
]

User.find_by_username("kara").moderated_subs.create(catty_subs)
User.find_by_username("saito").moderated_subs.create(less_catty_subs)