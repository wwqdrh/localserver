state.orm()
.table({"draw_question"})
.order({"RANDOM()"})
.limit({1})
.find({})
.exec("base", true)
