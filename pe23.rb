def primes_until(n)
  s = Array.new(n - 1, true)
  s.each_index do |index|
    prime = index + 2
    to_mark = prime ** 2
    break if to_mark > n
    until to_mark > n
      s[to_mark - 2] = false
      to_mark += prime
    end
  end
  s.map.with_index {|x, i| x ? i + 2 : x}.select {|x| x}
end

def prime_divisors_of(n, primes)
  root = Math.sqrt(n)
  divisors = []
  primes.each do |prime|
    if prime > root
      divisors << n if n > 1
      return divisors
    end
    while n % prime == 0
      divisors << prime
      n /= prime
    end
  end
end

def proper_divisors(n, primes)
  prime_divisors = prime_divisors_of(n, primes)
  combinations = []
  (1..prime_divisors.length - 1).each do |num_of_factors|
    combinations += prime_divisors.combination(num_of_factors).to_a
  end
  combinations.map! do |combination|
    combination.inject {|acc, x| acc * x}
  end
  combinations << 1
  combinations.uniq.sort
end

primes = primes_until(28124)
ab_numbers = []

(2..28123).each do |number|
  sum_of_divisors = proper_divisors(number, primes).inject(&:+)
  ab_numbers << number if sum_of_divisors > number
end

nums = (0..28123).to_a

while ab_num = ab_numbers[-1]
  p "computing #{ab_num}"
  ab_numbers.each do |ot_num|
    ab_sum = ab_num + ot_num
    break if ab_sum > 28123
    nums[ab_sum] = 0
  end
  ab_numbers.pop
end

p nums, nums.inject(&:+)
