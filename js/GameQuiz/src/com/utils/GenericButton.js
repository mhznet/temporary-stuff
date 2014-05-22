GenericButton.prototype.m_container = undefined;
GenericButton.prototype.m_shape = undefined;
GenericButton.prototype.m_textfield = undefined;
GenericButton.prototype.m_text = undefined;
GenericButton.prototype.m_show_text = undefined;
GenericButton.prototype.m_width = undefined;
GenericButton.prototype.m_height = undefined;
GenericButton.prototype.m_parent = undefined;

function GenericButton(p_parent,p_width, p_height, p_text, p_show_text, interactable, clickFunction, overFunction, outFunction)
{
    if (p_parent === undefined)      console.log("ERROR: GENERICBUTTON PARENT UNDEFINED");
    if (p_width === undefined)      p_width = 50;
    if (p_height === undefined)     p_height = 50;
    if (p_text === undefined)       p_text = "TEXT";
    if (p_show_text === undefined)   p_show_text = true;
    if (interactable === undefined) interactable = false;
    if (clickFunction === undefined)clickFunction = this.handleClick;
    if (overFunction  == undefined) overFunction = this.handleOver;
    if (outFunction === undefined)  outFunction = this.handleOut;

    this.m_parent = p_parent;
    this.m_width = p_width;
    this.m_height = p_height;
    this.m_text = p_text;
    this.m_show_text = p_show_text;

    this.begin();
    if (interactable)
    {
        this.m_container.addEventListener("click",    clickFunction.context(this.m_parent));
        this.m_container.addEventListener("mouseover",overFunction.context(this.m_parent));
        this.m_container.addEventListener("mouseout", outFunction.context(this.m_parent));
    }
}
GenericButton.prototype.begin = function ()
{
    this.m_container = new createjs.Container();

    this.m_shape = new createjs.Shape();
    this.m_shape.graphics.beginFill("green").drawRect(0, 0, this.m_width, this.m_height);
    this.m_container.addChild(this.m_shape);

    if (this.m_show_text)
    {
        this.m_textfield = new createjs.Text(this.m_text, "10px Arial", "#ff7700");
        this.m_textfield.textBaseline = "alphabetic";
        //this.m_textfield.x = this.m_width * 0.5;
        this.m_textfield.y = this.m_height * 0.5;
        this.m_container.addChild(this.m_textfield);
    }
};
GenericButton.prototype.handleOut = function (e)
{
    document.body.style.cursor= "default";
};
GenericButton.prototype.handleOver = function (e)
{
    document.body.style.cursor = "pointer";
};