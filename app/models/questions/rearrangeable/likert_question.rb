class LikertQuestion < RearrangeableQuestion
    attribute :questions, :json_list
end
LikertQuestion.is_abstract = false
