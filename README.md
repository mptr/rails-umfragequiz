# Rails UmfrageQuiz

## Klassendiagramm:

![](http://www.plantuml.com/plantuml/png/ZLHDRnen4BtxLup8eLAbFUIAq3OjHLKa0WJ3eQggoi24MF7QrFOshGZ_lSPoWeVTJS81hSTltfkF6LyvBwolAyK-N1n_y6qq6Sq_Zpd48sDh9Po3fKCBUmQ0bP2g3yvRgRVXN8SBBIfyCHsI1w_j7_mNVSWzm9qrrLVXW-du7mpUfC-JxwgIpacZEVhzWKNrtcKFYervr0NqFlOefWsH8c0fa7ZPz0J6n2g49jOUpiKXI1CmKNZ8cQ0FWu6n6xIuAKlsNCpRvOWlhgUJLCsBXjXjZSv7AGPWTiTF4SgxCaQXqC6sGRUsCbva9KuvqN1EP3IO5tE4rxlpAZI2cjJL2krSw2tcySN6zK77szIsT3YmDfz2uPqldieKM8lI78MrHn-nKbHBQFU8TXeJTy-P__WPbDfz2YktzqIiqOI2Bxyiliz67FB9vag6Gfsq3unQOiK2RKk2B2iNOQ2MrnWInGB_-fo0d9FxkSzanebcTkpm61fbI9pKqE75G-4L3k-DNDCMrRk5wSDbQ0c5KBgRMdcvQzmczkOrvV-KZLW3IdJEnuBaCBFIv8cJyti8nl81hIVX_Ku7EfqKsCbD1ZJCvSqrv-ITo4ShhIfT3Rfx11NtkpXAnvNF9kCDQCU8aaQz8wHOY4uyLUoeJBONhLBPMqWnb9uirkj8iWknDQGpC1nF9oDeVyLFfBzWC5Whex4iOT_iJ7gjdqhYqbMh3ZZ9emF4hb1lwahz1m00)

<!--
@startuml
'##### GENERALS #####

class User {
  email: string
  username: string
}
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
