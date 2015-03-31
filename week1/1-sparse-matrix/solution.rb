def tarjan(matrix)
  tarjan_array = []
  matrix.each do |row|
    squeezed_row = array_squeeze_nils row
    results_array = tarjan_range_and_row(tarjan_array, squeezed_row)
    tarjan_array[results_array[0]] = results_array[1]
  end
  tarjan_array.map do |element|
    element[1].nil? ? nil : element
  end
end

def array_squeeze_nils(array)
  return [] if array.all?(&:nil?)
  squeezed_array = array.each_with_index.select.map(&:reverse)
  squeezed_array.delete_at(squeezed_array.size - 1) while squeezed_array.last[1].nil?
  squeezed_array.delete_at(0) while squeezed_array.first[1].nil?
  squeezed_array
end

def tarjan_range_and_row(template, stamp)
  bool_template = boolify_values(template)
  bool_stamp = boolify_values(stamp)
  start = first_nil_element_index(bool_template)
  start.upto(bool_template.size + bool_stamp.size + start) do |template_index|
    stamp_iterator = 0
    (bool_stamp.size + template_index).times do |stamp_index|
      next if bool_stamp[stamp_iterator] if bool_template[stamp_index]
      stamp_iterator += 1
      range = template_index..(template_index + bool_stamp.size - 1)
      if stamp_index == bool_stamp.size + template_index - 1
        return range, add_up(template[range], stamp)
      end
    end
  end
end

def add_up(template, stamp)
  template.each_with_index do |element, index|
    stamp[index] = element if element[1]
  end
  stamp
end

def boolify_values(array)
  array.map { |el| !!el[1] }
end

def first_nil_element_index(array)
  if array.all?
    array.size
  else
    array.find_index { |element| element == false }
  end
end
