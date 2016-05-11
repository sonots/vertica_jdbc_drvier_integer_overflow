require 'vertica'

connection = Vertica.connect({
  host: 'xxx.xxx.xxx.xxx',
  port: 5433,
  database: 'vdb',
  user: 'xxxxxx',
  password: 'xxxxxx',
})

connection.query("drop table if exists sandbox.integer_overflow")
connection.query("create table sandbox.integer_overflow (id int)")

num = 2 ** 32 + 10
started = Time.now
connection.copy("COPY sandbox.integer_overflow FROM STDIN") do |stdin|
  num.times do |i|
    puts format("%2.4f%% (elapsed: %.2fsec)", (100 * i / num.to_f), (Time.now - started).to_f) if i % 100000 == 0
    stdin << i.to_s << "\n"
  end
end

puts connection.query("select count(*) from sandbox.integer_overflow").rows.to_a
