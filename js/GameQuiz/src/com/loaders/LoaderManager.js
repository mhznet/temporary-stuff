LoaderManager.prototype.m_queue  = undefined;
LoaderManager.prototype.m_data_json_file = undefined;
LoaderManager.prototype.m_asset_json_file = undefined;
LoaderManager.prototype.m_asset_img_file = [];
LoaderManager.prototype.m_asset_img_file_size = 0;
LoaderManager.prototype.m_main = undefined;
LoaderManager.prototype.qaArray = [];
LoaderManager.prototype.m_assetArray = [];
LoaderManager.prototype.jsonsLoaded = false;

function LoaderManager(mastermain)
{
    this.m_main = mastermain;
    this.init();
}
LoaderManager.prototype.init = function ()
{
    this.m_queue = new createjs.LoadQueue();
    this.m_queue.on("fileload", this.handleFileLoad, this);
    this.m_queue.on("complete", this.handleComplete, this);
    var qa_data = {id:"qadata", src:"assets/myData.json"};
    var qa_assets = {id:"qaassets", src:"assets/myAssets.json"};
    this.m_queue.loadFile(qa_data,false)
    this.m_queue.loadFile(qa_assets,false);
    this.m_queue.load();
};
LoaderManager.prototype.handleFileLoad = function (e)
{
    //console.log("LoaderManager: JSON handleFileLoad");
};
LoaderManager.prototype.handleComplete = function (e)
{
    if (this.jsonsLoaded === false)
    {
        this.jsonsLoaded = true;
        if (this.m_data_json_file === undefined)
        {
            this.m_data_json_file = this.m_queue.getResult("qadata");
            this.createQAs();
        }
        if (this.m_asset_json_file === undefined)
        {
            this.m_asset_json_file= this.m_queue.getResult("qaassets");
            this.beginLoadingAssets();
        }
        console.log("LoaderManager: JSON's handleComplete");
    }
    else if (this.jsonsLoaded === true)
    {
        console.log("Img's loaded.");
        this.createBMPs();
    }
};
LoaderManager.prototype.createQAs = function ()
{
    if (this.m_data_json_file !== undefined)
    {
        var main_obj = this.m_data_json_file.data.QA;
        var keys = Object.keys(main_obj);
        for (var j = 0; j < keys.length ; j++)
        {
            if (main_obj.hasOwnProperty("qa_file"+j))
            {
                var obj = main_obj["qa_file"+j];
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
    console.log("QA's number:",this.qaArray.length);
    //this.m_main.onQAReady();
};
LoaderManager.prototype.createBMPs = function ()
{
    for(var j = 0; j < this.m_asset_img_file_size;j++)
    {
        var img = this.m_queue.getItem("img"+j);
        var bmp = new createjs.Bitmap(img);
        this.m_assetArray.push(bmp);
    }
    console.log("IMG's carregadas:", this.m_assetArray.length);
    this.m_main.createScenes();
};
LoaderManager.prototype.beginLoadingAssets = function ()
{
    console.log("Sorting assets files");
    var main_obj = this.m_asset_json_file.assets;
    this.m_asset_img_file_size = Object.keys(main_obj).length;
    this.m_queue.removeAll();
    this.m_queue.close();
    var manifest =[];
    for(var i = 0; i < this.m_asset_img_file_size;i++)
    {
        if (main_obj.hasOwnProperty("img"+i))
        {
            var obj = main_obj["img"+i];
            var assetObj = {id:"img"+i, src:obj.src, type:createjs.LoadQueue.IMAGE};
            //console.log("Meu obj é", assetObj.id, assetObj.src, assetObj.type);
            manifest.push(assetObj);
        }
    }
    console.log("Tamanho:", manifest.length);
    this.m_queue.loadManifest(manifest, true);
};
LoaderManager.prototype.getBMPById = function (p_id)
{
    for (var i = 0; i < this.m_assetArray.length; i++)
    {
        var img = this.m_assetArray[i];
        if (img.image.id === p_id)
        {
            return img;
        }
    }
}