function DataLoader(){}
DataLoader.prototype.main = undefined;
DataLoader.prototype.xmlData = undefined;
DataLoader.prototype.loader = undefined;
DataLoader.prototype.xmlSource = undefined;
DataLoader.prototype.onComplete = undefined;
DataLoader.prototype.setMain = function (mainJS)
{
    this.main = mainJS;
};
DataLoader.prototype.setXMLAdress = function (xmlSrc)
{
    this.xmlSource = xmlSrc;
};
DataLoader.prototype.setOnCompleteFunction = function (onComp)
{
    this.onComplete = onComp;
    console.log("OnCompleteSet",this.onComplete);
}
DataLoader.prototype.init = function ()
{
    this.loader = new createjs.LoadQueue(true);
    this.loader.on("fileload", this.handleFileLoad);
    this.loader.on("complete", this.handleComplete);
    if (this.xmlSource !== undefined)
    {
        this.loader.loadFile(this.xmlSource);
    }
    else
    {
        alert("XML Address not filled in DataLoader.js");
    }
};
DataLoader.prototype.handleComplete = function (e)
{
     this.xmlData = e.currentTarget._loadedRawResults;
     this.onComplete(this.xmlData);
};
DataLoader.prototype.handleFileLoad = function (e)
{
    console.log("XML FILE LOAD START!");
};