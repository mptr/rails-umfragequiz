# Rails UmfrageQuiz

## Klassendiagramm:

![](http://www.plantuml.com/plantuml/png/ZLNVJzim47xtNt4g3vCcHHglLSbWh9gGeFn8UPWGcjpc00idpcndR2hzt-SOP_FLeGeFgFVZlk_kyyK-DfPhsrQIVJZe_k3RV36_EJalm9kChIKt1cuDQjWm0Aoua5CmLelwqTcj2zIymd-kRQWeMlqB__WQ4WTuqAhwogrpTV-jgD0vhQAk26TL2ME4gWkq7Phf7DPYUMAdi7IfReAgSVc-nydX1B9IlTGPJ3vEQFLGHkYJXNPzCAq4nlZA3S3N5dRRWisMqMGFeiNZatLGpp4KJ64sKxf4ZMMUirxpwzjviJoxN0JH3nAswzPDwRaOW6gwdrnEOQMKH5uxNubchOKFH2SHXeedTktqOBIPX7FHLYlKDxn-H4BV7TyKQX_r1nSPncBJcmwyn0VUIdjqwE2tR0WmQvliDOVUJfguGQvrLy5NahR1Q_E2-jAFRFgPx-uT3wqPorHuWFyKMqOzAS0WJpZukoTHbbZVPpku13JD7XATmUwQPCNjb-Ntg_dRklWj6Yg4BXY6aw94JOQZdZ3S47sq3GI1UaOWN1NlxX4SmI7PfSxnYInKIDeoXpE6r8j6r2UABF6tZQSXTe2bnQ7mL4b5TA0EKagR6LncSagkHEBfan9hkkjjirGxAj1SIdxHIYkQ91fOqYZX-TmJEP8abT3GSQXALrgeM2HYZwW_5y-eBMdkPp3enquJzqFttv7xV2xEYYA-SCcMX_kQtZIHBBjP_ht8Ecf_rGvk8zL-18-VBiqVOdnltFXY6-IAdWgIbJAa-qo5XDFpoyNyJSqzR-KFcCtMKjMOvx19XGolr6jEIeWA8zB3AFlJs37MPLl9lm00)

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
  step: number <<default=1>>
}
NumberRangeQuestion -up-|> Question

abstract class RearrangeableQuestion {
  answerOptions: string[]
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
  questions: string[]
}
LikertQuestion -up-|> RearrangeableQuestion

'##### SUBMISSIONS ######

class NumberSubmission {
  answer: number
}
NumberSubmission "*" --up- "1" NumberRangeQuestion

class MultipleNumberSubmission {
  answer: number[]
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