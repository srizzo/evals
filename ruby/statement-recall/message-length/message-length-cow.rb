require 'faker'


def format_context(names, cows)
  names.zip(cows).map { "#{_1} has #{_2} cows." }.join(' ') + "\n"
end

def format_question(name)
  "How many cows does #{name} own? Provide only the numerical value, without any text."
end


def generate(seed)
  srand(seed)

  length = 355

  names = (1..length).to_a.map { [Faker::Name.first_name, Faker::Name.middle_name, Faker::Name.last_name].join(' ') }.shuffle
  fail "duplicate names" if names.uniq.size != length

  cows = (2000..(2000 + length)).to_a.shuffle

  [
    # 200,
    # 340,
    335
  ].flat_map do |length|
    [1,
     length * 0.1,
     length * 0.2,
     length * 0.25,
     length * 0.3,
     length * 0.4,
     length * 0.5,
     length * 0.6,
     length * 0.75,
     length * 0.7,
     length * 0.8,
     length * 0.9,
     length]
      .map(&:ceil)
      .map(&:to_i)
      .map { _1 - 1 }
      .uniq
      .map do |position|
      # puts "length: #{length} position: #{position}"
      context = format_context(names[0...length], cows[0...length])
      question = format_question(names[position])
      message = "#{context}\n#{question}"
      formatted_message = message.gsub("\n", '\n')
      answer = cows[position]

      # puts message
      #
      system_message = %[{"role": "system", "content": "Answer accurately."}]
      %[{"input": [#{system_message}, {"role": "user", "content": "#{formatted_message}"}], "ideal": "#{answer}"}]
    end
  end
end

samples = []
samples += generate(123)
samples += generate(234)
samples += generate(345)
samples += generate(456)


# puts samples.join("\n")
File.write("../evals/registry/data/statement_recall/samples.jsonl", samples.join("\n"))

