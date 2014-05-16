QAScene.prototype = Object.create(Scene.prototype);
QAScene.prototype.constructor = QAScene;
QAScene.prototype.m_qa = undefined;
QAScene.prototype.questionTF = undefined;
QAScene.prototype.aAnswerTF = undefined;
QAScene.prototype.bAnswerTF = undefined;
QAScene.prototype.cAnswerTF = undefined;
QAScene.prototype.dAnswerTF = undefined;

function QAScene()
{
    Scene.call(this);
    this.createQuestionTF();
    this.createAnswersTF();
}
QAScene.prototype.createQuestionTF = function ()
{
    this.questionTF = new createjs.Text("Question!", "50px Arial", "#ff7700");
    this.questionTF.textBaseline = "alphabetic";
    this.questionTF.x = 50;
    this.questionTF.y = 50;
    this.m_container.addChild(this.questionTF);
};
QAScene.prototype.createAnswersTF = function ()
{
    this.aAnswerTF = new createjs.Text("0", "20px Arial", "#ff7700");
    this.aAnswerTF.textBaseline = "alphabetic";
    this.aAnswerTF.index = 0;
    this.aAnswerTF.x = 70;
    this.aAnswerTF.y = 130;

    this.bAnswerTF = new createjs.Text("1", "20px Arial", "#ff7700");
    this.bAnswerTF.textBaseline = "alphabetic";
    this.bAnswerTF.index = 1;
    this.bAnswerTF.x = 250;
    this.bAnswerTF.y = 130;

    this.cAnswerTF = new createjs.Text("2", "20px Arial", "#ff7700");
    this.cAnswerTF.textBaseline = "alphabetic";
    this.cAnswerTF.index = 2;
    this.cAnswerTF.x = 70;
    this.cAnswerTF.y = 200;

    this.dAnswerTF = new createjs.Text("3", "20px Arial", "#ff7700");
    this.dAnswerTF.textBaseline = "alphabetic";
    this.dAnswerTF.index = 3;
    this.dAnswerTF.x = 250;
    this.dAnswerTF.y = 200;

    this.m_container.addChild(this.aAnswerTF);
    this.m_container.addChild(this.bAnswerTF);
    this.m_container.addChild(this.cAnswerTF);
    this.m_container.addChild(this.dAnswerTF);
};
QAScene.prototype.updateQA = function (qafile)
{
    this.m_qa = qafile;
    this.questionTF.text = qafile.m_question;
    var str1 = qafile.m_answers[0];
    this.aAnswerTF.text = qafile.m_answers[0];
    this.bAnswerTF.text = qafile.m_answers[1];
    this.cAnswerTF.text = qafile.m_answers[2];
    this.dAnswerTF.text = qafile.m_answers[3];
};
QAScene.prototype.getColorByIndex = function (id)
{
    var returned ="";
    switch (id)
    {
        case 0:
            returned = "green";
            break;
        case 1:
            returned = "blue";
            break;
        case 2:
            returned = "red";
            break;
        case 3:
            returned = "yellow";
            break;
        case 4:
            returned = "orange";
            break;
        case 5:
            returned = "gray";
            break;
        case 6:
            returned = "pink";
            break;
    }
    //console.log("MyColor: ", returned, this.m_index, id);
    return returned;
};
QAScene.prototype.showDisplay = function ()
{
    var circle = new createjs.Shape();
    circle.graphics.beginFill(this.getColorByIndex(this.m_index));
    circle.graphics.drawCircle(35,35,5);
    this.m_container.addChild(circle);
};