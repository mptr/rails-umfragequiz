# Rails UmfrageQuiz

## Klassendiagramm:

![](http://www.plantuml.com/plantuml/png/ZLHVRzem47_tfpZHXqcJyj3NgChQTMYgH85YU9YcQJBaIgqwCRETTHFbky-EqjH7S5SUKExkTx_xxqlhX75DfTY7i_23h-FfU74ruT2AZ6sKi1PM5Wti6G1MGgeSh3EotdgvyOPQLDYh3fq7Rynl_Dlw43l0lT7L5-6yAlmxMQ5NEarL4S-wajPANNDqWSq6XNDONhaSbXxgAwXs7j_cE3eVGLRgfpg3qSSHzKuWGfwiIxSr3Zs1CR7s1OYDW-EqO7zW14mYFCPCaCF5XJOb6YoBWhsq_6urvikRsRJh-TaWs5tZYmp-eNwz2vz2vR3MMg6elQv4kp6oDKI3w6iYwVHaD9bUtSARtN4N1abDcsgDPY7gBPBymdXpg5jhEzXUEB1JFfd2UvSz5trYWqWB5CO47x5MD9QexHEQMLkuVQdy-myVwRHFPkJsWGGR327Zgy_BR_CnXtZ_kP8bcjVO1qOreME1zaI1B6eNOI2QDnawYYN-SJ519nFtOv_fd9EOlPZqkDPAapof8k75VUCLNZzekQ4ZQdPBdSEv7mc5KBhRHZcv6rWxTceUyd-ALen01t78MXpNC3TInuKJ-Jq44_c8nf7qVdK2tKuAJ77J1VLxUNl3UVnEaDNgJfMU1hqzYWhtdONGuUJZHVaFDB6YP53lIAbj1C4d8oOw4zz58bJ_5b8CfIU7zIQI7aSO3PqCN4zcqp6SViLVIN_wbtUZT8r50VlXPBhN-haWBebUfU2aZWI8NM9TDfNw1m00)

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
