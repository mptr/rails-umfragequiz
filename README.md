# Rails UmfrageQuiz

## Klassendiagramm:

![](http://www.plantuml.com/plantuml/png/ZLLDJnin4BtlhnY5GwLAAvLh12ajZIea21yR3XL2aPCTWeNNJcrlQKlvxvqrJl4iZheSK3mVxysycRMFd1VMjuqgtkrrV_1rEfjUVJgj81oBOgM4St3jqC9J0O2Da6eCpbkfrtHkoQ55W_zCpp6ZQkqF_1Loc1_WpffcKGjFjY_qVouR9AitFLk2j6oaSzBe2ds7jx98CVL2-35qaTH2iu63WpLgj9rdCg7aKF9eVmHbRHvr2QFt8mwLZmXb5x7wpfd9XA8GI-f7h3pqQuIdvu871n0hr_UUe1vIg68h-kNrj9gVdC-Ywdjly2zRwZAWK_zcq_qKD8QbCGg59bkDRcLbS2IZY6qaFL81hs1Z4itO6csGhCyvQvibsYkXryZek_cDGGTl65noS1utsoE1rtWdMkKFzyD4Se1bkod_J61xVbF45GfhkmonLBmCeTqZsiMB66xRzCqjqJgqKYZvEsu2mnZCN0Myu8vZPPOCG9OdZlxcNjOrwjkoXyj0Cz4PpGhehqrPNN-UVxkOlgnFsAhiz3fdR4x96YrhZbbYSrdwP3iO0hCCGRYeTkuL7C8-swtEy84jM0mYNi8PG1f4O-epHURuqwVTi7E4vSanyTWemtJW1fxAYyaj39iIfIWylZTonNU_tIoywSd0WpdxMQkytBpnHXhcpH1zt38H2u_jy_26k4uNLffK9dOUa7yg7z1wLjrtElptw-TvkvdI-vY-fxEJgc8tShhsyGhdLr6YKZygF25bHntkuknwybaCuCaroz9t5h2h-_JYor8dJmkFwZDazfth2iUdvxCfv5-xLzG5jRXIHkDa0ayPNSEhHlDaAKo50U6ibLrXnH7gkctKNm00)

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
  answer: number[] <<serialized>>
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
