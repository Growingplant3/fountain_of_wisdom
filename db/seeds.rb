first_admin_user = User.create(name: "master", email: "master@example.com", password: "password", password_confirmation: "password", admin: "admin")
second_admin_user = User.create(name: "admin", email: "admin@example.com", password: "password", password_confirmation: "password", admin: "admin")
first_general_user = User.create(name: "general", email: "general@example.comt", password: "password", password_confirmation: "password", admin: "not_admin")
second_general_user = User.create(name: "ordinary people", email: "ordinary_people@example.comt", password: "password", password_confirmation: "password", admin: "not_admin")

# 1508件のシードデータが少なすぎる場合にはこちらを使ってください。
# alphabet_array1 = ("A".."z").to_a
# alphabet_array2 = alphabet_array1
# alphabet_array3 = alphabet_array1
# task_name_array = []
# alphabet_array1.each do |first_letter|
#   alphabet_array2.each do |second_letter|
#     alphabet_array3.each do |third_letter|
#       task_name_array.push(first_letter + second_letter + third_letter)
#     end
#   end
# end

# 195112.times do |index|
#   name = "task " + task_name_array.pop
#   priority = Random.rand(0..2)
#   situation = Random.rand(0..2)
#   deadline = DateTime.now + Random.rand(30..50).day
#   Task.create(name: name, detail: index, priority: priority, situation: situation, deadline: deadline)
# end

# 195112件のシードデータが多すぎる場合にはこちらを使ってください。
alphabet_array1 = ("A".."z").to_a
alphabet_array2 = ("a".."z").to_a
task_name_array = []
alphabet_array1.each do |first_letter|
  alphabet_array2.each do |second_letter|
    task_name_array.push(first_letter + second_letter)
  end
end

1508.times do |index|
  name = "task " + task_name_array.pop
  priority = Random.rand(0..2)
  situation = Random.rand(0..2)
  deadline = DateTime.now + Random.rand(30..50).day
  user_id = Random.rand(2..4)
  Task.create(name: name, detail: index, priority: priority, situation: situation, deadline: deadline, user_id: user_id)
end

label_names = ["遊び", "買い物", "旅行", "家族", "友達", "学校", "会社", "資格", "試験", "その他"]

label_names.each do |label_name|
  name = label_name
  user_id = Random.rand(3..4)
  Label.create(name: name, user_id: user_id)
end
