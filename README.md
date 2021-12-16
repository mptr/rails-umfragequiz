# Rails UmfrageQuiz

## Klassendiagramm:

![](http://www.plantuml.com/plantuml/png/ZLLDJnin4BtxLrZXKAdIIkKQGKfBeme9miU6GuLGv6I7OE6rjxQtj8Nyzzh6szqnfjkSulbuRzxCh7raBDEshGLvj-T_zEjyCR_wT5hIS2Ha8vWnzDg0fa-4KgWP5rDghEPowywjSqXMmr_JBcQKhVu1lq8EybDwfrMzgfXrjY_CmfBNuAnMfROUQLrpOxYI9LYFjz7WOgeLirFg8vs4kg471rkGeBrdDdF9eUJ9_eGMbNgK1Psyds2eN4GicyJglJEJIGbXQwU7RInDQwHFEuA30uZcstlhe1w6KAHh-kNrl5oUd2zYr_TUuL-sJgL7z_fLu_yoDuQrKWAOTBOAp4RpuEX74MKWZG-J7cpgcgPq1JgqBELSjFKQz1MJMq3qVdvJAeCt36vmC1QQxkZ0AxXZhR27-s4YES2YROhd6UtEhugu0gQrps1hWSjWqZo2NhqqmtIYRsuThG7DcU2_uoRaCCQPou3NK-u8icG0iZnnz3VtlAf0tXO9BWBDH6TwHcYwDaLv_NdvxMB-iZx4kxFJyyueJl0AD18NBLXSZhxV3eoGMCOHBietzueUqdsqMzxm8IuO2jgHY3D66fg6keywieIVTgW6dICiJew9nqeer0TimAcu6BmmcIcv5077zuflyEwtpSggf0qu6BEVjSBovfKtqcIyYEXZn-HOS6p2anSKMIuqLyCseVD_v9_o1z0MLVVT7yQ-VfGtmjHzMEvxEZifo-6DZDO-Nk7uAXfqAOqAJqZXgVrTd5zFF8j_y9YEAASspSzNy9RyuSsNvHw-BJWgPSWiF6eiFJuzNynf_hdhKLTEuaOe2RDPl6EGhFYiFSzG2kx2U7Wg9Hj6Za1MRIt-0000)

<!--
@startuml
'##### GENERALS #####

class User {
  email: string
  username: string
}
class Survey {
  name: string
  from_date: DateTime
  to_date: DateTime
}
class SubmissionSet{
  created_at: Timestamp <<generated>>
}
User "1" -down- "*" SubmissionSet
User "1" -down- "*" Survey
Survey "1" - "*" SubmissionSet 

abstract class Submission {}
SubmissionSet "1" -right- "k" Submission

'##### QUESTIONS ######

abstract class Question {
  optional: boolean
  description: string
}
Survey "1" -down- "k" Question : <<ordered>>

abstract class NumberRangeQuestion {
  from: number
  to: number
  step: number <<default=1>>
}
NumberRangeQuestion -up-|> Question

abstract class RearrangeableQuestion {
  answer_options: string[] <<serialized>>
}
RearrangeableQuestion -up-|> Question

abstract class StringQuestion {}
StringQuestion -up-|> Question

RearrangeableQuestion -right[hidden]- StringQuestion
StringQuestion -right[hidden]- NumberRangeQuestion
 
'##### QUESTION-SUBTYPES ####

'## NumberRangeQuestion ###
class SliderQuestion {}
SliderQuestion -up-|> NumberRangeQuestion
class NumberQuestion {}
NumberQuestion -up-|> NumberRangeQuestion
class NPSQuestion {
  from: number = 1
  to: number = 10
  step: number = 1
}
NPSQuestion -up-|> NumberRangeQuestion

'### StringQuestion ###
class TextQuestion {}
TextQuestion -up-|> StringQuestion
class ColorQuestion {}
ColorQuestion -up-|> StringQuestion

'### RearrangeableQuestion ###
class SingleChoiceQuestion {
  up_to: number = 1
}
SingleChoiceQuestion -up-|> MultipleChoiceQuestion 
class MultipleChoiceQuestion {
  up_to?: number
}
MultipleChoiceQuestion -up-|> RearrangeableQuestion
class PrioQuestion {}
PrioQuestion -up-|> RearrangeableQuestion
class LikertQuestion {
  questions: string[] <<serialized>>
}
LikertQuestion -up-|> RearrangeableQuestion

'##### SUBMISSIONS ######

class NumberSubmission {
  answer: number
}
NumberSubmission "*" --up- "1" NumberRangeQuestion

class MultipleNumberSubmission {
  answers: number[] <<serialized>>
}
MultipleNumberSubmission "*" --up- "1" RearrangeableQuestion

class StringSubmission {
  answer: string
}
StringSubmission "*" --up- "1" StringQuestion

'#### SUBMISSION CLONE #####

abstract class Submission_ <<clone>> {}
NumberSubmission -down-|> Submission_ 
MultipleNumberSubmission -down-|> Submission_ 
StringSubmission -down-|> Submission_
@enduml
-->

Testscript:
```rb
u = User.create(username: "user1", email: "user1@surveys.com")

s = u.surveys.create(name: "TestSurvey", fromDate: DateTime.now, toDate: DateTime.now)

# kein direktes s.questions.create(...) möglich, da sonst nicht klar ist, welcher Question-Typ generiert wird.
q1 = TextQuestion.create(optional: false, description: "Whats your name?")
s.questions.append(q1)

q2 = ColorQuestion.create(optional: true, description: "Whats yout favourite color?")
s.questions.append(q2)

```
