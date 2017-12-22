json.questions do |question|

  json.array! @questions do |question|
    json.id question.id
    json.message question.message
    json.email question.email
    json.name question.name
  end

end
