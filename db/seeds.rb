alphabet_array1 = ("A".."z").to_a
alphabet_array2 = alphabet_array1
alphabet_array3 = alphabet_array1
task_name_array = []
alphabet_array1.each do |first_letter|
  alphabet_array2.each do |second_letter|
    alphabet_array3.each do |third_letter|
      task_name_array.push(first_letter + second_letter + third_letter)
    end
  end
end

195112.times do |index|
  name = "task " + task_name_array.pop
  priority = Random.rand(0..2)
  situation = Random.rand(0..2)
  deadline = DateTime.now + Random.rand(30..50).day
  Task.create(name: name, detail: index, priority: priority, situation: situation, deadline: deadline)
end
