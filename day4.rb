# However, they do remember a few key facts about the password:
#
# It is a six-digit number.
# The value is within the range given in your puzzle input.
# Two adjacent digits are the same (like 22 in 122345).
# Going from left to right, the digits never decrease; they only ever increase or stay the same (like 111123 or 135679).

# 347312-805915

i = 0
(347312..805915).each do |n|
  digits = n.to_s.split('').map(&:to_i)

  next unless digits.each_cons(2).all? { |x, y| x <= y }
  next unless digits.each_cons(2).any? { |x, y| x == y }

  i += 1
end
p i

# An Elf just remembered one more important detail: the two adjacent matching digits are not part of a larger group of matching digits.
#
# Given this additional criterion, but still ignoring the range rule, the following are now true:
#
# 112233 meets these criteria because the digits never decrease and all repeated digits are exactly two digits long.
# 123444 no longer meets the criteria (the repeated 44 is part of a larger group of 444).
# 111122 meets the criteria (even though 1 is repeated more than twice, it still contains a double 22).

counter = 0

(347312..805915).each do |n|
  digits = n.to_s.split('').map(&:to_i)
  next unless digits.each_cons(2).all? { |x, y| x <= y }

  hash = Hash.new(0)
  digits.each do |number|
    hash[number] += 1
  end
  targets = []
  next unless hash.each.any? { |k, v| targets << k if v == 2 }
  next unless digits.each_cons(2).any? { |x, y| x == y && targets.include?(x) }

  counter += 1
end

p counter
