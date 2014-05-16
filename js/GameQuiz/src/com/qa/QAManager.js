QAManager.prototype.xmlObj = undefined;
QAManager.prototype.qaArray = [];
function QAManager(){}
QAManager.prototype.init = function (xmlref)
{
    this.xmlObj = xmlref;
    this.createQAs();
}
QAManager.prototype.createQAs = function ()
{
    if (this.xmlObj !== undefined)
    {
        this.scanIt(this.xmlObj);
        console.log("Oe", this.xmlObj.length);
        console.log("Node",this.xmlObj.childNodes.length);
        console.log("Oe Hah:", this.xmlObj.children[0].children.length);
        console.log("Oe Results:", this.xmlObj.getResult("qa_file", true));

        console.log("Oe Results:", this.xmlObj._loadedResults.length);
        //console.log("Ae", this.xmlObj.children[0].getElementsByTagName("id"));
        for (var i = 0; i < this.xmlObj.length; i++)
        {
            var m_qa = new QAFile();
            m_qa.setId(this.xmlObj.children[i].getElementsByTagName("id") );
            m_qa.setIndex(0);
            m_qa.setQuestion("0");
            m_qa.setAnswers("0");
            this.qaArray.push(m_qa);
        }
    }
};
QAManager.prototype.scanIt = function (xml)
{
    console.log("Scan IT", xml.children.length);
    for (var i = 0; i < xml.children.length ; i++)
    {
       console.log("Scan IT VAI", i,"de", xml.children.length);
       this.scanIt(xml.children[i]);
    }
};