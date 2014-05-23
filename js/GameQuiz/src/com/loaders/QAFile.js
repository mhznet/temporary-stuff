function QAFile(){}
QAFile.prototype.m_id = undefined;
QAFile.prototype.m_index = undefined;
QAFile.prototype.m_question = undefined;
QAFile.prototype.m_answers = [];

QAFile.prototype.setId = function (id)
{
    this.m_id = id;
};
QAFile.prototype.setIndex = function (p_index)
{
    this.m_index = p_index;
};
QAFile.prototype.setQuestion = function (question)
{
    this.m_question = question;
};
QAFile.prototype.setAnswers = function (answerArray)
{
    this.m_answers = answerArray;
};
QAFile.prototype.traceItself = function ()
{
    console.log("ID", this.m_id);
    console.log("Question", this.m_question);
    for (var i = 0; i < this.m_answers.length; i++)
    {
        console.log("Answer", i,this.m_answers[i]);
    }
    console.log("Correct", this.m_index);
};