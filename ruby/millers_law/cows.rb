require 'faker'

srand(123)

length = 350

names = (1..length).to_a.map { [Faker::Name.first_name, Faker::Name.middle_name, Faker::Name.last_name].join(' ') }.shuffle
fail "duplicate names" if names.uniq.size != length

cows = (2000..(2000 + length)).to_a.shuffle
answers = {}

def format_context(names, cows, updates)
  "Use the following list of cow ownership to answer the questions:\n" +
    names.zip(cows).map { "#{_1} has #{_2} cows." }.join(' ') + "\n" +
    "\n" +
    "---\n"
end

def format_question(name)
  "How many cows does #{name} own? Provide only the numerical value, without any text."
end

samples = []
[
  1
].each do |participants|
  [2]
    .map(&:ceil)
    .map(&:to_i)
    .map { _1 - 1 }
    .uniq
    .each do |updates|

    context = format_context(names[0...participants], cows[0...participants], updates)
    # question = format_question(names[updates])
    # message = "#{context}\n#{question}"
    # formatted_message = message.gsub("\n", '\n')
    # answer = cows[updates]

    puts message

    system_message = %[{"role": "system", "content": "Answer accurately."}]
    # puts message
    samples << %[{"input": [{"role": "user", "content": "#{formatted_message}"}], "ideal": "#{answer}"}]
  end
end

# puts samples.join("\n")
# File.write("../evals/registry/data/millers_law/samples.jsonl", samples.join("\n"))

