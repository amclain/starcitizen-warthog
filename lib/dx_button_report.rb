# Scan the TARGET source code file and report used/unused/duplicated DirectX buttons.

all_dx_buttons = (1..32).map { |i| i }

source_code = File.open('../star_citizen_virtual.tmc', 'r').read
used_dx_buttons = source_code.scan(/define\s+\w+\s+DX(\d+)/).flatten.map(&:to_i).sort
unused_dx_buttons = all_dx_buttons - used_dx_buttons

# Find button numbers used more than once.
used_count = Hash.new { |h,k| h[k] = 0 }
used_dx_buttons.each { |i| used_count[i] += 1 }
duplicated_dx_buttons = used_count.select { |k,v| v > 1 }.keys

# Print report.
puts str = <<EOS

Used DirectX buttons:
#{used_dx_buttons.uniq.join ', '}

Duplicated DirectX buttons:
#{duplicated_dx_buttons.join ', '}

Unused DirectX buttons:
#{unused_dx_buttons.join ', '}
EOS
