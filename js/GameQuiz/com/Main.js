var mf_stage;
var mf_canvas;
var mf_loader;
var xml_source = "assets/myData.xml";

function pageLoaded()
{
    //initLoad();
}
function initLoad()
{
    console.log("carrega porra!");
    mf_canvas = document.getElementById("mFckingStage");
    mf_stage = new createjs.Stage(mf_canvas);
    mf_stage.mouseEventsEnabled = true;
    createjs.Ticker.addEventListener("tick",handleTick);
    showCircle();
    createTxt();
    makeTestQAFile();
    initLoader();
}
function makeTestQAFile()
{
    var mf_QAFile = new QAFile();
    mf_QAFile.setAnswers("bla","ble","bli","blu");
    mf_QAFile.setId(0);
    mf_QAFile.setIndex(2);
    mf_QAFile.setQuestion("bla?");
}
function initLoader()
{
    mf_loader = new DataLoader();
    mf_loader.setXMLAdress(xml_source);
    mf_loader.setMain(this);
    mf_loader.setOnCompleteFunction(onXMLCompleteHandler);
    mf_loader.init();
}
function onXMLCompleteHandler(e)
{
    console.log("XML COMPLETE!");
}
function createTxt()
{
    var txt = new createjs.Text("v1", "20px Arial", "#FFFFFF");
    txt.x = 0;
    txt.y = 0;
    mf_stage.addChild(txt);
}
function handleTick(event)
{
    console.log("thick");
    mf_stage.update();
}
function showCircle()
{
    console.log("circle!");
    var circle = new createjs.Shape();
    circle.graphics.beginFill("green");
    circle.graphics.drawCircle(0,0,50);
    circle.x = 100;
    circle.y = 100;
    mf_stage.addChild(circle);
}