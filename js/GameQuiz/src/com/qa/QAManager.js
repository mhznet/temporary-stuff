QAManager.prototype.jsonObj = undefined;
QAManager.prototype.qaArray = [];
function QAManager(){}
QAManager.prototype.init = function (jsonref)
{
    this.jsonObj = jsonref;
    this.createQAs();
}
QAManager.prototype.createQAs = function ()
{
    if (this.jsonObj !== undefined)
    {
        var keys = Object.keys(this.jsonObj);
        for (var j = 0; j < keys.length ; j++)
        {
            //console.log(this.jsonObj.hasOwnProperty("qa_file"+j),"tnc", keys.length);
            if (this.jsonObj.hasOwnProperty("qa_file"+j))
            {
                var obj = this.jsonObj["qa_file"+j];
                var m_qa = new QAFile();
                m_qa.setId(j);
                m_qa.setIndex(obj["correct"]);
                m_qa.setQuestion(obj["question"]);
                m_qa.setAnswers([obj["a0"], obj["a1"], obj["a2"], obj["a3"]]);
                //m_qa.traceItself();
                this.qaArray.push(m_qa);
            }
        }
    }
    //console.log(this.qaArray.length, "é o numero de perguntas que tenho");
};