alphabet_array = ("A".."z").to_a
58.times do |index|
  name = "task " + alphabet_array.pop
  priority = Random.rand(0..2)
  situation = Random.rand(0..2)
  deadline = DateTime.now + Random.rand(30..50).day
  Task.create(name: name, detail: index, priority: priority, situation: situation, deadline: deadline)
end
