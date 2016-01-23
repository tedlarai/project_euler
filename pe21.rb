require 'pry'

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

primes = primes_until(101)
sums_of_divisors = []
a_numbers = []

(2..9999).each do |number|
  sums_of_divisors[number] = proper_divisors(number, primes).inject(&:+)
end

sums_of_divisors.each_with_index do |sum, number|
    next if number < 2
    if sum > number && sums_of_divisors[sum] == number
      # sum > number guarantees that no number is self amicable and that each
      # pair is accounted only once, when the lesser is analized
      a_numbers << [number, sum]
    end
end

p a_numbers, a_numbers.flatten.inject(&:+)
