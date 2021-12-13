# Rails UmfrageQuiz

## Klassendiagramm:

![](http://www.plantuml.com/plantuml/png/ZLLDJniz4Bxlhx32uPLUQQLoZI2bfL651E5Zmw5223dP8LXuxQtjBMqf_xspKuTwDaPT3YYUZ-UPPsRMFl91kj0rklXlh_yJd-UB-TM7qqhGiIZMMdelhZquyLm80OrKUYfySCfiyDoXmyW6NaqlCQFgt3VuGJdCByIziyqd6T3K_m-g0JG6oqq9pgfHtYjhAWWzsje1njHtCap54YDHGDEAWuCD672zPpR3P2fuiZyHPMsVJ2ac_qyuL3w2YYvYxUJSpHH58LUeHgw36DOedbyA7amWJcqU0a8zfb35jkMNr_DgUNA-Y3tVsy6_x50beQD-s_O_9GvXPQq6QT1MWryxHOva4AaCqaW5l89DiMdMrU2ePKFEHTUim5r9iu6KdgOt5OQyDBVau0EqsoE2rt0lEnqEzsaYES2oQyjVizUITegu0kbSdo5NcfSXZNy2TqwI_LRppIsoUd1AQlKpBWA764jS4HwvurIP9GEGvOcJltbGTGtcjXpWCj1CTAPbXHXkJLbTVrn-kPZ_sHvQgkpmUcSKfrKDZecB5YukHvyi1qDWbZ485zMRQoKEnJwjLcfu5_UB1I4luemWfQQnxhEEBE5xIDN4CuFboJ7ns6hB-i0CF9KNmtOxEoLCqN3yODMQhtxNBksW2poMavzrEgXsnnjPThsCv_sM24c6ePmcAoUIN3XbqoQnyuZyK_K8Bh3YlkBXdzy-ptkRARsCyMiwEwagTXsdIn_lRtuF9LqQHj7xKVRKT15dbvEFOWHFJcm-VLZ0M-hJQozBdRuhB6h8aDbstbTnV7g-c8lyK_SNzGubhhKrC9k9vqnVwKd3UR8KreKHuKCfsR3Y24pTDVet)

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
