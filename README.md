# Rails UmfrageQuiz

## Klassendiagramm:

![](http://www.plantuml.com/plantuml/png/ZLJDRXen4BxxAKRqKAdI7d954KrAKHM9067XK5LLPLY7MF6kgUrjMb7UlRFJBfdrMeKz9CpFVD_yZEV61-b2NHhnzatpmQV9RBAydUP0eX1R8xs7jLSE3W90bLAR8VZWTBL3kKP39KjrKXt_HUIr-w5-KGote_ZeRFbH1bGrVuCk5Ig3xQeOpgRKtcjRvIeqQBvHXA2Asp245RfY1UKU_Id7mTK0iiA-L1aCtWswqMaFobFy_KV6H2G88JTOWDm6YDE2mr5qdGd4wTrJGAXd3WL3kBwshb1E5QEHQ7l-i9xagxlv39jENu_jeSOgYKi0s7tpK-8KDjOQ9IlK5SfldIO3cmGlYYgcT0YidqpCEQlBZN9BMUqKfwVn3Q4YAmsk5P0m5PCPzHYotwCJRuzfgQHpJOpSc2wNhFoBSdEgoxU5VVcAJEaOwdf45lKuozSVLfyNanpuVkT6OnzUkOyYqcJr7c5JJH6yNHo1D9SWj4cirC_00KYEmkEOsIBd8IYUYnXROnsF8SMvg1mRRzJuoUfjTqJrVeKRS8KZYLqut7rjWjxth2rwR8xmtxCLYrmZdkHQj2mBfoqldCcN0KpritAXazvt4kBjZ1oJsF62ubxUt-KvFmETrJfT4VuqM6DYBxfYMKDD1u1jnbdNz8hoGLsG4ZMYvvzcJ7U6luia5JjrtAS7pn_I_ptfBR3HH9E1yNG-cq3wIB-2ViF3kZMsKgCH71AJeMFSR0GFuRswm3sg8-aaRbHLrANv0m00)

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
  submittedAt: Timestamp
}
User "1" -down- "*" SubmissionSet
User "1" -down- "*" Survey
Survey "1" - "*" SubmissionSet 

abstract class Submission {}
SubmissionSet "1" -right- "k" Submission : <<ordered>>

'##### QUESTIONS ######

abstract class Question {
  optional: boolean
  description: string
}
Survey "1" -down- "k" Question : <<ordered>>

abstract class NumberRangeQuestion {
  from: number
  to: number
}
NumberRangeQuestion -left-|> Question

abstract class RearrangeableQuestion {
  answerOptions: string[]
}
RearrangeableQuestion -right-|> Question

'##### QUESTION-SUBTYPES ####

class SliderQuestion {}
SliderQuestion -up-|> NumberRangeQuestion
class NumberQuestion {}
NumberQuestion -up-|> NumberRangeQuestion

class TextQuestion {}
TextQuestion -up-|> Question

class NPSQuestion {}
NPSQuestion -up-|> Question

class ColorQuestion {}
ColorQuestion -up-|> Question

class SingleChoiceQuestion {
  upTo: 1
}
SingleChoiceQuestion -up-|> MultipleChoiceQuestion 

class MultipleChoiceQuestion {
  upTo?: number
}
MultipleChoiceQuestion -up-|> RearrangeableQuestion

class PrioQuestion {}
PrioQuestion -up-|> RearrangeableQuestion

class LikertQuestion {
  questions: string[]
}
LikertQuestion -up-|> RearrangeableQuestion

'##### SUBMISSIONS ######

class NumberSubmission {
  answer: number
}
NumberSubmission "*" --up- "1" NPSQuestion
NumberSubmission "*" --up- "1" NumberRangeQuestion

class MultipleNumberSubmission {
  answer: number[]
}
MultipleNumberSubmission "*" --up- "1" RearrangeableQuestion


class TextSubmission {
  answer: string
}
TextSubmission "*" --up- "1" TextQuestion
TextSubmission "*" --up- "1" ColorQuestion

'#### SUBMISSION CLONE #####

abstract class Submission_ <<clone>> {}
NumberSubmission -down-|> Submission_ 
MultipleNumberSubmission -down-|> Submission_ 
TextSubmission -down-|> Submission_
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