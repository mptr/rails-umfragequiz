# Rails UmfrageQuiz

## Klassendiagramm:

![](http://www.plantuml.com/plantuml/png/bLLDJnin4BtlhnY5GwLAAvLh12ajZIea21yR3XL2oCaEmSAxJcrlQPlot-kTEiNZcAxA0SNpyTwycLdxo3fXNDUeuirU_mUVfxFfrOVJ2kXO54ibh8LhYmOs1G0sGgenM6Tak_BdpZjQqU1VqtF8g3hp3NzG3lC3t1lTV1BEc_h_JZReZKvpKuIpQAIrKhSLkXvjQT37r7V2ZM7k8xs0PWq71ojiqVIUoSGdKy6Z_H6KjNvgInYz7N6eV0GLNOJQoRcR2KKX5bwDM3f8QuJDSy632SJ8rOFpK8ynLB5j-UNrj9gVdCz2p_Tsy2yxhvBGlNwzxdyAFuI5rWf5wsqrsgMHv8W64SaWZLJ02zZODqsR6WsrBEMSTSq2pPLeLnZJq_J6q9ANvXOThCFrzkZ1QxmNdNA7-pIH763PhSjV4zYUTuguGc5Cdo4MYfSXMlk4vfmaswtccrlFQj58eUJFi0XvY27YYl22cwQQM5A0F4-O_Cs3h6jiRyi4DmLDepCjAo3TchAw_ZZ_SZ7zipsqLDdXzSuWJiaQ3HD7baHSbZvQ3eQGM8OHBgfNrmeEOPzMApQyI_QBWZmluGoIKjDOzrb7vlZTnMhedC3ov91uh9LcVU06bigBORkTdP9FKNZyeEMIhtwtdkka2poMavzroidrZZUm9DwKv_sMo9EaePmcAoUGN1YfuoRH-J_oJ-KZ6iUA-qg7WMy_v0qpHPUn_vhEJggANSVnqeVxczz3KPVIA7e_ofwQBkBiSl9H_8F7ReboQjFyV0MloO_llIntzB3mg9GXi-wyiN1yUZwRGlwjUq6zynANIhSucS0cqrXwq_n0MGhlmd1uAYKRLXnXMtUD-Wq0)

<!--
@startuml
'##### GENERALS #####

class User {
  email: string
  username: string
}
class Survey {
  name: string
  fromDate: Datetime
  toDate: Datetime
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
  answerOptions: string[] <<serialized>>
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
  upTo: number = 1
}
SingleChoiceQuestion -up-|> MultipleChoiceQuestion 
class MultipleChoiceQuestion {
  upTo?: number
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
