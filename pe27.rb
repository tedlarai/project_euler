require "benchmark"

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

def val(n, a, b)
  n**2 + a*n + b
end

bm = Benchmark.measure {

primes = primes_until(1000000)
iprimes = []
primes.each {|prime| iprimes[prime] = true}

b_candidates = primes_until(1000)
a_candidates = Array(0..1000).select{|x| x.odd?}
max_n = 0
a_max = 0
b_max = 0

b_candidates.each do |b|
  a_candidates.each do |a|
    [-1, 1].each do |sa|
      [-1, 1].each do |sb|
        n = 0
        while iprimes[val(n, sa*a, sb*b)]
          n += 1
        end
        n -= 1
        if n > max_n
          max_n = n
          a_max = sa*a
          b_max = sb*b
        end
      end
    end
  end
end

p max_n, a_max, b_max, a_max * b_max
}

puts bm
