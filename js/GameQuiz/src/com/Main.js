var canvas;
var stag;
var sce_manager;
var dta_manager;
var mahLoader;
Function.prototype.context = function(context)
{
    var action = this;
    return function()
    {
        return action.apply(context, arguments);
    };
}
function Main ()
{
    canvas = document.getElementById("myCanv");
    stag = new createjs.Stage(this.canvas);
    stag.enableMouseOver();
    sce_manager = new SceneManager(this.stag);
    beginDataLoader();
    //createTestScenes();
    //createBtns();
}
function beginDataLoader ()
{
    mahLoader = new DataLoader(this,"assets/myData.xml");
    mahLoader.init();
};
function onXMLComplete (xmlObj)
{
    dta_manager = new QAManager();
    dta_manager.init(xmlObj);
    console.log("TUDO CERTO CHAMPS", xmlObj);
};
function createBtns  ()
{
    for (var i = 0; i < 2; i++)
    {
        var shape = new createjs.Shape();//200x100
        var init_x;
        i == 0 ? init_x = 10 : init_x = 100;
        shape.graphics.beginFill("green").drawRect(init_x,80,30,20);
        shape.myInitX = init_x;
        shape.name = i;
        shape.buttonmode = true;
        shape.addEventListener("click",this.handleClick);
        shape.addEventListener("mouseover",this.handleOver);
        shape.addEventListener("mouseout",this.handleOut);
        this.stag.addChild(shape);
        this.stag.update();
    }
};
function handleOut (e)
{
    document.body.style.cursor= "default";
    var m_initial_x = e.currentTarget.myInitX;
    //console.log("initX", m_initial_x, e.currentTarget.name);
    e.currentTarget.graphics.clear().beginFill("green").drawRect(m_initial_x,80,30,20);
    this.stag.update();
};
function handleOver (e)
{
    document.body.style.cursor = "pointer";
    var m_initial_x = e.currentTarget.myInitX;
    //console.log("initX", m_initial_x, e.currentTarget.name);
    e.currentTarget.graphics.clear().beginFill("black").drawRect(m_initial_x,80,30,20);
    this.stag.update();
};
function handleClick (e)
{
    if (e.nativeEvent.button === 0)
    {
        if (e.currentTarget.name === 1)
        {
            this.sce_manager.nextScene();
        }
        else if (e.currentTarget.name === 0)
        {
            this.sce_manager.previousScene();
        }
    }
    //console.log(e.currentTarget.name, e.nativeEvent.button);
};
function createTestScenes ()
{
    //var qa = new QAFile();
    //qa.setId(0);
    //qa.setAnswers("Bla", "Ble","Bli","Blu");
    //qa.setIndex(0);
    //qa.setQuestion("Bla?");

    var qa2 = new QAFile();
    qa2.setId(1);
    qa2.setAnswers("Quack","Mooo","Baeehh","Woof");
    qa2.setIndex(2);
    qa2.setQuestion("Ram goes...?");

    var m_scene = new QAScene();
    this.sce_manager.addScenes(m_scene);
    m_scene.updateQA(qa2);
    m_scene.showDisplay();

    this.stag.update();
};