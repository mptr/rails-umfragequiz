# Rails UmfrageQuiz

## Klassendiagramm:

![](http://www.plantuml.com/plantuml/png/ZLLDJnin4BtxLup2eLAbe7AD8AMbKOK4uMF3eK8eSdQ7nC9hfrvleONyzzh60K-yHE60ulbuR-PvTdpSM6viMqlsQS__mS_HU7JzxQo0S6IibBnfuAP10yyC06ikv00QQuIQktFh78hN-6PQnOoYDN_mRyWXVe1xe-jfnQsp_N3_9w96PxLwmvOWpMhHD4Ah0gt7Amswc6hAxG1yf6kXNiBXuHmL6kyP3broABbtq8D-fHzL7tgVUnIgAoAMpMBrmPbd0cDyvlhXfOND6k5vnMXm035Ylh0EwY65OclHhsv6nUJqOXnLtylmhrhNPK1d07hfVt8vW9dM4hbojWgRqeZWIAuYjf7qw0fu1niuqRIfq7Z9CivnMy_GN7CrHqBlxsy0AdZ3nIM7nk9oVNJW5TxpLjgZWt0ZNO3zTjb_6SBwd1LnZTmOdy5dafR1LVE8PlegHhDk-lREqJPe19VYNsWBmELNRkH2f--QhHZ1thcY8l2ybx9Yr983TFB4aRXTYAf2TTVVmAMWUNI7bWmsnwbVt7oV_BeSlOuLy-wkHF3Es9mKJYJI7BN4vhheawaX2DIo0y9byU6ymH4Sa9dpXYzny4ZGYgKuMqY3Q4HzeiW4dspQ3Jb7M9eS4q-qr4G7Qg2ff1Woz9stv58adYoqAEatqIwdLc_8G8Cf-tahhLXctaX3lJdHrpMJOo6n6GzjYEfqQOHEPIBd7VBFn0CQIwhx7GzRjiAAaRmjJEcUTj_J-MbHa4sTZdrSxNH59IfbKVvfwNjglwExnvFUnGuyNSrsfsS5VD1zklWwgPCd9ukY3FcyKrtXvEnYF7eLTyihEtKjbb8h70xXETSrldOlGvAIgx0zFBQoFIn-id2g5cY4vQf4k1TFuMjz6wxziBttapnsZAfgQ_aV)

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
  random_order: boolean
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

'###  Inheritance fix ###
Question .right. Submission
@enduml
-->

