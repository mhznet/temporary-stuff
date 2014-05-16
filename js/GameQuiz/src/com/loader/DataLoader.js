DataLoader.prototype.xmlData   = undefined;
DataLoader.prototype.loader    = undefined;
DataLoader.prototype.xmlSource = undefined;
DataLoader.prototype.mf_main   = undefined;
DataLoader.prototype.mf_onComplete = undefined;

function DataLoader(mmmain, urrele, oncompleto)
{
    mf_main = mmmain;
    this.xmlSource = urrele;
    DataLoader.mf_onComplete = oncompleto;
}
DataLoader.prototype.setXMLAdress = function (xmlSrc)
{
    this.xmlSource = xmlSrc;
};
DataLoader.prototype.init = function ()
{
    this.loader = new createjs.LoadQueue(true);
    this.loader.on("fileload", this.handleFileLoad);
    this.loader.on("complete", DataLoader.handleComplete);
    if (this.xmlSource !== undefined)
    {
        this.loader.loadFile(this.xmlSource);
        console.log(this.xmlSource,"AQUI");
    }
    else
    {
        alert("XML Address not filled in DataLoader.js");
    }
};
DataLoader.prototype.handleComplete = function (e)
{
    this.xmlData = e.currentTarget._loadedRawResults;
    //this.mf_onComplete();
    this.mf_onComplete();
    //mf_main.onXMLComplete();
    console.log("agora foi");
}
DataLoader.prototype.handleFileLoad = function (e)
{
    console.log("XML FILE LOAD START!");
}