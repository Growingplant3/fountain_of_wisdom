alphabet_array = ("a".."z").to_a
26.times do |index|
  name = alphabet_array.pop
  priority = Random.rand(0..2)
  situation = Random.rand(0..2)
  deadline = DateTime.now + Random.rand(1..30).day
  Task.create(name: name, detail: index, priority: priority, situation: situation, deadline: deadline)
end
