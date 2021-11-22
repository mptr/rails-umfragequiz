# Rails UmfrageQuiz

## Klassendiagramm:

![](http://www.plantuml.com/plantuml/png/ZLHDRnen4BtxLup8eLAbFUIAq3OjHLKa0WJ3eQggoe13h7XjQdkRLeJ_Ng_bBXvsdOO3sh7Vl3SVCxwnZXbNLvAGTrVD3xvCPfFbnoc5O1AobSnQM5jku7YA5gtDB_u7ZWH0iOeFmJeZrDwR3qPNdvdpHys_Ft0wVfvzDvMmLcX5kVECWNbmFO1YfvzL0OFt0upfGyG8I0maN7OzWH2syQ6nhODByIOP14OAJoaJ364qqcR73T-LPLke-_M4hcxdirYfguxOVSsj2r84G1-QJoQ7iD5QSgRysOxRhH7XeYtXgSq9XzEIuM3Qum2l3vTLw0GrgwiDDqkczXp5rpHk22hSnhP5uqJwV0h97rpnKiR0UfIMd1dJ-B2Dn5fCsMTkvY5n-o_pRz-zKhzFOSJ-4OjTDg6Wwq-hhui9XNHggHI-K6Vj4y4dJSKyRLzHI58kn81FNcE852l-swK4o8xkbpwp1KMQYPdn66kfKPpe8ET5VU4b7pzgiSKjgWyhFOHhtn8CmNHtjNJYqBcDxF4wo_yX6R4CDEhWiRZ8OM64JXEFzji9fkA96uV2-naDF9q8cEN60-hdykwMqlITGACLLnMl1jezZ0hxNJJIOUMJoVWFD3EYg55l22aK0k6pYfdAf7kHaMhVGep1z6YnNaMYvGYjmPs1yNG-cq3_Atuc_G6ZqLPgnSiIZjtEnDVwfKGkcLhbu2YF38ZSSBMhA_aN)

<!--
@startuml
'##### GENERALS #####

class User {}
class Survey {
  name: string
  fromDate: Date
  to: Date
}
class SubmissionSet{}
User "1" -down- "*" SubmissionSet
User "1" -down- "*" Survey
Survey "1" - "*" SubmissionSet 

abstract class Submission {}
SubmissionSet "1" -down- "k" Submission : <<ordered>>

'##### QUESTIONS ######

abstract class Question {
  optional: boolean
  description: string
}
Survey "1" -down- "k" Question : <<ordered>>
Question "1" -up- "*" Submission

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
