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
QAFile.prototype.setAnswers = function ()
{
    for (var i = 0; i < arguments.length; i++)
    {
        this.m_answers.push(arguments[i]);
    }
};